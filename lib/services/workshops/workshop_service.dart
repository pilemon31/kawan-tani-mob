import 'dart:convert';
import 'package:flutter_kawan_tani/models/workshop_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_kawan_tani/shared/constants.dart';

class WorkshopService {
  final String baseUrl = Constants.baseUrl;

  Future<String> _getToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }
      return token;
    } catch (e) {
      print('Token retrieval error: $e');
      throw Exception('Failed to get authentication token');
    }
  }

  Future<List<Workshop>> getAllWorkshops() async {
    try {
      final token = await _getToken();
      final response = await http.get(
        Uri.parse('$baseUrl/workshops'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        return data.map((json) => Workshop.fromJson(json)).toList();
      } else {
        throw Exception('HTTP ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to load workshops: $e');
    }
  }

  Future<List<WorkshopRegistration>> getRegisteredWorkshops() async {
    try {
      final token = await _getToken();
      final response = await http.get(
        Uri.parse('$baseUrl/workshops/registered'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        return data.map((json) => WorkshopRegistration.fromJson(json)).toList();
      } else {
        throw Exception('HTTP ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to load workshops: $e');
    }
  }

  Future<List<Workshop>> getActiveWorkshops() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/workshops/verified'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        return data.map((json) => Workshop.fromJson(json)).toList();
      } else {
        throw Exception('HTTP ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      print('Error in getActiveWorkshops: $e');
      throw Exception('Failed to load active workshops: $e');
    }
  }

  Future<Workshop> getWorkshopById(String id) async {
    try {
      final token = await _getToken();
      final response = await http.get(
        Uri.parse('$baseUrl/workshops/$id'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return Workshop.fromJson(json.decode(response.body)['data']);
      } else {
        throw Exception('HTTP ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      print('Error in getWorkshopById: $e');
      throw Exception('Failed to load workshop details: $e');
    }
  }

  Future<Workshop> createWorkshop(CreateWorkshopRequest request) async {
    try {
      final token = await _getToken();
      final response = await http.post(
        Uri.parse('$baseUrl/workshops/create'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(request.toJson()),
      );

      if (response.statusCode == 200) {
        return Workshop.fromJson(json.decode(response.body)['data']);
      } else {
        throw Exception('HTTP ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      print('Error in createWorkshop: $e');
      throw Exception('Failed to create workshop: $e');
    }
  }

  Future<Workshop> verifyWorkshop(String id) async {
    try {
      final token = await _getToken();
      final response = await http.put(
        Uri.parse('$baseUrl/workshops/$id'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return Workshop.fromJson(json.decode(response.body)['data']);
      } else {
        throw Exception('HTTP ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      print('Error in verifyWorkshop: $e');
      throw Exception('Failed to verify workshop: $e');
    }
  }

  Future<void> deleteWorkshop(String id) async {
    try {
      final token = await _getToken();
      final response = await http.delete(
        Uri.parse('$baseUrl/workshops/$id'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode != 200) {
        throw Exception('HTTP ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      print('Error in deleteWorkshop: $e');
      throw Exception('Failed to delete workshop: $e');
    }
  }

  Future<WorkshopRegistration> registerWorkshop(
      String workshopId, RegisterWorkshopRequest request) async {
    try {
      final token = await _getToken();
      final response = await http.post(
        Uri.parse('$baseUrl/workshops/$workshopId/register'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(request.toJson()),
      );

      if (response.statusCode == 200) {
        return WorkshopRegistration.fromJson(
            json.decode(response.body)['data']);
      } else {
        throw Exception('HTTP ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      print('Error in registerWorkshop: $e');
      throw Exception('Failed to register for workshop: $e');
    }
  }

  // Future<WorkshopRegistration> payRegistration(String ticketNumber) async {
  //   try {
  //     final token = await _getToken();
  //     final response = await http.patch(
  //       Uri.parse('$baseUrl/workshops/payment'),
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //         'Content-Type': 'application/json',
  //       },
  //       body: json.encode({'ticketNumber': ticketNumber}),
  //     );

  //     if (response.statusCode == 200) {
  //       return WorkshopRegistration.fromJson(
  //           json.decode(response.body)['data']);
  //     } else {
  //       throw Exception('HTTP ${response.statusCode}: ${response.body}');
  //     }
  //   } catch (e) {
  //     print('Error in payRegistration: $e');
  //     throw Exception('Failed to process payment: $e');
  //   }
  // }

  Future<List<WorkshopRegistration>> getWorkshopParticipants() async {
    try {
      final token = await _getToken();
      final response = await http.get(
        Uri.parse('$baseUrl/workshops/participants'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        return data.map((json) => WorkshopRegistration.fromJson(json)).toList();
      } else {
        throw Exception('HTTP ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      print('Error in getWorkshopParticipants: $e');
      throw Exception('Failed to load workshop participants: $e');
    }
  }

  Future<List<Workshop>> getOwnWorkshops() async {
    try {
      final token = await _getToken();
      final response = await http.get(
        Uri.parse('$baseUrl/workshops/own'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        return data.map((json) => Workshop.fromJson(json)).toList();
      } else {
        throw Exception('HTTP ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      print('Error in getOwnWorkshops: $e');
      throw Exception('Failed to load own workshops: $e');
    }
  }
}
