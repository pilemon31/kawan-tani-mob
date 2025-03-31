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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(100.0),
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 27),
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
                  title: Padding(
                      padding: EdgeInsets.all(0),
                      child: Text(
                        'Cabai',
                        style: GoogleFonts.poppins(
                            fontSize: 20, color: blackColor, fontWeight: bold),
                      )),
                ))),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 27),
          child: ListView(
            children: [
              Text(
                "Tugas Harian",
                style: GoogleFonts.poppins(fontSize: 22, fontWeight: bold),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    PhosphorIcon(PhosphorIconsBold.drop, size: 24),
                    SizedBox(width: 10),
                    Text("Siram tanaman",
                        style: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: bold)),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    PhosphorIcon(PhosphorIconsBold.drop, size: 24),
                    SizedBox(width: 10),
                    Text("Siram tanaman",
                        style: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: bold)),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                margin: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    PhosphorIcon(PhosphorIconsBold.drop, size: 24),
                    SizedBox(width: 10),
                    Text("Siram tanaman",
                        style: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: bold)),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  Text(
                    "Cek Kondisi",
                    style: GoogleFonts.poppins(fontSize: 22, fontWeight: bold),
                  ),
                  Text(
                      "Tidak ada pengecekan hari ini",
                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: light),
                  ),
                ],
              )
            ],
          ),
        ),
        bottomNavigationBar: Navbar());
  }
}
