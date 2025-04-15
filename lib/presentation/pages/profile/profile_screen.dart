import 'package:flutter/material.dart';
import 'package:flutter_kawan_tani/presentation/pages/profile/profile_edit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 27),
          child: AppBar(
            backgroundColor: Colors.white,
            toolbarHeight: 80,
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: PhosphorIcon(
                  PhosphorIconsBold.arrowLeft,
                  size: 32.0,
                )),
          ),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Judul utama
              Text(
                'Pengaturan',
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 32),

              // Section: Akun
              Text(
                'Akun',
                style: GoogleFonts.poppins(
                    fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              // Item: Info Personal
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: PhosphorIcon(
                  PhosphorIconsBold.user,
                  size: 28.0,
                ),
                title: Text(
                  'John Doe',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                subtitle: Text(
                  'Info Personal',
                  style: GoogleFonts.poppins(),
                ),
                trailing: Icon(PhosphorIcons.arrowRight(), size: 28),
                onTap: () {
                  Get.to(() => ProfileEdit());
                },
              ),

              // Item: Riwayat Artikel
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: PhosphorIcon(
                  PhosphorIconsBold.clockCounterClockwise,
                  size: 28.0,
                ),
                title: Text(
                  'Artikel',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                subtitle: Text(
                  'Riwayat Artikel',
                  style: GoogleFonts.poppins(),
                ),
                trailing: Icon(PhosphorIcons.arrowRight(), size: 28),
                onTap: () {
                },
              ),

              // Item: Riwayat Seminar
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: PhosphorIcon(
                  PhosphorIconsBold.clockCounterClockwise,
                  size: 28.0,
                ),
                title: Text(
                  'Seminar',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                subtitle: Text(
                  'Riwayat Seminar',
                  style: GoogleFonts.poppins(),
                ),
                trailing: Icon(PhosphorIcons.arrowRight(), size: 28),
                onTap: () {
                },
              ),

              const SizedBox(height: 32),

              // Section: Pengaturan
              Text(
                'Pengaturan',
                style: GoogleFonts.poppins(
                    fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              // Item: Bahasa
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: PhosphorIcon(
                  PhosphorIconsBold.translate,
                  size: 28.0,
                ),
                title: Text(
                  'Bahasa',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                subtitle: Text(
                  'Bahasa Indonesia',
                  style: GoogleFonts.poppins(),
                ),
                trailing: Icon(PhosphorIcons.arrowRight(), size: 28),
                onTap: () {
                },
              ),


              // Item: Notifikasi
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: PhosphorIcon(
                  PhosphorIconsBold.bell,
                  size: 28.0,
                ),
                title: Text(
                  'Notifikasi',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                trailing: Icon(PhosphorIcons.arrowRight(), size: 28),
                onTap: () {
                },
              ),

              // Item: Bantuan
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: PhosphorIcon(
                  PhosphorIconsBold.info,
                  size: 28.0,
                ),
                title: Text(
                  'Notifikasi',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                trailing: Icon(PhosphorIcons.arrowRight(), size: 28),
                onTap: () {
                },
              ),
            ],
          ),
        ),
      )),
    );
  }
}
