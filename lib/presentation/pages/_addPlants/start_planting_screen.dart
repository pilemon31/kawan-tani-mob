import 'package:flutter/material.dart';
import 'package:flutter_kawan_tani/presentation/pages/dashboard/home_screen.dart';
import 'package:flutter_kawan_tani/presentation/pages/_addPlants/filter_plants_screen.dart';
import 'package:flutter_kawan_tani/presentation/pages/_addPlants/start_planting_detail_screen.dart';
import 'package:flutter_kawan_tani/presentation/widgets/navbar/navbar.dart';
import 'package:flutter_kawan_tani/shared/theme.dart';
import 'package:flutter_kawan_tani/presentation/controllers/plants/plant_controller.dart';
import 'package:flutter_kawan_tani/models/plant_model.dart';
import "package:get/get.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class StartPlantingScreen extends StatefulWidget {
  const StartPlantingScreen({super.key});

  @override
  State<StartPlantingScreen> createState() => _StartPlantingScreenState();
}

class _StartPlantingScreenState extends State<StartPlantingScreen> {
  final PlantController plantController = Get.put(PlantController());

  @override
  void initState() {
    super.initState();
    plantController.fetchPlants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 27),
          child: AppBar(
            backgroundColor: whiteColor,
            toolbarHeight: 80.0,
            leading: IconButton(
              onPressed: () {
                Get.to(() => HomeScreen());
              },
              icon: PhosphorIcon(
                PhosphorIconsBold.arrowLeft,
                size: 32.0,
              ),
            ),
            title: Padding(
              padding: EdgeInsets.all(0),
              child: Text(
                'Mulai Bertanam',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  color: blackColor,
                  fontWeight: bold,
                ),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Get.to(() => FilterPlantsScreen());
                },
                icon: PhosphorIcon(
                  PhosphorIconsFill.dotsThreeOutlineVertical,
                  size: 32.0,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Obx(() {
          if (plantController.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          }

          if (plantController.plants.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PhosphorIcon(
                    PhosphorIcons.plant(),
                    size: 64,
                    color: greyColor,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Tidak ada tanaman tersedia',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: greyColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      plantController.fetchPlants();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                    ),
                    child: Text(
                      'Muat Ulang',
                      style: GoogleFonts.poppins(
                        color: whiteColor,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return GridView.builder(
            itemCount: plantController.plants.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemBuilder: (context, index) {
              final Plant plant = plantController.plants[index];
              return InkWell(
                onTap: () async {
                  // Pass the plant data to detail screen
                  await plantController.getPlantById(plant.id);
                  Get.to(() => StartPlantingDetailScreen(),
                      arguments: plantController.selectedPlant.value);
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: greyColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 130,
                        height: 75,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: greyColor.withOpacity(0.2),
                        ),
                        child: plant.imageUrl != null &&
                                plant.imageUrl!.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  'https://kawan-tani-backend-production.up.railway.app/uploads/plants/${plant.imageUrl!}',
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: greyColor.withOpacity(0.2),
                                      ),
                                      child: Center(
                                        child: PhosphorIcon(
                                          PhosphorIcons.plant(),
                                          size: 32,
                                          color: greyColor,
                                        ),
                                      ),
                                    );
                                  },
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                        color: primaryColor,
                                        strokeWidth: 2,
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Center(
                                child: PhosphorIcon(
                                  PhosphorIcons.plant(),
                                  size: 32,
                                  color: greyColor,
                                ),
                              ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              plant.name,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: blackColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              children: [
                                PhosphorIcon(
                                  PhosphorIcons.clock(),
                                  size: 17.0,
                                  color: blackColor,
                                ),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    _formatDuration(plant.plantingDuration),
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: blackColor,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              plant.category?.name ?? 'Tanaman',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: greyColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(() => const StartPlantingDetailScreen(),
                                arguments: plantController.selectedPlant.value);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            minimumSize: Size(double.infinity, 35),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            "Lihat detail",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: semiBold,
                              color: whiteColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
      bottomNavigationBar: Navbar(),
    );
  }

  String _formatDuration(int days) {
    if (days < 30) {
      return '$days hari';
    } else if (days < 365) {
      double months = days / 30;
      if (months == months.floor()) {
        return '${months.floor()} bulan';
      } else {
        return '${months.toStringAsFixed(1)} bulan';
      }
    } else {
      double years = days / 365;
      return '${years.toStringAsFixed(1)} tahun';
    }
  }
}
