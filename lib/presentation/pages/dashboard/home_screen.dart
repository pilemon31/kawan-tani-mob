import 'package:flutter/material.dart';
import 'package:flutter_kawan_tani/presentation/controllers/weather/weather_controller.dart';
import 'package:flutter_kawan_tani/presentation/widgets/navbar/navbar.dart';
import 'package:flutter_kawan_tani/presentation/widgets/weather/weather_card.dart';
import 'package:flutter_kawan_tani/shared/theme.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 140, bottom: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Mojokerto, Jawa Timur",
                          style: GoogleFonts.poppins(
                              fontSize: 20, fontWeight: semiBold),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 150,
                                  height: 150,
                                  child: Obx(() => WeatherCard(
                                        title: "Kelembapan",
                                        value: WeatherController()
                                            .temperature
                                            .value,
                                        imagePath: "assets/suhu_image.jpg",
                                      )),
                                ),
                                const SizedBox(width: 30),
                                SizedBox(
                                  width: 150,
                                  height: 150,
                                  child: Obx(() => WeatherCard(
                                        title: "Suhu",
                                        value: WeatherController()
                                            .temperature
                                            .value,
                                        imagePath: "assets/suhu_image.jpg",
                                      )),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tanamanmu",
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Lemon Malang",
                                style: GoogleFonts.poppins(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "36 hari menuju panen",
                                style: GoogleFonts.poppins(color: Colors.grey),
                              ),
                              const SizedBox(height: 8),
                              ElevatedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.water_drop,
                                    color: Colors.white),
                                label: Text("Siram tanaman",
                                    style: GoogleFonts.poppins()),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF78D14D)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Informasi Workshop",
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Image.asset("assets/suhu_image.jpg", fit: BoxFit.cover),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Berita Terkini",
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Image.asset("assets/suhu_image.jpg", fit: BoxFit.cover),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 135,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xFF78D14D),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Selamat Pagi",
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontSize: 16),
                      ),
                      Container(
                        padding: const EdgeInsets.all(
                            8), 
                        decoration: const BoxDecoration(
                          color: Colors.white24, 
                          shape: BoxShape.circle,
                        ),
                        child: PhosphorIcon(
                          PhosphorIcons.gear(),
                          size: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Pilemon B. 👋",
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Sabtu, 11 Januari 2025",
                    style: GoogleFonts.poppins(
                        color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const Navbar(),
    );
  }
}
