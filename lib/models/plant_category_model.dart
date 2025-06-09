class PlantCategory {
  final int id;
  final String name;
  final String? imageUrl;

  PlantCategory({
    required this.id,
    required this.name,
    this.imageUrl,
  });

  factory PlantCategory.fromJson(Map<String, dynamic> json) {
    return PlantCategory(
      id: json['id_kategori_tanaman'] ?? 0,
      name: json['nama_kategori_tanaman'] ?? '',
      imageUrl: json['gambar_kategori_tanaman'],
    );
  }
}