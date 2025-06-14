import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_kawan_tani/shared/constants.dart';
import 'package:flutter_kawan_tani/shared/storage_service.dart';
import 'package:flutter_kawan_tani/models/plant_category_model.dart';

class PlantCategoryService {
  final String baseUrl = Constants.baseUrl;
  final StorageService storageService = StorageService();

  Future<List<PlantCategory>> getAllCategories() async {
    try {
      final token = await storageService.getToken();

      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/categories/plants'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        List<dynamic> data = jsonResponse['data']['categories'];
        return data.map((json) => PlantCategory.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load plant categories');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<PlantCategory> getCategoryById(int id) async {
    try {
      final token = await storageService.getToken();

      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/categories/plants/$id'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return PlantCategory.fromJson(jsonResponse['data']['provinces']);
      } else {
        throw Exception('Failed to load plant category');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
