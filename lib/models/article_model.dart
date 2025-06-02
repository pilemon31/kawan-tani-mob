import 'package:flutter_kawan_tani/shared/constants.dart';

class Article {
  final String id;
  final String title;
  final String content;
  final String author;
  final String authorImage;
  final String imageUrl;
  final DateTime createdAt;
  final double rating;

  Article({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.authorImage,
    required this.imageUrl,
    required this.createdAt,
    required this.rating,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    final String imageBaseUrl = '${Constants.baseUrl}/storage';
    String authorName = 'Anonymous';
    if (json['pengguna'] != null && json['pengguna']['nama'] != null) {
      authorName = json['pengguna']['nama'];
    }

    return Article(
      id: json['id_artikel'],
      title: json['judul_artikel'],
      content: json['isi_artikel'],
      author: authorName,
      authorImage: '',
      imageUrl: '$imageBaseUrl/${json['gambar_artikel']}',
      createdAt: DateTime.parse(json['tanggal_artikel']),
      rating: json['rating']?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'author': author,
      'authorImage': authorImage,
      'imageUrl': imageUrl,
      'createdAt': createdAt.toIso8601String(),
      'rating': rating,
    };
  }
}
