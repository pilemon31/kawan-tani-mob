import 'dart:convert';
import 'package:flutter_kawan_tani/models/article_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_kawan_tani/shared/constants.dart';
import 'package:flutter_kawan_tani/shared/storage_service.dart';

class ArticleService {
  final String baseUrl = Constants.baseUrl;
  final StorageService storageService = StorageService();

  Future<List<Article>> getArticles() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/articles/active'));
      print('Get Articles Response: ${response.statusCode} ${response.body}');
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        List<dynamic> data = jsonResponse['data'];
        return data.map((json) => Article.fromJson(json)).toList();
      } else {
        throw Exception(
            'Failed to load articles: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      print('Get Articles Error: $e');
      throw Exception('Error: $e');
    }
  }

  Future<List<Article>> getAllArticles() async {
    try {
      final token = await storageService.getToken();
      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }
      final response = await http.get(
        Uri.parse('$baseUrl/articles'),
        headers: {'Authorization': 'Bearer $token'},
      );
      print(
          'Get All Articles Response: ${response.statusCode} ${response.body}');
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        List<dynamic> data = jsonResponse['data'];
        return data.map((json) => Article.fromJson(json)).toList();
      } else {
        throw Exception(
            'Failed to load all articles: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      print('Get All Articles Error: $e');
      throw Exception('Error: $e');
    }
  }

  Future<Article> getArticleById(String id) async {
    try {
      final token = await storageService.getToken();
      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }
      final response = await http.get(
        Uri.parse('$baseUrl/articles/$id'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      print(
          'Get Article By ID Response: ${response.statusCode} ${response.body}');
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return Article.fromJson(jsonResponse['data']);
      } else {
        throw Exception('HTTP ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      print('Get Article By ID Error: $e');
      throw Exception('Error: $e');
    }
  }

  Future<List<Article>> getUserArticles() async {
    try {
      final token = await storageService.getToken();
      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }
      final response = await http.get(
        Uri.parse('$baseUrl/articles/own'),
        headers: {'Authorization': 'Bearer $token'},
      );
      print(
          'Get User Articles Response: ${response.statusCode} ${response.body}');
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        List<dynamic> data = jsonResponse['data'];
        return data.map((json) => Article.fromJson(json)).toList();
      } else {
        throw Exception(
            'Failed to load user articles: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      print('Get User Articles Error: $e');
      throw Exception('Error: $e');
    }
  }

  Future<List<Article>> getSavedArticles() async {
    try {
      final token = await storageService.getToken();
      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }
      final response = await http.get(
        Uri.parse('$baseUrl/articles/saved'),
        headers: {'Authorization': 'Bearer $token'},
      );
      print(
          'Get Saved Articles Response: ${response.statusCode} ${response.body}');
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        List<dynamic> data = jsonResponse['data'];
        return data.map((item) => Article.fromJson(item['artikel'])).toList();
      } else {
        throw Exception(
            'Failed to load saved articles: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      print('Get Saved Articles Error: $e');
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
      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/articles/create'),
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
      print('Create Article Response: ${response.statusCode} $responseData');
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(responseData);
        return Article.fromJson(jsonResponse['data']);
      } else {
        throw Exception(
            'Failed to create article: ${response.statusCode} $responseData');
      }
    } catch (e) {
      print('Create Article Error: $e');
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
      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }
      var request = http.MultipartRequest(
        'PUT',
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
      print('Update Article Response: ${response.statusCode} $responseData');
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(responseData);
        return Article.fromJson(jsonResponse['data']);
      } else {
        throw Exception(
            'Failed to update article: ${response.statusCode} $responseData');
      }
    } catch (e) {
      print('Update Article Error: $e');
      throw Exception('Error: $e');
    }
  }

  Future<bool> deleteArticle(String id) async {
    try {
      final token = await storageService.getToken();
      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }
      final response = await http.delete(
        Uri.parse('$baseUrl/articles/$id'),
        headers: {'Authorization': 'Bearer $token'},
      );
      print('Delete Article Response: ${response.statusCode} ${response.body}');
      return response.statusCode == 200;
    } catch (e) {
      print('Delete Article Error: $e');
      throw Exception('Error: $e');
    }
  }

  Future<bool> toggleArticleStatus(String id) async {
    try {
      final token = await storageService.getToken();
      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }
      final response = await http.patch(
        Uri.parse('$baseUrl/articles/$id/toggle'),
        headers: {'Authorization': 'Bearer $token'},
      );
      print(
          'Toggle Article Status Response: ${response.statusCode} ${response.body}');
      return response.statusCode == 200;
    } catch (e) {
      print('Toggle Article Status Error: $e');
      throw Exception('Error: $e');
    }
  }

  Future<bool> verifyArticle(String id) async {
    try {
      final token = await storageService.getToken();
      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }
      final response = await http.patch(
        Uri.parse('$baseUrl/articles/$id/verify'),
        headers: {'Authorization': 'Bearer $token'},
      );
      print('Verify Article Response: ${response.statusCode} ${response.body}');
      return response.statusCode == 200;
    } catch (e) {
      print('Verify Article Error: $e');
      throw Exception('Error: $e');
    }
  }

  Future<Comment> addComment(String articleId, String content) async {
    try {
      final token = await storageService.getToken();
      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }
      final response = await http.post(
        Uri.parse('$baseUrl/articles/$articleId/comments'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'content': content}),
      );
      print('Add Comment Response: ${response.statusCode} ${response.body}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        return Comment.fromJson(jsonResponse['data']);
      } else {
        throw Exception(
            'Failed to add comment: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      print('Add Comment Error: $e');
      throw Exception('Error: $e');
    }
  }

  Future<Article> saveArticle(String articleId) async {
    try {
      final token = await storageService.getToken();
      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }
      final response = await http.post(
        Uri.parse('$baseUrl/articles/$articleId/save'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      print('Save Article Response: ${response.statusCode} ${response.body}');
      if (response.statusCode == 200) {
        // Fetch the updated article to get the latest isSaved state
        return await getArticleById(articleId);
      } else {
        throw Exception(
            'Failed to save article: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      print('Save Article Error: $e');
      throw Exception('Error: $e');
    }
  }

  Future<Article> unsaveArticle(String articleId) async {
    try {
      final token = await storageService.getToken();
      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }
      final response = await http.delete(
        Uri.parse('$baseUrl/articles/$articleId/save'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      print('Unsave Article Response: ${response.statusCode} ${response.body}');
      if (response.statusCode == 200) {
        // Fetch the updated article to get the latest isSaved state
        return await getArticleById(articleId);
      } else {
        throw Exception(
            'Failed to unsave article: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      print('Unsave Article Error: $e');
      throw Exception('Error: $e');
    }
  }

  Future<Article> likeArticle(String articleId) async {
    try {
      final token = await storageService.getToken();
      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }
      final response = await http.post(
        Uri.parse('$baseUrl/articles/$articleId/like'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      print('Like Article Response: ${response.statusCode} ${response.body}');
      if (response.statusCode == 200) {
        // Fetch the updated article to get the latest isLiked state
        return await getArticleById(articleId);
      } else {
        throw Exception(
            'Failed to like article: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      print('Like Article Error: $e');
      throw Exception('Error: $e');
    }
  }

  Future<Article> unlikeArticle(String articleId) async {
    try {
      final token = await storageService.getToken();
      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }
      final response = await http.delete(
        Uri.parse('$baseUrl/articles/$articleId/like'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      print('Unlike Article Response: ${response.statusCode} ${response.body}');
      if (response.statusCode == 200) {
        // Fetch the updated article to get the latest isLiked state
        return await getArticleById(articleId);
      } else {
        throw Exception(
            'Failed to unlike article: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      print('Unlike Article Error: $e');
      throw Exception('Error: $e');
    }
  }
}
