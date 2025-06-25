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
import 'package:flutter_kawan_tani/presentation/controllers/plants/user_plant_controller.dart';
import 'package:flutter_kawan_tani/presentation/controllers/articles/article_controller.dart';
import 'package:flutter_kawan_tani/presentation/controllers/workshop/workshop_controller.dart';
import 'package:flutter_kawan_tani/presentation/pages/workshops/workshop_detail.dart';
import 'package:flutter_kawan_tani/presentation/pages/article/article_detail.dart';

import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LoginController loginController = Get.put(LoginController());
  final ProfileController profileController = Get.put(ProfileController());
  final WeatherController weatherController = Get.put(WeatherController());
  final UserPlantController userPlantController =
      Get.put(UserPlantController());
  final ArticleController articleController = Get.put(ArticleController());
  final WorkshopController workshopController = Get.put(WorkshopController());

  @override
  void initState() {
    super.initState();
    weatherController.fetchWeatherData();
    userPlantController.fetchUserPlants();
    articleController.fetchArticles();
    workshopController.fetchActiveWorkshops();
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return "Selamat Pagi";
    } else if (hour < 18) {
      return "Selamat Siang";
    } else {
      return "Selamat Malam";
    }
  }

  String _formatDate(DateTime date) {
    return DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(date);
  }

  String _formatPlantDuration(int days) {
    if (days < 30) {
      return '$days hari';
    } else if (days < 365) {
      double months = days / 30;
      return '${months.toStringAsFixed(0)} bulan';
    } else {
      double years = days / 365;
      return '${years.toStringAsFixed(1)} tahun';
    }
  }

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
                  // --- Weather Section ---
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() => Text(
                              weatherController.location.value,
                              style: GoogleFonts.poppins(
                                  fontSize: 20, fontWeight: semiBold),
                            )),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Obx(() => SizedBox(
                                  width: 150,
                                  height: 150,
                                  child: WeatherCard(
                                    title: "Kelembapan",
                                    value: weatherController
                                            .isLoadingWeather.value
                                        ? '...'
                                        : "${weatherController.humidity.value.toStringAsFixed(0)}%",
                                    imagePath: "assets/kelembapan_image.jpg",
                                  ),
                                )),
                            Obx(() => SizedBox(
                                  width: 150,
                                  height: 150,
                                  child: WeatherCard(
                                    title: "Suhu",
                                    value: weatherController
                                            .isLoadingWeather.value
                                        ? '...'
                                        : "${weatherController.temperature.value.toStringAsFixed(0)}°C",
                                    imagePath: "assets/suhu_image.jpg",
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // --- Your Plants Section ---
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
                                Get.toNamed("/plants");
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
                        Obx(() {
                          if (userPlantController.isLoading.value) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (userPlantController.userPlants.isEmpty) {
                            return Center(
                              child: Text(
                                'Belum ada tanaman yang ditanam.',
                                style: GoogleFonts.poppins(color: greyColor),
                              ),
                            );
                          }
                          return Column(
                            children: userPlantController.userPlants
                                .take(2)
                                .map((plant) {
                              return Container(
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
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: primaryColor.withOpacity(0.1),
                                        image: plant.plant.imageUrl != null &&
                                                plant.plant.imageUrl!.isNotEmpty
                                            ? DecorationImage(
                                                image: NetworkImage(
                                                    'https://kawan-tani-backend-production.up.railway.app/uploads/plants/${plant.plant.imageUrl}'),
                                                fit: BoxFit.cover,
                                              )
                                            : null,
                                      ),
                                      child: plant.plant.imageUrl == null ||
                                              plant.plant.imageUrl!.isEmpty
                                          ? Center(
                                              child: PhosphorIcon(
                                                  PhosphorIcons.leaf(),
                                                  size: 24,
                                                  color: primaryColor),
                                            )
                                          : null,
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            plant.customName,
                                            style: GoogleFonts.poppins(
                                                fontSize: 16, fontWeight: bold),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            "${_formatPlantDuration(plant.targetHarvestDate.difference(plant.plantingDate).inDays)} menuju panen",
                                            style: GoogleFonts.poppins(
                                                color: Colors.grey,
                                                fontSize: 12),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      "${plant.progress.toStringAsFixed(0)}%",
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: semiBold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          );
                        }),
                      ],
                    ),
                  ),

                  // --- Workshops Section ---
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
                                Get.toNamed("/workshops");
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
                        Obx(() {
                          if (workshopController.isLoading.value) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (workshopController.activeWorkshops.isEmpty) {
                            return Center(
                              child: Text(
                                'Tidak ada workshop aktif.',
                                style: GoogleFonts.poppins(color: greyColor),
                              ),
                            );
                          }
                          return Column(
                            children: workshopController.activeWorkshops
                                .take(1)
                                .map((workshop) {
                              return GestureDetector(
                                onTap: () async {
                                  await workshopController
                                      .fetchWorkshopById(workshop.idWorkshop);
                                  Get.to(() => const WorkshopDetail());
                                },
                                child: Stack(
                                  alignment: Alignment.bottomLeft,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        workshop.gambarWorkshop.isNotEmpty
                                            ? 'https://kawan-tani-backend-production.up.railway.app/uploads/workshops/${workshop.gambarWorkshop}'
                                            : 'https://placehold.co/600x200/cccccc/ffffff?text=No+Image',
                                        width: double.infinity,
                                        height: 200,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Container(
                                            width: double.infinity,
                                            height: 200,
                                            decoration: BoxDecoration(
                                              color: greyColor.withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Center(
                                              child: PhosphorIcon(
                                                  PhosphorIcons.wrench(),
                                                  size: 64,
                                                  color: greyColor),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 200,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.transparent,
                                            Colors.black.withOpacity(0.7),
                                          ],
                                          stops: const [0.6, 1.0],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            workshop.judulWorkshop,
                                            style: GoogleFonts.poppins(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          );
                        }),
                      ],
                    ),
                  ),

                  // --- Articles Section ---
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
                                Get.toNamed("/articles");
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
                        Obx(() {
                          if (articleController.isLoading.value) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (articleController.articles.isEmpty) {
                            return Center(
                              child: Text(
                                'Tidak ada artikel tersedia.',
                                style: GoogleFonts.poppins(color: greyColor),
                              ),
                            );
                          }
                          return Column(
                            children: articleController.articles
                                .take(1)
                                .map((article) {
                              return GestureDetector(
                                onTap: () {
                                  articleController.setSelectedArticle(article);
                                  Get.to(() => const ArticleDetail());
                                },
                                child: Stack(
                                  alignment: Alignment.bottomLeft,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        article.imageUrl.isNotEmpty
                                            ? 'https://kawan-tani-backend-production.up.railway.app/uploads/articles/${article.imageUrl}'
                                            : 'https://placehold.co/600x200/cccccc/ffffff?text=No+Image',
                                        width: double.infinity,
                                        height: 200,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Container(
                                            width: double.infinity,
                                            height: 200,
                                            decoration: BoxDecoration(
                                              color: greyColor.withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Center(
                                              child: PhosphorIcon(
                                                  PhosphorIcons.newspaper(),
                                                  size: 64,
                                                  color: greyColor),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Container(
                                      // Overlay untuk gradasi dan teks
                                      width: double.infinity,
                                      height:
                                          200, // Harus sama dengan tinggi gambar
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.transparent,
                                            Colors.black.withOpacity(0.7),
                                          ],
                                          stops: const [0.6, 1.0],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            article.title,
                                            style: GoogleFonts.poppins(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            'Oleh ${article.author}',
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: Colors.white70,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          );
                        }),
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
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF78D14D),
                    Color(0xFF349107),
                  ],
                ),
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
                        _getGreeting(),
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
                      profileController.user['firstName']?.isNotEmpty == true
                          ? '${profileController.user['firstName']} ${profileController.user['lastName']} 👋'
                          : 'Pengguna 👋',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    _formatDate(DateTime.now()),
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
