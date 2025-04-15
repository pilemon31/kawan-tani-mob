import 'package:flutter/material.dart';
import 'package:flutter_kawan_tani/presentation/widgets/navbar/navbar.dart';
import 'package:flutter_kawan_tani/shared/theme.dart';
import "package:get/get.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class Task {
  final String title;
  bool isDone;

  Task(this.title, {this.isDone = false});
}

class YourPlantsDetailScreen extends StatefulWidget {
  const YourPlantsDetailScreen({super.key});

  @override
  State<YourPlantsDetailScreen> createState() => _YourPlantsDetailScreenState();
}

class _YourPlantsDetailScreenState extends State<YourPlantsDetailScreen> {
  int selectedDay = 1;

  Map<int, List<Task>> tasksPerDay = {
    1: [Task("Siram tanaman"), Task("Cek kelembapan"), Task("Bersihkan gulma")],
    2: [Task("Pupuk tanaman"), Task("Cek suhu tanah"), Task("Bersihkan gulma")],
    3: [Task("Siram tanaman"), Task("Pangkas daun mati"), Task("Cek kelembapan")],
    4: [Task("Cek hama"), Task("Siram tanaman")],
    5: [Task("Panen daun sehat"), Task("Cek kelembapan")],
    6: [Task("Siram tanaman"), Task("Bersihkan pot")],
    7: [Task("Pupuk organik"), Task("Cek kelembapan"), Task("Cek suhu tanah")],
  };

  double calculateProgress(List<Task> tasks) {
    if (tasks.isEmpty) return 0.0;
    int doneCount = tasks.where((task) => task.isDone).length;
    return doneCount / tasks.length;
  }

  @override
  Widget build(BuildContext context) {
    List<Task> currentTasks = tasksPerDay[selectedDay] ?? [];
    double progress = calculateProgress(currentTasks);

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
            title: Text(
              'Cabaiku Tani',
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
            Text(
              'Progress: ${(progress * 100).toStringAsFixed(0)}%',
              style: GoogleFonts.poppins(
                fontSize: 18,
                color: blackColor,
                fontWeight: bold,
              ),
            ),
            const SizedBox(height: 6),
            LinearProgressIndicator(
              value: progress,
              color: primaryColor,
              backgroundColor: Colors.grey.shade300,
              minHeight: 10,
              borderRadius: BorderRadius.circular(10),
            ),
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  Text(
                    "Hari",
                    style: GoogleFonts.poppins(fontSize: 20, fontWeight: bold),
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: tasksPerDay.keys.map((day) {
                        bool isSelected = day == selectedDay;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedDay = day;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: isSelected ? primaryColor : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.grey.shade400),
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
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Text(
              "Tugas Harian",
              style: GoogleFonts.poppins(fontSize: 22, fontWeight: bold),
            ),
            const SizedBox(height: 10),
            ...currentTasks.asMap().entries.map((entry) {
              Task task = entry.value;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    task.isDone = !task.isDone;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300),
                    color: task.isDone ? primaryColor: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Checkbox(
                        value: task.isDone,
                        onChanged: (value) {
                          setState(() {
                            task.isDone = value!;
                          });
                        },
                        activeColor: primaryColor,
                      ),
                      const SizedBox(width: 10),
                      PhosphorIcon(PhosphorIconsBold.checks, size: 24),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          task.title,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: bold,
                            color: blackColor,
                            decoration: task.isDone
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            })
          ],
        ),
      ),
      bottomNavigationBar: const Navbar(),
    );
  }
}
