import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_kawan_tani/presentation/controllers/profile/profile_controller.dart';
import 'package:flutter_kawan_tani/presentation/pages/profile/profile_edit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_kawan_tani/shared/theme.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  final ProfileController _controller = Get.find();

  Future<void> _goToEdit() async {
    final result = await Get.to(() => ProfileEdit());

    if (result == 'updated') {
      await _controller.refreshProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_controller.user.isEmpty && !_controller.isLoading.value) {
        _controller.loadInitialData();
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 27),
          child: AppBar(
            backgroundColor: Colors.white,
            toolbarHeight: 80.0,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: PhosphorIcon(
                PhosphorIconsBold.arrowLeft,
                size: 32.0,
              ),
            ),
            title: Text(
              'Profil Saya',
              style: GoogleFonts.poppins(
                fontSize: 20,
                color: blackColor,
                fontWeight: bold,
              ),
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (_controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_controller.errorMessage.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _controller.errorMessage.value,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: blackColor,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _controller.loadInitialData(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    elevation: 0.0,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Coba Lagi',
                    style: GoogleFonts.poppins(
                      color: whiteColor,
                      fontWeight: medium,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        final user = _controller.user;

        return RefreshIndicator(
          onRefresh: () async {
            await _controller.refreshProfile();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21),
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(height: 10),
                Text(
                  'Informasi Profil',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: blackColor,
                    fontWeight: bold,
                  ),
                ),
                Text(
                  'Kelola dan perbarui informasi profil Anda',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: greyColor,
                    fontWeight: medium,
                  ),
                ),
                SizedBox(height: 20),

                // Avatar Section
                Center(
                  child: Column(
                    children: [
                      _buildAvatar(),
                      const SizedBox(height: 16),
                      Text(
                        '${user['firstName'] ?? ''} ${user['lastName'] ?? ''}',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: bold,
                          color: blackColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Form-like Info Display
                _buildInfoField(
                    'Nama Depan', user['firstName'], PhosphorIcons.user()),
                SizedBox(height: 20),

                _buildInfoField(
                    'Nama Belakang', user['lastName'], PhosphorIcons.user()),
                SizedBox(height: 20),

                _buildInfoField(
                    'Email', user['email'], PhosphorIcons.envelope()),
                SizedBox(height: 20),

                _buildInfoField(
                    'Nomor HP', user['phoneNumber'], PhosphorIcons.phone()),
                SizedBox(height: 20),

                _buildInfoField(
                  'Tanggal Lahir',
                  (user['dateOfBirth']?.toString().split('T')[0]) ?? '-',
                  PhosphorIcons.calendar(),
                ),
                SizedBox(height: 20),

                _buildGenderField(user['gender']),
                SizedBox(height: 28),

                // Action Buttons
                ElevatedButton(
                  onPressed: _goToEdit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    elevation: 0.0,
                    shadowColor: Colors.transparent,
                    minimumSize: Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Edit Profil',
                    style: GoogleFonts.poppins(
                        color: whiteColor, fontSize: 16, fontWeight: bold),
                  ),
                ),
                SizedBox(height: 18),

                ElevatedButton(
                  onPressed: () {
                    _controller.refreshProfile();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: whiteColor,
                      elevation: 0.0,
                      shadowColor: Colors.transparent,
                      minimumSize: Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      side: BorderSide(color: primaryColor)),
                  child: Text(
                    'Refresh Data',
                    style: GoogleFonts.poppins(
                        color: primaryColor, fontSize: 16, fontWeight: bold),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildAvatar() {
    final avatarUrl = _controller.getAvatarUrl();

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: CircleAvatar(
        radius: 50,
        backgroundColor: Color(0xffE7EFF2),
        child: avatarUrl.isNotEmpty
            ? ClipOval(
                child: CachedNetworkImage(
                  imageUrl: avatarUrl,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  placeholder: (context, url) {
                    return Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Color(0xffE7EFF2),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Color(0xffE7EFF2),
                        shape: BoxShape.circle,
                      ),
                      child: PhosphorIcon(
                        PhosphorIcons.user(),
                        size: 60,
                        color: Color(0xff8594AC),
                      ),
                    );
                  },
                  httpHeaders: {
                    'User-Agent': 'FlutterApp',
                  },
                ),
              )
            : Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Color(0xffE7EFF2),
                  shape: BoxShape.circle,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PhosphorIcon(
                      PhosphorIcons.user(),
                      size: 60,
                      color: Color(0xff8594AC),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildInfoField(String label, String? value, PhosphorIconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 15, color: blackColor),
        ),
        SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
          decoration: BoxDecoration(
            color: Color(0xffE7EFF2),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            children: [
              PhosphorIcon(
                icon,
                size: 19.0,
                color: Color(0xff8594AC),
              ),
              SizedBox(width: 15),
              Expanded(
                child: Text(
                  value ?? '-',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: blackColor,
                    fontWeight: medium,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGenderField(dynamic gender) {
    final isMale = gender == 1;
    final isFemale = gender == 2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Jenis Kelamin",
          style: GoogleFonts.poppins(fontSize: 15, color: blackColor),
        ),
        SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                decoration: BoxDecoration(
                  color: isMale ? Color(0x00ffffff) : Color(0xffE7EFF2),
                  borderRadius: BorderRadius.circular(8),
                  border: isMale ? Border.all(color: Color(0xffE7EFF2)) : null,
                ),
                child: Center(
                  child: Text(
                    "Laki-Laki",
                    style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: isMale ? Color(0xff4993F8) : Color(0xff8594AC),
                        fontWeight: isMale ? medium : light),
                  ),
                ),
              ),
            ),
            SizedBox(width: 18),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                decoration: BoxDecoration(
                  color: isFemale ? Color(0x00ffffff) : Color(0xffE7EFF2),
                  borderRadius: BorderRadius.circular(8),
                  border:
                      isFemale ? Border.all(color: Color(0xffE7EFF2)) : null,
                ),
                child: Center(
                  child: Text(
                    "Perempuan",
                    style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: isFemale ? Color(0xffF99D9D) : Color(0xff8594AC),
                        fontWeight: isFemale ? medium : light),
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
