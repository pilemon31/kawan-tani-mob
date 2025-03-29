import 'package:flutter/material.dart';
import 'package:flutter_kawan_tani/presentation/widgets/navbar/navbar.dart';
import 'package:flutter_kawan_tani/shared/theme.dart';
import "package:get/get.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class StartPlantingDetailScreen extends StatefulWidget {
  const StartPlantingDetailScreen({super.key});

  @override
  State<StartPlantingDetailScreen> createState() =>
      _StartPlantingDetailScreenState();
}

class _StartPlantingDetailScreenState extends State<StartPlantingDetailScreen> {
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
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  "assets/apple.jpg",
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Cabai",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.poppins(fontSize: 26, fontWeight: bold),
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      PhosphorIcon(
                        PhosphorIcons.clock(),
                        size: 32.0,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "6 bulan hingga panen",
                        style: GoogleFonts.poppins(
                            fontSize: 14, fontWeight: light),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      PhosphorIcon(
                        PhosphorIcons.chartLine(),
                        size: 32.0,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Permintaan pasar: Tinggi",
                        style: GoogleFonts.poppins(
                            fontSize: 14, fontWeight: light),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      PhosphorIcon(
                        PhosphorIcons.briefcase(),
                        size: 32.0,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      RichText(
                        text: TextSpan(
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: light,
                            color: blackColor,
                          ),
                          children: [
                            TextSpan(text: 'Alat yang diperlukan: '),
                            TextSpan(
                              text:
                                  'Cangkul, Sekop,\nPupuk, Penyiram tanaman, Alat ukur\ntanaman',
                              style: TextStyle(
                                  color: Color(
                                      0xFF78D14D)), // Warna hijau untuk bagian ini
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Deskripsi",
                    style: GoogleFonts.poppins(fontSize: 22, fontWeight: bold),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Tanaman cabai (Capsicum spp.) adalah tanaman berbunga yang termasuk dalam keluarga Solanaceae. Tanaman ini memiliki batang tegak dengan daun berbentuk oval dan berwarna hijau. Cabai tumbuh dalam bentuk buah yang bervariasi, mulai dari yang kecil hingga besar, dan dapat berwarna merah, hijau, kuning, atau oranye saat matang. Tanaman cabai dikenal dengan rasa pedas yang disebabkan oleh senyawa capsaicin. Biasanya, cabai digunakan sebagai bahan masakan, bumbu, atau bahkan obat tradisional. Tanaman ini tumbuh dengan baik di daerah tropis dan subtropis.",
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Tugas Harian",
                    style: GoogleFonts.poppins(fontSize: 22, fontWeight: bold),
                  ),
                  Text(
                    "Lihat Detail",
                    style: GoogleFonts.poppins(fontSize: 12, fontWeight: light, color:  Color(0xFF78D14D)),
                  ),
                ],
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
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF78D14D),
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: Text(
                  "Beli alat dan bahan",
                  style: GoogleFonts.poppins(
                      fontSize: 18, fontWeight: semiBold, color: Colors.white),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF78D14D),
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: Text(
                  "Mulai tanam",
                  style: GoogleFonts.poppins(
                      fontSize: 18, fontWeight: semiBold, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Navbar());
  }
}
