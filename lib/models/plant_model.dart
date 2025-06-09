import 'package:flutter_kawan_tani/models/plant_category_model.dart';

class Plant {
  final String id;
  final String name;
  final String description;
  final String? imageUrl;
  final int plantingDuration;
  final PlantCategory? category;
  final List<PlantInstruction> instructions;
  final List<PlantingDay> plantingDays;

  Plant({
    required this.id,
    required this.name,
    required this.description,
    this.imageUrl,
    required this.plantingDuration,
    this.category,
    this.instructions = const [],
    this.plantingDays = const [],
  });

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      id: json['id_tanaman'] ?? '',
      name: json['nama_tanaman'] ?? '',
      description: json['deskripsi_tanaman'] ?? '',
      imageUrl: json['gambar_tanaman'],
      plantingDuration: json['durasi_penanaman'] ?? 0,
      category: json['kategori'] != null
          ? PlantCategory.fromJson(json['kategori'])
          : null,
      instructions: (json['instruksi_tanaman'] as List<dynamic>?)
              ?.map((instruction) => PlantInstruction.fromJson(instruction))
              .toList() ??
          [],
      plantingDays: (json['hari_penanaman'] as List<dynamic>?)
              ?.map((day) => PlantingDay.fromJson(day))
              .toList() ??
          [],
    );
  }
}

class PlantInstruction {
  final int id;
  final String title;
  final String content;
  final int order;

  PlantInstruction({
    required this.id,
    required this.title,
    required this.content,
    required this.order,
  });

  factory PlantInstruction.fromJson(Map<String, dynamic> json) {
    return PlantInstruction(
      id: json['id_instruksi'] ?? 0,
      title: json['instruksi'] ?? '',
      content: json['instruksi'] ?? '',
      order: json['urutan'] ?? 0,
    );
  }
}

class PlantingDay {
  final int id;
  final int day;
  final String phase;
  final List<PlantingTask> tasks;

  PlantingDay({
    required this.id,
    required this.day,
    required this.phase,
    this.tasks = const [],
  });

  factory PlantingDay.fromJson(Map<String, dynamic> json) {
    return PlantingDay(
      id: json['id_hari_penanaman'] ?? 0,
      day: json['hari_ke'] ?? 0,
      phase: json['nama_fase'] ?? '',
      tasks: (json['tugas_penanaman'] as List<dynamic>?)
              ?.map((task) => PlantingTask.fromJson(task))
              .toList() ??
          [],
    );
  }
}

class PlantingTask {
  final int id;
  final String name;
  final String type;
  final int estimatedTime;

  PlantingTask({
    required this.id,
    required this.name,
    required this.type,
    required this.estimatedTime,
  });

  factory PlantingTask.fromJson(Map<String, dynamic> json) {
    return PlantingTask(
      id: json['id_tugas'] ?? 0,
      name: json['nama_tugas'] ?? '',
      type: json['jenis_tugas'] ?? '',
      estimatedTime: json['estimasi_waktu'] ?? 0,
    );
  }
}
