import 'package:flutter_kawan_tani/models/plant_model.dart';

class UserPlant {
  final String id;
  final String customName;
  final DateTime plantingDate;
  final DateTime targetHarvestDate;
  final double progress;
  final String status;
  final Plant plant;
  List<UserPlantingDay> plantingDays;

  UserPlant({
    required this.id,
    required this.customName,
    required this.plantingDate,
    required this.targetHarvestDate,
    required this.progress,
    required this.status,
    required this.plant,
    this.plantingDays = const [],
  });

  factory UserPlant.fromJson(Map<String, dynamic> json) {
    return UserPlant(
      id: json['id_tanaman_pengguna']?.toString() ?? '',
      customName: json['nama_custom'] ?? '',
      plantingDate: DateTime.parse(json['tanggal_penanaman']),
      targetHarvestDate: DateTime.parse(json['tanggal_target_panen']),
      progress: (json['progress_persen'] ?? 0.0).toDouble(),
      status: json['status_penanaman'] ?? '',
      plant: Plant.fromJson(json['tanaman']),
      plantingDays: (json['hari_tanaman'] as List<dynamic>?)
              ?.map((day) => UserPlantingDay.fromJson(day))
              .toList() ??
          [],
    );
  }
}

class UserPlantingDay {
  final String id;
  final int day;
  final DateTime actualDate;
  final String phase;
  final int totalTasks;
  final int completedTasks;
  final double dayProgress;
  final String dayStatus;
  final List<UserPlantingTask> tasks;

  UserPlantingDay({
    required this.id,
    required this.day,
    required this.actualDate,
    required this.phase,
    required this.totalTasks,
    required this.completedTasks,
    required this.dayProgress,
    required this.dayStatus,
    this.tasks = const [],
  });

  factory UserPlantingDay.fromJson(Map<String, dynamic> json) {
    print(
        'Parsing UserPlantingDay: ${json['id_hari_tanaman_pengguna'].runtimeType} = ${json['id_hari_tanaman_pengguna']}');
    return UserPlantingDay(
      id: (json['id_hari_tanaman_pengguna'] as dynamic)?.toString() ?? '',
      day: json['hari_ke'] ?? 0,
      actualDate: DateTime.parse(json['tanggal_aktual']),
      phase: json['fase_penanaman'] ?? '',
      totalTasks: json['total_tugas'] ?? 0,
      completedTasks: json['tugas_selesai'] ?? 0,
      dayProgress: (json['progress_hari_persen'] ?? 0.0).toDouble(),
      dayStatus: json['status_hari'] ?? '',
      tasks: (json['tugas_penanaman'] as List<dynamic>?)
              ?.map((task) => UserPlantingTask.fromJson(task))
              .toList() ??
          [],
    );
  }
}

class UserPlantingTask {
  final String id;
  final String name;
  final String type;
  final int estimatedTime;
  bool isCompleted;
  DateTime? completedDate;

  UserPlantingTask({
    required this.id,
    required this.name,
    required this.type,
    required this.estimatedTime,
    required this.isCompleted,
    this.completedDate,
  });

  factory UserPlantingTask.fromJson(Map<String, dynamic> json) {
    return UserPlantingTask(
      id: (json['id_tugas_penanaman_pengguna'] as dynamic)?.toString() ?? '',
      name: json['nama_tugas'] ?? '',
      type: json['jenis_tugas'] ?? '',
      estimatedTime: json['estimasi_waktu'] ?? 0,
      isCompleted: json['status_selesai'] ?? false,
      completedDate: json['tanggal_selesai'] != null
          ? DateTime.parse(json['tanggal_selesai'])
          : null,
    );
  }
}
