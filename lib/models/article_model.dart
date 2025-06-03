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
  final List<ArticleLike> likes;
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
    this.likes = const [],
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
      author: '${json['pengguna']?['nama_depan_pengguna'] ?? ''} ${json['pengguna']?['nama_belakang_pengguna'] ?? ''}'.trim(),
      authorImage: json['pengguna']?['foto_profil'] ?? '',
      createdAt: json['tanggal_artikel'] != null 
          ? DateTime.parse(json['tanggal_artikel']) 
          : DateTime.now(),
      isActive: json['status_aktif'] ?? false,
      status: json['status_artikel'] ?? '',
      isVerified: json['status_verifikasi'] ?? false,
      rating: (json['rating'] ?? 0.0).toDouble(),
      comments: (json['komentar_artikel'] as List<dynamic>?)
              ?.map((comment) => Comment.fromJson(comment))
              .toList() ??
          [],
      likes: (json['artikel_disukai'] as List<dynamic>?)
              ?.map((like) => ArticleLike.fromJson(like))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_artikel': id,
      'judul_artikel': title,
      'deskripsi_artikel': description,
      'isi_artikel': content,
      'gambar_artikel': imageUrl,
      'tanggal_artikel': createdAt.toIso8601String(),
      'status_aktif': isActive,
      'status_artikel': status,
      'status_verifikasi': isVerified,
    };
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
      author: '${json['pengguna']?['nama_depan_pengguna'] ?? ''} ${json['pengguna']?['nama_belakang_pengguna'] ?? ''}'.trim(),
      authorImage: json['pengguna']?['foto_profil'] ?? '',
      createdAt: json['tanggal_komentar'] != null 
          ? DateTime.parse(json['tanggal_komentar']) 
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_komentar': id,
      'komentar': content,
      'tanggal_komentar': createdAt.toIso8601String(),
    };
  }
}

class ArticleLike {
  final String id;
  final String userId;
  final String articleId;
  final DateTime createdAt;

  ArticleLike({
    required this.id,
    required this.userId,
    required this.articleId,
    required this.createdAt,
  });

  factory ArticleLike.fromJson(Map<String, dynamic> json) {
    return ArticleLike(
      id: json['id'] ?? '',
      userId: json['id_pengguna'] ?? '',
      articleId: json['id_artikel'] ?? '',
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_pengguna': userId,
      'id_artikel': articleId,
      'created_at': createdAt.toIso8601String(),
    };
  }
}