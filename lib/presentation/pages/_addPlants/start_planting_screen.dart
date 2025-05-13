import 'package:flutter/material.dart';
import 'package:flutter_kawan_tani/presentation/pages/dashboard/home_screen.dart';
import 'package:flutter_kawan_tani/presentation/pages/_addPlants/filter_plants_screen.dart';
import 'package:flutter_kawan_tani/presentation/pages/_addPlants/start_planting_detail_screen.dart';
import 'package:flutter_kawan_tani/presentation/widgets/navbar/navbar.dart';
import 'package:flutter_kawan_tani/shared/theme.dart';
import "package:get/get.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class StartPlantingScreen extends StatefulWidget {
  const StartPlantingScreen({super.key});

  @override
  State<StartPlantingScreen> createState() => _StartPlantingScreenState();
}

class _StartPlantingScreenState extends State<StartPlantingScreen> {
  // Tambahkan list tanaman di bagian atas State class
  final List<Map<String, dynamic>> plants = [
    {
      "name": "Cabai Rawit",
      "image": "assets/chili.jpg",
      "duration": "3 bulan",
      "type": "Sayuran"
    },
    {
      "name": "Tomat Ceri",
      "image": "assets/tomato.jpg",
      "duration": "2.5 bulan",
      "type": "Buah"
    },
    {
      "name": "Kangkung",
      "image": "assets/kangkung.jpg",
      "duration": "1 bulan",
      "type": "Sayuran"
    },
    {
      "name": "Stroberi",
      "image": "assets/strawberry.jpg",
      "duration": "4 bulan",
      "type": "Buah"
    },
    {
      "name": "Basil",
      "image": "assets/basil.jpg",
      "duration": "2 bulan",
      "type": "Herbal"
    },
    {
      "name": "Terong Ungu",
      "image": "assets/eggplant.jpg",
      "duration": "3.5 bulan",
      "type": "Sayuran"
    },
  ];
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
                            fontSize: 20, color: blackColor, fontWeight: bold),
                      )),
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
                ))),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: GridView.builder(
            itemCount: plants.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemBuilder: (context, index) {
              final plant = plants[index];
              return InkWell(
                onTap: () {
                  Get.to(() => StartPlantingDetailScreen());
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
                          image: DecorationImage(
                            image: AssetImage(plant["image"]),
                            fit: BoxFit.cover,
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
                                  plant["name"],
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: blackColor,
                                  ),
                                ),
                                Row(
                                  children: [
                                    PhosphorIcon(PhosphorIcons.clock(),
                                        size: 17.0, color: blackColor),
                                    const SizedBox(width: 5),
                                    Text(
                                      plant["duration"],
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: blackColor,
                                      ),
                                    ),
                                  ],
                                ),
                                                                    Text(
                                      plant["type"], // Jenis tanaman
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: greyColor,
                                      ),
                                    ),
                              ])),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ElevatedButton(
                            onPressed: () {
                              Get.to(() => const StartPlantingDetailScreen());
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              minimumSize: Size(double.infinity, 35),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            child: Text(
                              "Lihat detail",
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: semiBold,
                                  color: whiteColor),
                            ),
                          )),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        bottomNavigationBar: Navbar());
  }
}
