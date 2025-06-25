import 'package:flutter/material.dart';
import 'package:flutter_kawan_tani/presentation/controllers/plants/user_plant_controller.dart';
import 'package:flutter_kawan_tani/presentation/pages/_yourPlants/your_plants_tasks_screen.dart';
import 'package:flutter_kawan_tani/presentation/widgets/navbar/navbar.dart';
import 'package:flutter_kawan_tani/shared/theme.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class YourPlantsScreen extends StatefulWidget {
  const YourPlantsScreen({super.key});

  @override
  State<YourPlantsScreen> createState() => _YourPlantsScreenState();
}

class _YourPlantsScreenState extends State<YourPlantsScreen> {
  final UserPlantController userPlantController =
      Get.put(UserPlantController());

  @override
  void initState() {
    super.initState();
    userPlantController.fetchUserPlants();
  }

  Future<void> _refreshData() async {
    await userPlantController.fetchUserPlants();
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
                'Tanaman Saya',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  color: blackColor,
                  fontWeight: bold,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (userPlantController.isLoading.value) {
          return Center(
              child: CircularProgressIndicator(
            color: primaryColor,
          ));
        }

        if (userPlantController.userPlants.isEmpty) {
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
                  'Anda belum memiliki tanaman. Mari tanam sesuatu!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: greyColor,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    userPlantController.fetchUserPlants(); // Retry fetching
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                  ),
                  child: Text(
                    'Muat Ulang',
                    style: GoogleFonts.poppins(color: whiteColor),
                  ),
                ),
              ],
            ),
          );
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 27),
          child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 21);
            },
            itemCount: userPlantController.userPlants.length,
            itemBuilder: (BuildContext context, int index) {
              final userPlant = userPlantController.userPlants[index];
              return InkWell(
                onTap: () async {
                  // Navigate and await the result, then refresh if needed
                  final result = await Get.to(() => YourPlantsTasksScreen(),
                      arguments: userPlant.id);
                  if (result == true) {
                    _refreshData(); // Refresh the list if a task was updated or plant finished
                  }
                },
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffC3C6D4)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: greyColor.withOpacity(0.2),
                          image: userPlant.plant.imageUrl != null &&
                                  userPlant.plant.imageUrl!.isNotEmpty
                              ? DecorationImage(
                                  image: NetworkImage(
                                      'https://kawan-tani-backend-production.up.railway.app/uploads/plants/${userPlant.plant.imageUrl}'),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: userPlant.plant.imageUrl == null ||
                                userPlant.plant.imageUrl!.isEmpty
                            ? Center(
                                child: PhosphorIcon(
                                  PhosphorIcons.plant(),
                                  size: 32,
                                  color: greyColor,
                                ),
                              )
                            : null,
                      ),
                      SizedBox(height: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            // Display customName and current progress
                            "${userPlant.customName} (${userPlant.progress.toStringAsFixed(0)}%)",
                            style: GoogleFonts.poppins(
                                fontSize: 20, fontWeight: bold),
                          ),
                          SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              PhosphorIcon(
                                PhosphorIconsRegular.clock,
                                size: 17.0,
                              ),
                              SizedBox(width: 5),
                              Text(
                                // Calculate days remaining from planting date to target harvest date
                                "${userPlant.targetHarvestDate.difference(userPlant.plantingDate).inDays} Hari hingga panen",
                                style: GoogleFonts.poppins(fontSize: 12),
                              )
                            ],
                          ),
                          SizedBox(height: 4),
                          if (userPlant.status !=
                              'selesai') // Only show button if not finished
                            ElevatedButton(
                              onPressed: () async {
                                // Navigate to tasks screen to update tasks
                                final result = await Get.to(
                                    () => YourPlantsTasksScreen(),
                                    arguments: userPlant.id);
                                if (result == true) {
                                  _refreshData(); // Refresh the list after returning
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF78D14D),
                                minimumSize: Size(double.infinity, 30),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              child: Text(
                                "Selesaikan Tugas Harian",
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: semiBold,
                                    color: Colors.white),
                              ),
                            ),
                          if (userPlant.status ==
                              'selesai') // Show finished status
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.green.shade100,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                'Selesai!',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.green.shade700,
                                  fontWeight: semiBold,
                                ),
                              ),
                            )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
      bottomNavigationBar: Navbar(),
    );
  }
}
