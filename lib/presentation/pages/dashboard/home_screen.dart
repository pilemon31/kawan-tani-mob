import 'package:flutter/material.dart';
import 'package:flutter_kawan_tani/presentation/controllers/auth/login_controller.dart';
import 'package:flutter_kawan_tani/presentation/controllers/weather/weather_controller.dart';
import 'package:flutter_kawan_tani/presentation/pages/profile/profile_screen.dart';
import 'package:flutter_kawan_tani/presentation/widgets/navbar/navbar.dart';
import 'package:flutter_kawan_tani/presentation/widgets/weather/weather_card.dart';
import 'package:flutter_kawan_tani/shared/theme.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_kawan_tani/presentation/controllers/profile/profile_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LoginController controller = Get.put(LoginController());
  final ProfileController profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                  top: 140, bottom: 100, left: 10, right: 10),
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
                        const SizedBox(height: 12),
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
                                        imagePath:
                                            "assets/kelembapan_image.jpg",
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Tanamanmu",
                              style: GoogleFonts.poppins(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.offNamed("/plants");
                              },
                              child: Text(
                                "Lihat Semua",
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF78D14D),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: Container(
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
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "36 hari menuju panen",
                                  style:
                                      GoogleFonts.poppins(color: Colors.grey),
                                ),
                                const SizedBox(height: 12),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  margin: EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                  ),
                                  child: Row(
                                    children: [
                                      PhosphorIcon(PhosphorIconsBold.drop,
                                          size: 24),
                                      SizedBox(width: 10),
                                      Text("Siram tanaman",
                                          style: GoogleFonts.poppins(
                                              fontSize: 16, fontWeight: bold)),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  margin: EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                  ),
                                  child: Row(
                                    children: [
                                      PhosphorIcon(PhosphorIconsBold.drop,
                                          size: 24),
                                      SizedBox(width: 10),
                                      Text("Siram tanaman",
                                          style: GoogleFonts.poppins(
                                              fontSize: 16, fontWeight: bold)),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  margin: EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                  ),
                                  child: Row(
                                    children: [
                                      PhosphorIcon(PhosphorIconsBold.drop,
                                          size: 24),
                                      SizedBox(width: 10),
                                      Text("Siram tanaman",
                                          style: GoogleFonts.poppins(
                                              fontSize: 16, fontWeight: bold)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Informasi Workshop",
                              style: GoogleFonts.poppins(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.offNamed("/workshops");
                              },
                              child: Text(
                                "Lihat Semua",
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF78D14D),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            "assets/workshops.png",
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Berita Terkini",
                              style: GoogleFonts.poppins(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.offNamed("/articles");
                              },
                              child: Text(
                                "Lihat Semua",
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF78D14D),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            "assets/article.png",
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
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
              padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
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
                        "Selamat Pagi, ",
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontSize: 16),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(() => ProfileScreen());
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
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
                      ),
                    ],
                  ),
                  Obx(
                    () => Text(
                      '${profileController.user['firstName']} ${profileController.user['lastName']}👋',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    "Kamis, 19 Juni 2025",
                    style: GoogleFonts.poppins(
                        color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Navbar(),
    );
  }
}
