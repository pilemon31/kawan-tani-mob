import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_kawan_tani/presentation/controllers/profile/profile_controller.dart';
import 'package:flutter_kawan_tani/presentation/pages/profile/profile_edit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          'Profil Saya',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: PhosphorIcon(PhosphorIcons.pencil()),
            onPressed: _goToEdit,
          ),
          IconButton(
            icon: PhosphorIcon(PhosphorIcons.arrowClockwise()),
            onPressed: () {
              _controller.refreshProfile();
            },
          ),
        ],
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
                Text(_controller.errorMessage.value),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _controller.loadInitialData(),
                  child: const Text('Coba Lagi'),
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
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              children: [
                _buildAvatar(),
                const SizedBox(height: 16),
                Text(
                  '${user['firstName'] ?? ''} ${user['lastName'] ?? ''}',
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                _buildInfoCard('Email', user['email']),
                _buildInfoCard('No HP', user['phoneNumber']),
                _buildInfoCard(
                  'Tanggal Lahir',
                  (user['dateOfBirth']?.toString().split('T')[0]) ?? '-',
                ),
                _buildInfoCard(
                  'Jenis Kelamin',
                  _getGenderText(user['gender']),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildAvatar() {
    final avatarUrl = _controller.getAvatarUrl();
    final user = _controller.user;

    print('🖼️ [DEBUG] _buildAvatar called');
    print('🖼️ [DEBUG] Avatar URL: $avatarUrl');
    print('🖼️ [DEBUG] User avatar value: ${user['avatar']}');
    print('🖼️ [DEBUG] Avatar URL is empty: ${avatarUrl.isEmpty}');

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
        backgroundColor: Colors.grey.shade300,
        child: avatarUrl.isNotEmpty
            ? ClipOval(
                child: CachedNetworkImage(
                  imageUrl: avatarUrl,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  placeholder: (context, url) {
                    print('🔄 [DEBUG] Loading avatar: $url');
                    return Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    );
                  },
                  errorWidget: (context, url, error) {
                    print('❌ [DEBUG] Error loading avatar: $url');
                    print('❌ [DEBUG] Error details: $error');
                    return Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.white,
                      ),
                    );
                  },
                  httpHeaders: {
                    // Tambahkan headers jika diperlukan
                    'User-Agent': 'FlutterApp',
                  },
                ),
              )
            : Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  shape: BoxShape.circle,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.person, size: 60, color: Colors.white),
                    // Debug text
                    if (kDebugMode)
                      Text(
                        'No Avatar',
                        style: TextStyle(
                          fontSize: 8,
                          color: Colors.grey[600],
                        ),
                      ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildInfoCard(String label, String? value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: GoogleFonts.poppins(
                    fontSize: 13, color: Colors.grey.shade600)),
            const SizedBox(height: 4),
            Text(
              value ?? '-',
              style: GoogleFonts.poppins(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  String _getGenderText(dynamic gender) {
    if (gender == 1) return 'Laki-laki';
    if (gender == 2) return 'Perempuan';
    return 'Tidak diketahui';
  }
}
