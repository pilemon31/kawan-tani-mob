import 'dart:convert';
import 'package:flutter_kawan_tani/models/article_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_kawan_tani/shared/constants.dart';

class ArticleService {
  final String baseUrl = Constants.baseUrl;

  Future<List<Article>> getArticles() async {
    try {
      print('Calling API: $baseUrl/articles'); // Debug print
      final response = await http.get(Uri.parse('$baseUrl/articles'));

      print('Response status: ${response.statusCode}'); // Debug print
      print('Response body: ${response.body}'); // Debug print

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['data'] != null) {
          List<dynamic> data = jsonResponse['data'];
          print('Data received: $data'); // Debug print
          return data.map((json) => Article.fromJson(json)).toList();
        }
        throw Exception('Data field is null');
      } else {
        throw Exception('Failed with status ${response.statusCode}');
      }
    } catch (e) {
      print('Error in getArticles: $e'); // Debug print
      throw Exception('Service error: $e');
    }
  }
}
