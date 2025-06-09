import 'package:flutter/material.dart';
import 'package:flutter_kawan_tani/presentation/pages/_yourPlants/plants_tasks_screen.dart';
import 'package:flutter_kawan_tani/presentation/widgets/navbar/navbar.dart';
import 'package:flutter_kawan_tani/shared/theme.dart';
import 'package:flutter_kawan_tani/models/plant_model.dart';
import "package:get/get.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class StartPlantingDetailScreen extends StatefulWidget {
  const StartPlantingDetailScreen({super.key});

  @override
  State<StartPlantingDetailScreen> createState() =>
      _StartPlantingDetailScreenState();
}

class _StartPlantingDetailScreenState extends State<StartPlantingDetailScreen> {
  Plant? plant;

  @override
  void initState() {
    super.initState();
    // Get the plant data passed from the previous screen
    plant = Get.arguments as Plant?;
  }

  @override
  Widget build(BuildContext context) {
    // If no plant data is passed, show error screen
    if (plant == null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: whiteColor,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: PhosphorIcon(PhosphorIconsBold.arrowLeft, size: 32.0),
          ),
          title: Text(
            'Detail Tanaman',
            style: GoogleFonts.poppins(
              fontSize: 20,
              color: blackColor,
              fontWeight: bold,
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

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 27),
          child: AppBar(
            backgroundColor: Colors.white,
            toolbarHeight: 80.0,
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: PhosphorIcon(
                PhosphorIconsBold.arrowLeft,
                size: 32.0,
              ),
            ),
            title: Padding(
              padding: EdgeInsets.all(0),
              child: Text(
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
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 27),
        child: ListView(
          children: [
            // Plant Image
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: greyColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: plant!.imageUrl != null && plant!.imageUrl!.isNotEmpty
                    ? Image.network(
                        'http://localhost:2000/uploads/plants/${plant!.imageUrl}',
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                              color: greyColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: PhosphorIcon(
                                PhosphorIcons.plant(),
                                size: 64,
                                color: greyColor,
                              ),
                            ),
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                              color: primaryColor,
                            ),
                          );
                        },
                      )
                    : Center(
                        child: PhosphorIcon(
                          PhosphorIcons.plant(),
                          size: 64,
                          color: greyColor,
                        ),
                      ),
              ),
            ),
            SizedBox(height: 18),

            // Plant Name
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                plant!.name,
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(fontSize: 26, fontWeight: bold),
              ),
            ),
            SizedBox(height: 18),

            // Plant Info
            Column(
              children: [
                Row(
                  children: [
                    PhosphorIcon(PhosphorIcons.clock(), size: 32.0),
                    SizedBox(width: 10),
                    Text(
                      "${_formatDuration(plant!.plantingDuration)} hingga panen",
                      style:
                          GoogleFonts.poppins(fontSize: 14, fontWeight: light),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    PhosphorIcon(PhosphorIcons.tag(), size: 32.0),
                    SizedBox(width: 10),
                    Text(
                      "Kategori: ${plant!.category?.name ?? 'Tanaman'}",
                      style:
                          GoogleFonts.poppins(fontSize: 14, fontWeight: light),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PhosphorIcon(PhosphorIcons.info(), size: 32.0),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Instruksi penanaman: ${plant!.instructions.length} langkah",
                        style: GoogleFonts.poppins(
                            fontSize: 14, fontWeight: light),
                      ),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),

            // Description
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Deskripsi",
                  style: GoogleFonts.poppins(fontSize: 22, fontWeight: bold),
                ),
                SizedBox(height: 8),
                Text(
                  plant!.description.isNotEmpty
                      ? plant!.description
                      : "Deskripsi tidak tersedia untuk tanaman ini.",
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Instructions Section
            if (plant!.instructions.isNotEmpty) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Instruksi Penanaman",
                    style: GoogleFonts.poppins(fontSize: 22, fontWeight: bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      // You can navigate to a detailed instructions screen here
                      // Get.to(() => PlantInstructionsScreen(), arguments: plant);
                    },
                    child: Text(
                      "Lihat Semua",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: light,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              ...plant!.instructions
                  .take(3)
                  .map((instruction) => Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  instruction.order.toString(),
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: bold,
                                    color: whiteColor,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    instruction.title,
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: bold,
                                    ),
                                  ),
                                  if (instruction.content.isNotEmpty) ...[
                                    SizedBox(height: 4),
                                    Text(
                                      instruction.content,
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: greyColor,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
              SizedBox(height: 20),
            ],

            // Daily Tasks Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tugas Harian",
                  style: GoogleFonts.poppins(fontSize: 22, fontWeight: bold),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const PlantsTasksScreen(), arguments: plant);
                  },
                  child: Text(
                    "Lihat Detail",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: light,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),

            // Display daily tasks from planting days
            if (plant!.plantingDays.isNotEmpty) ...[
              ...plant!.plantingDays
                  .expand((day) => day.tasks)
                  .take(3)
                  .map((task) => Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Row(
                          children: [
                            PhosphorIcon(
                              _getTaskIcon(task.type),
                              size: 24,
                              color: primaryColor,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    task.name,
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: bold,
                                    ),
                                  ),
                                  Text(
                                    "Estimasi: ${task.estimatedTime} menit",
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: greyColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ] else ...[
              Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Center(
                  child: Text(
                    "Belum ada tugas harian tersedia",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: greyColor,
                    ),
                  ),
                ),
              ),
            ],

            SizedBox(height: 20),

            // Action Buttons
            ElevatedButton(
              onPressed: () {
                // Navigate to shop or marketplace
                Get.snackbar(
                  'Info',
                  'Fitur beli alat dan bahan akan segera tersedia',
                  backgroundColor: primaryColor,
                  colorText: whiteColor,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Beli alat dan bahan",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: semiBold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Start planting - you can navigate to a planting journey screen
                Get.snackbar(
                  'Berhasil',
                  'Memulai penanaman ${plant!.name}',
                  backgroundColor: primaryColor,
                  colorText: whiteColor,
                );
                // Get.to(() => PlantingJourneyScreen(), arguments: plant);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Mulai tanam",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: semiBold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
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

  PhosphorIconData _getTaskIcon(String taskType) {
    switch (taskType.toLowerCase()) {
      case 'watering':
      case 'siram':
        return PhosphorIconsBold.drop;
      case 'fertilizing':
      case 'pupuk':
        return PhosphorIconsBold.leaf;
      case 'pruning':
      case 'pangkas':
        return PhosphorIconsBold.scissors;
      case 'harvesting':
      case 'panen':
        return PhosphorIconsBold.basket;
      default:
        return PhosphorIconsBold.check;
    }
  }
}
