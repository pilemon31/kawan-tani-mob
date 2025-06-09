import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_kawan_tani/shared/constants.dart';
import 'package:flutter_kawan_tani/shared/storage_service.dart';
import 'package:flutter_kawan_tani/models/user_plant_model.dart';

class UserPlantService {
  final String baseUrl = Constants.baseUrl;
  final StorageService storageService = StorageService();

  Future<List<UserPlant>> getUserPlants() async {
    try {
      final token = await storageService.getToken();

      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/user-plants'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        List<dynamic> data = jsonResponse['data'];
        return data.map((json) => UserPlant.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load user plants');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<UserPlant> getUserPlantDetail(String userPlantId) async {
    try {
      final token = await storageService.getToken();

      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/user-plants/$userPlantId'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return UserPlant.fromJson(jsonResponse['data']);
      } else {
        throw Exception('Failed to load user plant detail');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<UserPlant> createUserPlant({
    required String plantId,
    required String customName,
  }) async {
    try {
      final token = await storageService.getToken();

      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      final response = await http.post(
        Uri.parse('$baseUrl/user-plants'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'plantId': plantId,
          'customName': customName,
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return UserPlant.fromJson(jsonResponse['data']);
      } else {
        throw Exception('Failed to create user plant');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<UserPlantingDay>> getDailyTasks({
    required String userPlantId,
    String? date,
  }) async {
    try {
      final token = await storageService.getToken();

      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/user-plants/$userPlantId/daily-tasks${date != null ? '?date=$date' : ''}'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        List<dynamic> data = jsonResponse['data'];
        return data.map((json) => UserPlantingDay.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load daily tasks');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<UserPlantingDay>> getTodayTasks() async {
    try {
      final token = await storageService.getToken();

      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/today-tasks'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        List<dynamic> data = jsonResponse['data'];
        return data.map((json) => UserPlantingDay.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load today tasks');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<UserPlantingTask> updateTaskProgress({
    required String userPlantId,
    required String taskId,
    required bool doneStatus,
  }) async {
    try {
      final token = await storageService.getToken();

      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      final response = await http.patch(
        Uri.parse('$baseUrl/user-plants/$userPlantId/tasks/$taskId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'doneStatus': doneStatus}),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return UserPlantingTask.fromJson(jsonResponse['data']);
      } else {
        throw Exception('Failed to update task progress');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<UserPlant> finishPlant(String userPlantId) async {
    try {
      final token = await storageService.getToken();

      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      final response = await http.patch(
        Uri.parse('$baseUrl/user-plants/$userPlantId/finish'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return UserPlant.fromJson(jsonResponse['data']);
      } else {
        throw Exception('Failed to finish plant');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}