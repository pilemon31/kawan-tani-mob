import 'package:flutter/material.dart';
import 'package:flutter_kawan_tani/presentation/widgets/navbar/navbar.dart';
import 'package:flutter_kawan_tani/shared/theme.dart';
import 'package:flutter_kawan_tani/models/plant_model.dart';
import "package:get/get.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class StartPlantingTasksScreen extends StatefulWidget {
  const StartPlantingTasksScreen({super.key});

  @override
  State<StartPlantingTasksScreen> createState() =>
      _StartPlantingTasksScreenState();
}

class _StartPlantingTasksScreenState extends State<StartPlantingTasksScreen> {
  Plant? plant;
  int selectedDay = 1;
  Map<int, List<PlantingTask>> tasksPerDay = {};
  Map<int, String> phasePerDay = {};

  @override
  void initState() {
    super.initState();
    // Get the plant data passed from the previous screen
    plant = Get.arguments as Plant?;

    if (plant != null) {
      _initializeTasks();
      // Set initial selected day to the first available day
      if (tasksPerDay.isNotEmpty) {
        selectedDay = tasksPerDay.keys.first;
      }
    }
  }

  void _initializeTasks() {
    if (plant == null) return;

    // Clear existing data
    tasksPerDay.clear();
    phasePerDay.clear();

    // Group tasks by day from plant data
    for (PlantingDay plantingDay in plant!.plantingDays) {
      tasksPerDay[plantingDay.day] = plantingDay.tasks;
      phasePerDay[plantingDay.day] = plantingDay.phase;
    }
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
              'Tugas Penanaman',
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
    // If no plant data is passed, show error screen
    if (plant == null || tasksPerDay.isEmpty) {
      return _buildEmptyState();
    }

    List<PlantingTask> currentTasks = tasksPerDay[selectedDay] ?? [];
    String currentPhase = phasePerDay[selectedDay] ?? '';

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
              plant!.name,
              style: GoogleFonts.poppins(
                fontSize: 20,
                color: blackColor,
                fontWeight: bold,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 21),
        child: ListView(
          children: [
            // Day Selector
            Center(
              child: Column(
                children: [
                  Text(
                    "Pilih Hari",
                    style: GoogleFonts.poppins(fontSize: 20, fontWeight: bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 60,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: tasksPerDay.keys.length,
                      itemBuilder: (context, index) {
                        int day = tasksPerDay.keys.elementAt(index);
                        bool isSelected = day == selectedDay;

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
                              color: isSelected ? primaryColor : Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                  color: isSelected
                                      ? primaryColor
                                      : Colors.grey.shade400),
                            ),
                            child: Center(
                              child: Text(
                                "$day",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected ? Colors.white : blackColor,
                                ),
                              ),
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
            Text(
              "Tugas Hari ke-$selectedDay",
              style: GoogleFonts.poppins(fontSize: 22, fontWeight: bold),
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
              ...currentTasks.asMap().entries.map((entry) {
                PlantingTask task = entry.value;

                return Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                    color: whiteColor,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: _getTaskColor(task.type).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: PhosphorIcon(
                          _getTaskIcon(task.type),
                          size: 20,
                          color: _getTaskColor(task.type),
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
                                color: blackColor,
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
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
            const SizedBox(height: 80),
          ],
        ),
      ),
      bottomNavigationBar: const Navbar(),
    );
  }
}
