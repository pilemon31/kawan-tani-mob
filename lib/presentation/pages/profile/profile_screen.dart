import 'package:flutter/material.dart';
import 'package:flutter_kawan_tani/presentation/pages/article/saved_article_list.dart';
import 'package:flutter_kawan_tani/presentation/pages/profile/profile_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_kawan_tani/presentation/controllers/profile/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 70,
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: PhosphorIcon(
                PhosphorIconsBold.arrowLeft,
                size: 28,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'Pengaturan',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle('Akun'),
                const SizedBox(height: 8),
                Obx(() => _buildSettingItem(
                      icon: PhosphorIconsBold.user,
                      title: profileController.user.isNotEmpty
                          ? '${profileController.user['firstName']} ${profileController.user['lastName']}'
                          : 'Profil Saya',
                      subtitle: 'Info Personal',
                      onTap: () => Get.to(() => ProfileView()),
                    )),
                _buildSettingItem(
                  icon: PhosphorIconsBold.clockCounterClockwise,
                  title: 'Artikel',
                  subtitle: 'Artikel Disimpan',
                  onTap: () => Get.to(() => SavedArticleList()),
                ),
                _buildSettingItem(
                  icon: PhosphorIconsBold.clockCounterClockwise,
                  title: 'Seminar',
                  subtitle: 'Riwayat Seminar',
                  onTap: () {},
                ),
                const SizedBox(height: 24),
                _buildSectionTitle('Pengaturan'),
                const SizedBox(height: 8),
                _buildSettingItem(
                  icon: PhosphorIconsBold.translate,
                  title: 'Bahasa',
                  subtitle: 'Bahasa Indonesia',
                  onTap: () {},
                ),
                _buildSettingItem(
                  icon: PhosphorIconsBold.bell,
                  title: 'Notifikasi',
                  onTap: () {},
                ),
                _buildSettingItem(
                  icon: PhosphorIconsBold.info,
                  title: 'Bantuan',
                  onTap: () {},
                ),
                const Divider(height: 40),
                _buildSettingItem(
                  icon: PhosphorIconsBold.signOut,
                  title: 'Keluar',
                  iconColor: Colors.redAccent,
                  textColor: Colors.redAccent,
                  onTap: () => profileController.logout(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.grey[800],
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    String? subtitle,
    Color? iconColor,
    Color? textColor,
    required VoidCallback onTap,
  }) {
    return Card(
      color: Colors.white,
      elevation: 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: PhosphorIcon(
          icon,
          size: 26,
          color: iconColor ?? Colors.black87,
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: textColor ?? Colors.black87,
          ),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle,
                style: GoogleFonts.poppins(fontSize: 13),
              )
            : null,
        trailing: Icon(PhosphorIcons.arrowRight(), size: 22),
        onTap: onTap,
      ),
    );
  }
}
