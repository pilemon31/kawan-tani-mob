class Plant {
  final String name;
  final String image;
  final String duration;
  final String type;
  double progress; // Menyimpan progress 0.0 - 1.0

  Plant({
    required this.name,
    required this.image,
    required this.duration,
    required this.type,
    this.progress = 0.0,
  });
}