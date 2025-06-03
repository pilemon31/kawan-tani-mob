// models/article_model.dart
class Article {
  final String id;
  final String title;
  final String description;
  final String content;
  final String imageUrl;
  final String category;
  final String author;
  final String authorImage;
  final DateTime createdAt;
  final bool isActive;
  final String status;
  final bool isVerified;
  final double rating;
  final List<Comment> comments;
  bool isLiked;
  bool isSaved;

  Article({
    required this.id,
    required this.title,
    required this.description,
    required this.content,
    required this.imageUrl,
    required this.category,
    required this.author,
    required this.authorImage,
    required this.createdAt,
    required this.isActive,
    required this.status,
    required this.isVerified,
    this.rating = 0.0,
    this.comments = const [],
    this.isLiked = false,
    this.isSaved = false,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id_artikel'] ?? '',
      title: json['judul_artikel'] ?? '',
      description: json['deskripsi_artikel'] ?? '',
      content: json['isi_artikel'] ?? '',
      imageUrl: json['gambar_artikel'] ?? '',
      category: json['kategori']?['nama_kategori_artikel'] ?? '',
      author:
          '${json['pengguna']?['nama_depan_pengguna'] ?? ''} ${json['pengguna']?['nama_belakang_pengguna'] ?? ''}',
      authorImage: json['pengguna']?['foto_profil'] ?? '',
      createdAt:
          DateTime.parse(json['tanggal_artikel'] ?? DateTime.now().toString()),
      isActive: json['status_aktif'] ?? false,
      status: json['status_artikel'] ?? '',
      isVerified: json['status_verifikasi'] ?? false,
      rating: (json['rating'] ?? 0.0).toDouble(),
      comments: (json['komentar_artikel'] as List<dynamic>?)
              ?.map((comment) => Comment.fromJson(comment))
              .toList() ??
          [],
    );
  }
}

class Comment {
  final String id;
  final String content;
  final String author;
  final String authorImage;
  final DateTime createdAt;

  Comment({
    required this.id,
    required this.content,
    required this.author,
    required this.authorImage,
    required this.createdAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id_komentar'] ?? '',
      content: json['komentar'] ?? '',
      author:
          '${json['pengguna']?['nama_depan_pengguna'] ?? ''} ${json['pengguna']?['nama_belakang_pengguna'] ?? ''}',
      authorImage: json['pengguna']?['foto_profil'] ?? '',
      createdAt:
          DateTime.parse(json['tanggal_komentar'] ?? DateTime.now().toString()),
    );
  }
}
