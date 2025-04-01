import 'package:flutter/material.dart';
import 'package:flutter_kawan_tani/presentation/widgets/navbar/navbar.dart';
import 'package:flutter_kawan_tani/shared/theme.dart';
import "package:get/get.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class PlantsTasksScreen extends StatefulWidget {
  const PlantsTasksScreen({super.key});

  @override
  State<PlantsTasksScreen> createState() => _PlantsTasksScreenState();
}

class _PlantsTasksScreenState extends State<PlantsTasksScreen> {
  int selectedDay = 2;

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
              'Detail Tugas',
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
                    children: List.generate(7, (index) {
                      int day = index + 1;
                      bool isSelected = day == selectedDay;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedDay = day;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: isSelected ? Color(0xFF78D14D) : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.grey.shade400),
                          ),
                          child: Center(
                            child: Text(
                              "$day",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isSelected ? Colors.white : blackColor,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Tugas Harian
            Text(
              "Tugas Harian",
              style: GoogleFonts.poppins(fontSize: 22, fontWeight: bold),
            ),
            const SizedBox(height: 10),
            // Item tugas harian langsung tanpa fungsi
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
      bottomNavigationBar: const Navbar(),
    );
  }
}
