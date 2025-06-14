import 'package:flutter/material.dart';
import 'package:flutter_kawan_tani/presentation/controllers/plants/user_plant_controller.dart';
import 'package:flutter_kawan_tani/presentation/widgets/navbar/navbar.dart';
import 'package:flutter_kawan_tani/shared/theme.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class YourPlantsTasksScreen extends StatefulWidget {
  const YourPlantsTasksScreen({super.key});

  @override
  State<YourPlantsTasksScreen> createState() => _YourPlantsTasksScreenState();
}

class _YourPlantsTasksScreenState extends State<YourPlantsTasksScreen> {
  final UserPlantController userPlantController =
      Get.find<UserPlantController>();
  late String userPlantId;
  int selectedDay = 1;

  @override
  void initState() {
    super.initState();
    // Get the userPlantId from arguments
    userPlantId = Get.arguments as String;

    // Fetch user plant detail and daily tasks
    _loadData();
  }

  Future<void> _loadData() async {
    await userPlantController.getUserPlantDetail(userPlantId);
    await userPlantController.fetchDailyTasksAndUpdate(userPlantId);

    // Set initial selected day to the first available day
    if (userPlantController.selectedUserPlant.value.plantingDays.isNotEmpty) {
      setState(() {
        selectedDay =
            userPlantController.selectedUserPlant.value.plantingDays.first.day;
      });
    }
  }

  double calculateProgress() {
    final selectedUserPlant = userPlantController.selectedUserPlant.value;
    return selectedUserPlant.progress / 100.0; // Convert percentage to decimal
  }

  double calculateDayProgress(int day) {
    final plantingDay = userPlantController.selectedUserPlant.value.plantingDays
        .firstWhereOrNull((d) => d.day == day);

    if (plantingDay == null) return 0.0;
    return plantingDay.dayProgress / 100.0; // Convert percentage to decimal
  }

  List<int> getAvailableDays() {
    return userPlantController.selectedUserPlant.value.plantingDays
        .map((day) => day.day)
        .toList()
      ..sort();
  }

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
            title: Obx(() => Text(
                  userPlantController
                          .selectedUserPlant.value.customName.isNotEmpty
                      ? userPlantController.selectedUserPlant.value.customName
                      : 'Tanaman Saya',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: blackColor,
                    fontWeight: bold,
                  ),
                )),
          ),
        ),
      ),
      body: Obx(() {
        if (userPlantController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final selectedUserPlant = userPlantController.selectedUserPlant.value;
        final availableDays = getAvailableDays();
        final currentDayData = selectedUserPlant.plantingDays
            .firstWhereOrNull((d) => d.day == selectedDay);

        if (selectedUserPlant.id.isEmpty) {
          return const Center(
            child: Text('Data tanaman tidak ditemukan'),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21),
          child: ListView(
            children: [
              // Overall Progress
              Text(
                'Progress Keseluruhan: ${selectedUserPlant.progress.toStringAsFixed(0)}%',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: blackColor,
                  fontWeight: bold,
                ),
              ),
              const SizedBox(height: 6),
              LinearProgressIndicator(
                value: calculateProgress(),
                color: primaryColor,
                backgroundColor: Colors.grey.shade300,
                minHeight: 10,
                borderRadius: BorderRadius.circular(10),
              ),
              const SizedBox(height: 20),

              // Plant Info
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      selectedUserPlant.plant.name,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: bold,
                      ),
                    ),
                    Text(
                      'Status: ${selectedUserPlant.status}',
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                    Text(
                      'Tanggal Tanam: ${selectedUserPlant.plantingDate.day}/${selectedUserPlant.plantingDate.month}/${selectedUserPlant.plantingDate.year}',
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Day Selection
              if (availableDays.isNotEmpty) ...[
                Center(
                  child: Column(
                    children: [
                      Text(
                        "Hari",
                        style:
                            GoogleFonts.poppins(fontSize: 20, fontWeight: bold),
                      ),
                      const SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: availableDays.map((day) {
                            bool isSelected = day == selectedDay;
                            final dayData = selectedUserPlant.plantingDays
                                .firstWhereOrNull((d) => d.day == day);
                            bool hasCompletedTasks = dayData?.completedTasks ==
                                    dayData?.totalTasks &&
                                dayData != null &&
                                dayData.totalTasks > 0;

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedDay = day;
                                });
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? primaryColor
                                      : hasCompletedTasks
                                          ? Colors.green.shade100
                                          : Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: hasCompletedTasks
                                          ? Colors.green
                                          : Colors.grey.shade400),
                                ),
                                child: Center(
                                  child: Text(
                                    "$day",
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: isSelected
                                          ? Colors.white
                                          : blackColor,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
              ],

              // Day Progress and Phase Info
              if (currentDayData != null) ...[
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: primaryColor.withOpacity(0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hari ke-${currentDayData.day} - ${currentDayData.phase}',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Progress Hari: ${currentDayData.dayProgress.toStringAsFixed(0)}%',
                        style: GoogleFonts.poppins(fontSize: 14),
                      ),
                      const SizedBox(height: 5),
                      LinearProgressIndicator(
                        value: currentDayData.dayProgress / 100,
                        color: primaryColor,
                        backgroundColor: Colors.grey.shade300,
                        minHeight: 6,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Tugas Selesai: ${currentDayData.completedTasks}/${currentDayData.totalTasks}',
                        style: GoogleFonts.poppins(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],

              // Daily Tasks
              Text(
                "Tugas Harian",
                style: GoogleFonts.poppins(fontSize: 22, fontWeight: bold),
              ),
              const SizedBox(height: 10),

              if (currentDayData != null && currentDayData.tasks.isNotEmpty)
                ...currentDayData.tasks.map((task) {
                  return GestureDetector(
                    onTap: userPlantController.isUpdating.value
                        ? null
                        : () async {
                            await userPlantController.updateTaskProgress(
                              userPlantId: userPlantId,
                              taskId: task.id,
                              doneStatus: !task.isCompleted,
                            );
                          },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 12),
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade300),
                        color: task.isCompleted ? primaryColor : whiteColor,
                      ),
                      child: Row(
                        children: [
                          PhosphorIcon(
                            _getTaskIcon(task.type),
                            size: 24,
                            color: task.isCompleted
                                ? whiteColor
                                : Colors.grey.shade400,
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  task.name,
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: bold,
                                    color: task.isCompleted
                                        ? whiteColor
                                        : blackColor,
                                  ),
                                ),
                                Text(
                                  '${task.estimatedTime} menit - ${task.type}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: task.isCompleted
                                        ? whiteColor.withOpacity(0.8)
                                        : Colors.grey.shade600,
                                  ),
                                ),
                                if (task.completedDate != null)
                                  Text(
                                    'Selesai: ${task.completedDate!.day}/${task.completedDate!.month}/${task.completedDate!.year}',
                                    style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      color: whiteColor.withOpacity(0.7),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          if (userPlantController.isUpdating.value)
                            const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          else
                            CheckboxTheme(
                              data: CheckboxThemeData(
                                side: WidgetStateBorderSide.resolveWith(
                                  (states) {
                                    if (states.contains(WidgetState.selected)) {
                                      return BorderSide(color: primaryColor);
                                    }
                                    return BorderSide(color: whiteColor);
                                  },
                                ),
                              ),
                              child: Checkbox(
                                value: task.isCompleted,
                                onChanged: (value) async {
                                  if (value != null) {
                                    await userPlantController
                                        .updateTaskProgress(
                                      userPlantId: userPlantId,
                                      taskId: task.id,
                                      doneStatus: value,
                                    );
                                  }
                                },
                                activeColor: whiteColor,
                                checkColor: primaryColor,
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                })
              else
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Center(
                    child: Text(
                      currentDayData == null
                          ? 'Pilih hari untuk melihat tugas'
                          : 'Tidak ada tugas untuk hari ini',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ),

              const SizedBox(height: 20),

              // Finish Plant Button (if applicable)
              if (selectedUserPlant.status != 'selesai' &&
                  selectedUserPlant.progress >= 100)
                ElevatedButton(
                  onPressed: userPlantController.isLoading.value
                      ? null
                      : () async {
                          final result = await Get.dialog<bool>(
                            AlertDialog(
                              title: Text(
                                'Selesaikan Tanaman',
                                style: GoogleFonts.poppins(fontWeight: bold),
                              ),
                              content: Text(
                                'Apakah Anda yakin ingin menyelesaikan tanaman ini?',
                                style: GoogleFonts.poppins(),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Get.back(result: false),
                                  child: Text('Batal'),
                                ),
                                ElevatedButton(
                                  onPressed: () => Get.back(result: true),
                                  child: Text('Ya, Selesaikan'),
                                ),
                              ],
                            ),
                          );

                          if (result == true) {
                            await userPlantController.finishPlant(userPlantId);
                            Get.back(); // Return to previous screen
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    minimumSize: const Size(double.infinity, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    userPlantController.isLoading.value
                        ? 'Memproses...'
                        : 'Selesaikan Tanaman',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: semiBold,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
        );
      }),
      bottomNavigationBar: const Navbar(),
    );
  }

  PhosphorIconData _getTaskIcon(String taskType) {
    switch (taskType.toLowerCase()) {
      case 'penyiraman':
        return PhosphorIconsFill.drop;
      case 'pemupukan':
        return PhosphorIconsFill.leaf;
      case 'penyiangan':
        return PhosphorIconsFill.scissors;
      case 'pengecekan':
        return PhosphorIconsFill.magnifyingGlass;
      case 'pemangkasan':
        return PhosphorIconsFill.scissors;
      default:
        return PhosphorIconsFill.plant;
    }
  }
}
