import 'package:flutter/material.dart';
import 'package:flutter_kawan_tani/presentation/controllers/plants/user_plant_controller.dart';
import 'package:flutter_kawan_tani/presentation/widgets/navbar/navbar.dart';
import 'package:flutter_kawan_tani/shared/theme.dart';
import 'package:flutter_kawan_tani/models/user_plant_model.dart';
import "package:get/get.dart";
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
  UserPlant? userPlant;
  int selectedDay = 1;

  @override
  void initState() {
    super.initState();
    userPlant = Get.arguments as UserPlant?;

    if (userPlant != null) {
      _loadPlantData();
    }
  }

  Future<void> _loadPlantData() async {
    await userPlantController.getUserPlantDetail(userPlant!.id);
    await userPlantController.fetchDailyTasksAndUpdate(userPlant!.id);
    
    if (userPlantController.dailyTasks.isNotEmpty) {
      setState(() {
        selectedDay = userPlantController.dailyTasks.first.day;
      });
    }
  }

  double calculateDayProgress(List<UserPlantingTask> tasks) {
    if (tasks.isEmpty) return 0.0;
    int completedCount = tasks.where((task) => task.isCompleted).length;
    return completedCount / tasks.length;
  }

  PhosphorIconData _getTaskIcon(String taskType) {
    switch (taskType.toLowerCase()) {
      case 'watering':
      case 'siram':
      case 'penyiraman':
        return PhosphorIconsBold.drop;
      case 'fertilizing':
      case 'pupuk':
      case 'pemupukan':
        return PhosphorIconsBold.leaf;
      case 'pruning':
      case 'pangkas':
      case 'pemangkasan':
        return PhosphorIconsBold.scissors;
      case 'harvesting':
      case 'panen':
        return PhosphorIconsBold.basket;
      case 'pengecekan_harian':
      case 'checking':
        return PhosphorIconsBold.magnifyingGlass;
      case 'tugas_biasa':
      case 'maintenance':
        return PhosphorIconsBold.wrench;
      case 'weeding':
      case 'penyiangan':
        return PhosphorIconsBold.plant;
      default:
        return PhosphorIconsBold.check;
    }
  }

  Color _getTaskColor(String taskType) {
    switch (taskType.toLowerCase()) {
      case 'watering':
      case 'siram':
      case 'penyiraman':
        return Colors.blue;
      case 'fertilizing':
      case 'pupuk':
      case 'pemupukan':
        return Colors.green;
      case 'pruning':
      case 'pangkas':
      case 'pemangkasan':
        return Colors.orange;
      case 'harvesting':
      case 'panen':
        return Colors.amber;
      case 'pengecekan_harian':
      case 'checking':
        return Colors.purple;
      default:
        return primaryColor;
    }
  }

  Widget _buildEmptyState() {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 27),
          child: AppBar(
            backgroundColor: Colors.white,
            toolbarHeight: 80.0,
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: PhosphorIcon(PhosphorIconsBold.arrowLeft, size: 32.0),
            ),
            title: Text(
              'Tugas Tanaman',
              style: GoogleFonts.poppins(
                fontSize: 20,
                color: blackColor,
                fontWeight: bold,
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PhosphorIcon(
              PhosphorIcons.warning(),
              size: 64,
              color: greyColor,
            ),
            const SizedBox(height: 16),
            Text(
              'Data tanaman tidak ditemukan',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: greyColor,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
              ),
              child: Text(
                'Kembali',
                style: GoogleFonts.poppins(color: whiteColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // If no user plant data is passed, show error screen
    if (userPlant == null) {
      return _buildEmptyState();
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 27),
          child: AppBar(
            backgroundColor: Colors.white,
            toolbarHeight: 80.0,
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: PhosphorIcon(PhosphorIconsBold.arrowLeft, size: 32.0),
            ),
            title: Text(
              userPlant!.customName,
              style: GoogleFonts.poppins(
                fontSize: 20,
                color: blackColor,
                fontWeight: bold,
              ),
            ),
          ),
        ),
      ),
      body: Obx(() {
        // Use the selectedUserPlant from controller for general info
        final currentUserPlant = userPlantController.selectedUserPlant.value;
        
        // Use dailyTasks from controller for tasks data
        final allDailyTasks = userPlantController.dailyTasks;

        if (userPlantController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // Find current day's data from dailyTasks
        final currentDayData = allDailyTasks
            .where((day) => day.day == selectedDay)
            .firstOrNull;

        final currentTasks = currentDayData?.tasks ?? <UserPlantingTask>[];
        final dayProgress = currentDayData?.dayProgress ?? 0.0;
        final currentPhase = currentDayData?.phase ?? '';

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21),
          child: ListView(
            children: [
              // Overall Progress
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Progress Keseluruhan',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: blackColor,
                        fontWeight: semiBold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${currentUserPlant.progress.toStringAsFixed(0)}% dari ${currentUserPlant.plant.plantingDuration} hari',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: greyColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: currentUserPlant.progress / 100,
                      color: primaryColor,
                      backgroundColor: Colors.grey.shade300,
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Day Progress
              Text(
                'Progress Hari Ini: ${dayProgress.toStringAsFixed(0)}%',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: blackColor,
                  fontWeight: bold,
                ),
              ),
              const SizedBox(height: 6),
              LinearProgressIndicator(
                value: dayProgress / 100,
                color: primaryColor,
                backgroundColor: Colors.grey.shade300,
                minHeight: 10,
                borderRadius: BorderRadius.circular(10),
              ),
              const SizedBox(height: 20),

              // Day Selector
              Center(
                child: Column(
                  children: [
                    Text(
                      "Pilih Hari",
                      style:
                          GoogleFonts.poppins(fontSize: 20, fontWeight: bold),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 60,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: allDailyTasks.length,
                        itemBuilder: (context, index) {
                          final plantingDay = allDailyTasks[index];
                          final day = plantingDay.day;
                          final isSelected = day == selectedDay;
                          final isCompleted = plantingDay.dayProgress == 100.0;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedDay = day;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? primaryColor
                                    : isCompleted
                                        ? Colors.green
                                        : Colors.white,
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                    color: isSelected
                                        ? primaryColor
                                        : Colors.grey.shade400),
                              ),
                              child: Stack(
                                children: [
                                  Center(
                                    child: Text(
                                      "$day",
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: isSelected || isCompleted
                                            ? Colors.white
                                            : blackColor,
                                      ),
                                    ),
                                  ),
                                  if (isCompleted && !isSelected)
                                    Positioned(
                                      top: 2,
                                      right: 2,
                                      child: Container(
                                        width: 16,
                                        height: 16,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: PhosphorIcon(
                                          PhosphorIconsBold.check,
                                          size: 12,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Phase Info
              if (currentPhase.isNotEmpty) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      PhosphorIcon(
                        PhosphorIconsBold.info,
                        color: Colors.blue,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Fase: $currentPhase',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: semiBold,
                          color: Colors.blue.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],

              // Tasks Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Tugas Hari ke-$selectedDay",
                    style: GoogleFonts.poppins(fontSize: 22, fontWeight: bold),
                  ),
                  if (currentDayData != null)
                    Text(
                      "${currentDayData.completedTasks}/${currentDayData.totalTasks}",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: primaryColor,
                        fontWeight: semiBold,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 10),

              // Tasks List
              if (currentTasks.isEmpty) ...[
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        PhosphorIcon(
                          PhosphorIcons.plant(),
                          size: 48,
                          color: greyColor,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Tidak ada tugas untuk hari ini",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: greyColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ] else ...[
                ...currentTasks.map((task) {
                  return GestureDetector(
                    onTap: () async {
                      // Update task progress via API
                      await userPlantController.updateTaskProgress(
                        userPlantId: currentUserPlant.id,
                        taskId: task.id,
                        doneStatus: !task.isCompleted,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: task.isCompleted
                                ? primaryColor
                                : Colors.grey.shade300),
                        color: task.isCompleted
                            ? primaryColor.withOpacity(0.1)
                            : whiteColor,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: task.isCompleted
                                  ? primaryColor
                                  : _getTaskColor(task.type).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: PhosphorIcon(
                              _getTaskIcon(task.type),
                              size: 20,
                              color: task.isCompleted
                                  ? whiteColor
                                  : _getTaskColor(task.type),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  task.name,
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: semiBold,
                                    color: task.isCompleted
                                        ? primaryColor
                                        : blackColor,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    PhosphorIcon(
                                      PhosphorIcons.clock(),
                                      size: 14,
                                      color: greyColor,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      "${task.estimatedTime} menit",
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: greyColor,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _getTaskColor(task.type)
                                            .withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        task.type
                                            .replaceAll('_', ' ')
                                            .toUpperCase(),
                                        style: GoogleFonts.poppins(
                                          fontSize: 10,
                                          color: _getTaskColor(task.type),
                                          fontWeight: semiBold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                if (task.completedDate != null) ...[
                                  const SizedBox(height: 4),
                                  Text(
                                    "Selesai: ${task.completedDate!.day}/${task.completedDate!.month}/${task.completedDate!.year}",
                                    style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      color: Colors.green,
                                      fontWeight: semiBold,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (userPlantController.isUpdating.value)
                            const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
                          else
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: task.isCompleted
                                    ? primaryColor
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: task.isCompleted
                                      ? primaryColor
                                      : Colors.grey.shade400,
                                  width: 2,
                                ),
                              ),
                              child: task.isCompleted
                                  ? PhosphorIcon(
                                      PhosphorIconsBold.check,
                                      size: 16,
                                      color: whiteColor,
                                    )
                                  : null,
                            ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ],
              const SizedBox(height: 80),
            ],
          ),
        );
      }),
      bottomNavigationBar: const Navbar(),
    );
  }
}