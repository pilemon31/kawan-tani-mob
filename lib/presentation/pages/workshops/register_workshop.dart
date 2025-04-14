import 'package:flutter/material.dart';
import 'package:flutter_kawan_tani/shared/theme.dart';
import "package:get/get.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class RegisterWorkshop extends StatefulWidget {
  const RegisterWorkshop({super.key});

  @override
  State<RegisterWorkshop> createState() => _RegisterWorkshopState();
}

class _RegisterWorkshopState extends State<RegisterWorkshop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              'Cabaiku Tani',
              style: GoogleFonts.poppins(
                fontSize: 20,
                color: blackColor,
                fontWeight: bold,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 21),
        child: ListView(
          children: [
            Text(
              'Detail Pendaftaran',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: blackColor,
                fontWeight: bold,
              ),
            ),
            Text(
              'Detail kontak ini akan digunakan untuk pengisian data diri dan pengiriman e-tiket workshop',
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: greyColor,
                fontWeight: medium,
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Column(
                children: [
                  Text(
                    "Hari",
                    style: GoogleFonts.poppins(fontSize: 20, fontWeight: bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Text(
              "Tugas Harian",
              style: GoogleFonts.poppins(fontSize: 22, fontWeight: bold),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  PhosphorIcon(PhosphorIconsBold.drop, size: 24),
                  const SizedBox(width: 10),
                  Text(
                    "Siram tanaman",
                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: bold),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  PhosphorIcon(PhosphorIconsBold.drop, size: 24),
                  const SizedBox(width: 10),
                  Text(
                    "Siram tanaman",
                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: bold),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  PhosphorIcon(PhosphorIconsBold.drop, size: 24),
                  const SizedBox(width: 10),
                  Text(
                    "Siram tanaman",
                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Cek Kondisi",
                  style: GoogleFonts.poppins(fontSize: 22, fontWeight: bold),
                ),
                const SizedBox(height: 5),
                Text(
                  "Tidak ada pengecekan hari ini",
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.w300),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
