// services/articles/article_service.dart
import 'dart:convert';
import 'package:flutter_kawan_tani/models/article_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_kawan_tani/shared/constants.dart';
import 'package:flutter_kawan_tani/shared/storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArticleService {
  final String baseUrl = Constants.baseUrl;
  final StorageService storageService = StorageService();

  Future<List<Article>> getArticles() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/articles/active'));
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        List<dynamic> data = jsonResponse['data'];
        return data.map((json) => Article.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load articles');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<Article>> getAllArticles() async {
    try {
      final token = await storageService.getToken();
      // Add debugging
      print('Token: $token');
      print('URL: $baseUrl/articles');

      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }
      final response = await http.get(
        Uri.parse('$baseUrl/articles'),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        List<dynamic> data = jsonResponse['data'];
        return data.map((json) => Article.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load all articles');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Article> getArticleById(String id) async {
    try {
      // Ambil token langsung pakai key yang sama dengan login
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token'); // pakai key 'token'

      print('Token: $token');
      print('URL: $baseUrl/articles/$id');

      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      final response =
          await http.get(Uri.parse('$baseUrl/articles/$id'), headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return Article.fromJson(jsonResponse['data']);
      } else {
        throw Exception('HTTP ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      print('Detailed error: $e');
      throw Exception('Error: $e');
    }
  }

  Future<List<Article>> getUserArticles() async {
    try {
      final token = await storageService.getToken();
      final response = await http.get(
        Uri.parse('$baseUrl/articles/own'),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        List<dynamic> data = jsonResponse['data'];
        return data.map((json) => Article.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load user articles');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<Article>> getSavedArticles() async {
    try {
      final token = await storageService.getToken();
      final response = await http.get(
        Uri.parse('$baseUrl/articles/saved'),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        List<dynamic> data = jsonResponse['data'];
        return data.map((json) => Article.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load saved articles');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Article> createArticle({
    required String title,
    required String description,
    required String content,
    required String imagePath,
    required String category,
    required String status,
  }) async {
    try {
      final token = await storageService.getToken();
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/articles'),
      );
      request.headers['Authorization'] = 'Bearer $token';
      request.fields['title'] = title;
      request.fields['description'] = description;
      request.fields['content'] = content;
      request.fields['category'] = category;
      request.fields['articleStatus'] = status;
      request.files.add(await http.MultipartFile.fromPath('image', imagePath));

      final response = await request.send();
      final responseData = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(responseData);
        return Article.fromJson(jsonResponse['data']);
      } else {
        throw Exception('Failed to create article');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Article> updateArticle({
    required String id,
    required String title,
    required String description,
    required String content,
    String? imagePath,
    required String status,
  }) async {
    try {
      final token = await storageService.getToken();
      var request = http.MultipartRequest(
        'PATCH',
        Uri.parse('$baseUrl/articles/$id'),
      );
      request.headers['Authorization'] = 'Bearer $token';
      request.fields['title'] = title;
      request.fields['description'] = description;
      request.fields['content'] = content;
      request.fields['articleStatus'] = status;
      if (imagePath != null) {
        request.files
            .add(await http.MultipartFile.fromPath('image', imagePath));
      }

      final response = await request.send();
      final responseData = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(responseData);
        return Article.fromJson(jsonResponse['data']);
      } else {
        throw Exception('Failed to update article');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<bool> deleteArticle(String id) async {
    try {
      final token = await storageService.getToken();
      final response = await http.delete(
        Uri.parse('$baseUrl/articles/$id'),
        headers: {'Authorization': 'Bearer $token'},
      );
      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<bool> toggleArticleStatus(String id) async {
    try {
      final token = await storageService.getToken();
      final response = await http.patch(
        Uri.parse('$baseUrl/articles/$id/toggle'),
        headers: {'Authorization': 'Bearer $token'},
      );
      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<bool> verifyArticle(String id) async {
    try {
      final token = await storageService.getToken();
      final response = await http.patch(
        Uri.parse('$baseUrl/articles/$id'),
        headers: {'Authorization': 'Bearer $token'},
      );
      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Comment> addComment(String articleId, String content) async {
    try {
      final token = await storageService.getToken();
      final response = await http.post(
        Uri.parse('$baseUrl/articles/$articleId/comments'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'content': content}),
      );
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return Comment.fromJson(jsonResponse['data']);
      } else {
        throw Exception('Failed to add comment');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<bool> saveArticle(String articleId) async {
    try {
      final token = await storageService.getToken();
      final response = await http.post(
        Uri.parse('$baseUrl/articles/$articleId/save'),
        headers: {'Authorization': 'Bearer $token'},
      );
      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<bool> unsaveArticle(String articleId) async {
    try {
      final token = await storageService.getToken();
      final response = await http.delete(
        Uri.parse('$baseUrl/articles/$articleId/unsave'),
        headers: {'Authorization': 'Bearer $token'},
      );
      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<bool> likeArticle(String articleId, double rating) async {
    try {
      final token = await storageService.getToken();
      final response = await http.post(
        Uri.parse('$baseUrl/articles/$articleId/like'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'rating': rating}),
      );
      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<bool> unlikeArticle(String articleId) async {
    try {
      final token = await storageService.getToken();
      final response = await http.delete(
        Uri.parse('$baseUrl/articles/$articleId/unlike'),
        headers: {'Authorization': 'Bearer $token'},
      );
      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
