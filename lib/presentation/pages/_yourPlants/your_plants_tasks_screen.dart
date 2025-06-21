import 'package:flutter/material.dart';
import 'package:flutter_kawan_tani/presentation/controllers/plants/user_plant_controller.dart';
import 'package:flutter_kawan_tani/presentation/widgets/navbar/navbar.dart';
import 'package:flutter_kawan_tani/shared/theme.dart';
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
  late String userPlantId;
  late RxInt selectedDay;

  @override
  void initState() {
    super.initState();
    userPlantId = Get.arguments as String;
    selectedDay = 1.obs;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    // Set isLoading to true before fetching data
    userPlantController.isLoading(true);
    try {
      await userPlantController.getUserPlantDetail(userPlantId);

      // Now that selectedUserPlant is updated, check its plantingDays
      if (userPlantController.selectedUserPlant.value.plantingDays.isNotEmpty) {
        // Only update selectedDay if it hasn't been set to a valid day yet,
        // or if you always want to default to the first day upon reload.
        // This line is safe because it's now wrapped in addPostFrameCallback.
        selectedDay.value =
            userPlantController.selectedUserPlant.value.plantingDays.first.day;
      } else {
        print('No planting days found for this user plant. (After fetch)');
        // Optionally show a Get.snackbar here, but ensure it's not during build
        // Get.snackbar('Info', 'Belum ada tugas harian untuk tanaman ini.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Gagal memuat detail tanaman: ${e.toString()}');
    } finally {
      userPlantController.isLoading(false);
    }
  }

  PhosphorIconData _getTaskIcon(String taskType) {
    switch (taskType.toLowerCase()) {
      case 'penyiraman':
      case 'watering':
        return PhosphorIconsFill.drop;
      case 'pemupukan':
      case 'fertilizing':
        return PhosphorIconsFill.leaf;
      case 'penyiangan':
      case 'weeding':
        return PhosphorIconsFill.plant;
      case 'pengecekan':
      case 'checking':
        return PhosphorIconsFill.magnifyingGlass;
      case 'pemangkasan':
      case 'pruning':
        return PhosphorIconsFill.scissors;
      case 'panen':
      case 'harvesting':
        return PhosphorIconsFill.basket;
      default:
        return PhosphorIconsFill.clipboardText;
    }
  }

  Color _getTaskColor(String taskType) {
    switch (taskType.toLowerCase()) {
      case 'penyiraman':
      case 'watering':
        return Colors.blue;
      case 'pemupukan':
      case 'fertilizing':
        return Colors.green;
      case 'penyiangan':
      case 'weeding':
        return Colors.brown;
      case 'pengecekan':
      case 'checking':
        return Colors.purple;
      case 'pemangkasan':
      case 'pruning':
        return Colors.orange;
      case 'panen':
      case 'harvesting':
        return Colors.amber;
      default:
        return primaryColor;
    }
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
                Get.back(result: true);
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
        if (userPlantController.isLoading.value &&
            userPlantController.selectedUserPlant.value.id.isEmpty) {
          // Show full screen loading indicator only if no data has been loaded yet
          return const Center(child: CircularProgressIndicator());
        }

        final selectedUserPlant = userPlantController.selectedUserPlant.value;

        if (selectedUserPlant.id.isEmpty) {
          return Center(
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
                  'Data tanaman tidak ditemukan atau sedang dimuat.',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: greyColor,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => _loadData(),
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

        final availableDays = selectedUserPlant.plantingDays
            .map((day) => day.day)
            .toList()
          ..sort();

        final currentDayData = selectedUserPlant.plantingDays
            .firstWhereOrNull((d) => d.day == selectedDay.value);

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21),
          child: ListView(
            children: [
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
                value: selectedUserPlant.progress / 100.0,
                color: primaryColor,
                backgroundColor: Colors.grey.shade300,
                minHeight: 10,
                borderRadius: BorderRadius.circular(10),
              ),
              const SizedBox(height: 20),
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
                    Text(
                      'Target Panen: ${selectedUserPlant.targetHarvestDate.day}/${selectedUserPlant.targetHarvestDate.month}/${selectedUserPlant.targetHarvestDate.year}',
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
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
                        child: Obx(() => Row(
                              // Wrap Row with Obx to react to selectedDay changes
                              children: availableDays.map((day) {
                                bool isSelected = day == selectedDay.value;
                                final dayData = selectedUserPlant.plantingDays
                                    .firstWhereOrNull((d) => d.day == day);
                                bool hasCompletedAllTasks =
                                    dayData?.completedTasks ==
                                            dayData?.totalTasks &&
                                        dayData != null &&
                                        dayData.totalTasks > 0;

                                return GestureDetector(
                                  onTap: () {
                                    // Direct assignment is fine, selectedDay is RxInt
                                    selectedDay.value = day;
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? primaryColor
                                          : hasCompletedAllTasks
                                              ? Colors.green.shade100
                                              : Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: hasCompletedAllTasks
                                              ? Colors.green
                                              : Colors.grey.shade400),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "$day",
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              isSelected || hasCompletedAllTasks
                                                  ? Colors.white
                                                  : blackColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            )),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
              ] else ...[
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        PhosphorIcon(
                          PhosphorIcons.calendarBlank(),
                          size: 48,
                          color: greyColor,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Belum ada hari penanaman tersedia untuk tanaman ini.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: greyColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Pastikan backend Anda mengembalikan data 'hari_tanaman' saat membuat atau mengambil detail tanaman pengguna.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: greyColor.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
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
                Text(
                  "Tugas Harian",
                  style: GoogleFonts.poppins(fontSize: 22, fontWeight: bold),
                ),
                const SizedBox(height: 10),
                if (currentDayData.tasks.isNotEmpty)
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
                          border: Border.all(
                              color: task.isCompleted
                                  ? primaryColor
                                  : Colors.grey.shade300),
                          color: task.isCompleted ? primaryColor : whiteColor,
                        ),
                        child: Row(
                          children: [
                            PhosphorIcon(
                              _getTaskIcon(task.type),
                              size: 24,
                              color: task.isCompleted
                                  ? whiteColor
                                  : _getTaskColor(task.type),
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
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              )
                            else
                              CheckboxTheme(
                                data: CheckboxThemeData(
                                  side: WidgetStateBorderSide.resolveWith(
                                    (states) {
                                      if (states
                                          .contains(WidgetState.selected)) {
                                        return BorderSide(color: primaryColor);
                                      }
                                      return BorderSide(
                                          color: Colors.grey.shade400);
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
                                  activeColor: primaryColor,
                                  checkColor: whiteColor,
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
                        'Tidak ada tugas untuk hari ini.',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ),
              ] else ...[
                // This block runs if currentDayData is null (no tasks for the selected day)
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Center(
                    child: Text(
                      'Tidak ada tugas untuk hari yang dipilih ini.',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 20),
              if (selectedUserPlant.status != 'selesai' &&
                  selectedUserPlant.progress >= 100)
                Obx(
                  () => ElevatedButton(
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
                                    child: const Text('Batal'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () => Get.back(result: true),
                                    child: const Text('Ya, Selesaikan'),
                                  ),
                                ],
                              ),
                            );

                            if (result == true) {
                              await userPlantController
                                  .finishPlant(userPlantId);
                              Get.back();
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      minimumSize: const Size(double.infinity, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: userPlantController.isLoading.value
                        ? CircularProgressIndicator(color: whiteColor)
                        : Text(
                            'Selesaikan Tanaman',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: semiBold,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              const SizedBox(height: 20),
            ],
          ),
        );
      }),
      bottomNavigationBar: const Navbar(),
    );
  }
}
