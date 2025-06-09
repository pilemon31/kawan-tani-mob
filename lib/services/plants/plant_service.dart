import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_kawan_tani/shared/constants.dart';
import 'package:flutter_kawan_tani/shared/storage_service.dart';
import 'package:flutter_kawan_tani/models/plant_model.dart';

class PlantService {
  final String baseUrl = Constants.baseUrl;
  final StorageService storageService = StorageService();

  Future<List<Plant>> getAllPlants() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/plants'));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        List<dynamic> data = jsonResponse['data']['categories'];
        return data.map((json) => Plant.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load plants');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Plant> getPlantById(String id) async {
    try {
      final token = await storageService.getToken();

      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/plants/$id'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return Plant.fromJson(jsonResponse['data']['provinces']);
      } else {
        throw Exception('Failed to load plant');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
