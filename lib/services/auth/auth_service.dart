import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'package:flutter_kawan_tani/shared/constants.dart';
import 'package:flutter_kawan_tani/shared/storage_service.dart'; 
import 'package:flutter_kawan_tani/models/user_model.dart';

class AuthService {
  static const String baseUrl = Constants.baseUrl;
  final StorageService _storageService = StorageService();

  // Register User
  static Future<http.StreamedResponse> registerUser({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String dateOfBirth,
    required int gender,
    required String password,
    required String confirmPassword,
    File? avatar,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/auth/register');
      final request = http.MultipartRequest('POST', uri);

      // Add text fields
      request.fields['firstName'] = firstName;
      request.fields['lastName'] = lastName;
      request.fields['email'] = email;
      request.fields['phoneNumber'] = phoneNumber;
      request.fields['dateOfBirth'] = dateOfBirth;
      request.fields['gender'] = gender.toString();
      request.fields['password'] = password;
      request.fields['confirmPassword'] = confirmPassword;

      // Add avatar file if exists
      if (avatar != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'avatar',
            avatar.path,
            filename: 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg',
          ),
        );
      }

      // Add headers if needed
      request.headers.addAll({
        'Accept': 'application/json',
      });

      // Send request
      return await request.send();
    } catch (e) {
      throw Exception('Failed to register user: $e');
    }
  }

  // Login User
  static Future<http.Response> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/auth/login'),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode({
              'email': email,
              'password': password,
            }),
          )
          .timeout(const Duration(seconds: 10));

      return response;
    } catch (e) {
      throw Exception('Gagal login user: $e');
    }
  }

  // Get User Data
  static Future<http.Response> getUserData({required String token}) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/me'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ).timeout(const Duration(seconds: 10));

      return response;
    } catch (e) {
      throw Exception('Gagal mengambil data user: $e');
    }
  }

  // Kirim Kode Aktivasi
  static Future<http.Response> sendActivation(String token) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/sendcode'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ).timeout(const Duration(seconds: 10));
      return response;
    } catch (e) {
      throw Exception('Gagal mengirim kode aktivasi: $e');
    }
  }

  // Verifikasi Akun
  static Future<http.Response> verifyAccount({
    required String token,
    required String verificationCode,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/auth/activate'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode({
              "verificationCode": verificationCode,
            }),
          )
          .timeout(const Duration(seconds: 10));
      return response;
    } catch (e) {
      throw Exception('Gagal verifikasi akun: $e');
    }
  }

  // Login Admin
  static Future<http.Response> loginAdmin({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/auth/admin/login'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              "email": email,
              "password": password,
            }),
          )
          .timeout(const Duration(seconds: 10));
      return response;
    } catch (e) {
      throw Exception('Gagal login admin: $e');
    }
  }

  static Future<http.Response> updateProfile({
    required String token,
    required Map<String, dynamic> data,
  }) async {
    try {
      final url = Uri.parse('$baseUrl/users/me/update');

      // Debug log
      debugPrint('Update Profile Request:');
      debugPrint('URL: $url');
      debugPrint('Data: ${jsonEncode(data)}');

      // Filter out empty password fields
      final cleanData = Map<String, dynamic>.from(data)
        ..removeWhere((key, value) =>
            (key == 'password' || key == 'confirmPassword') &&
            (value == null || value.toString().isEmpty));

      final response = await http
          .put(
            url,
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode(cleanData),
          )
          .timeout(const Duration(seconds: 15));

      // Debug log
      debugPrint('Update Profile Response:');
      debugPrint('Status: ${response.statusCode}');
      debugPrint('Body: ${response.body}');

      if (response.statusCode >= 400) {
        final errorBody = jsonDecode(response.body);
        throw Exception(errorBody['message'] ?? 'Gagal memperbarui profil');
      }

      return response;
    } on SocketException {
      throw Exception('Tidak ada koneksi internet');
    } on TimeoutException {
      throw Exception('Waktu permintaan habis');
    } on FormatException {
      throw Exception('Format respons tidak valid');
    } catch (e) {
      throw Exception('Gagal update profil: ${e.toString()}');
    }
  }

   Future<User> validateToken() async {
    try {
      // 1. Ambil token dari StorageService Anda
      final token = await _storageService.getToken();

      if (token == null || token.isEmpty) {
        throw Exception('Token tidak ditemukan. Pengguna belum login.');
      }

      // 2. Lakukan request ke API dengan header otentikasi
      final response = await http.get(
        Uri.parse('$baseUrl/auth/validate'), // Endpoint validasi
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      // 3. Periksa status code dan parse response
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        // Parse JSON response menjadi User model
        return User.fromJson(jsonResponse);
      } else {
        // Handle error jika token tidak valid atau ada masalah lain
        print('Gagal memvalidasi token: ${response.body}');
        throw Exception('Gagal memvalidasi pengguna (Status: ${response.statusCode})');
      }
    } catch (e) {
      print('Error di AuthService: $e');
      // Lempar kembali error agar bisa ditangani di controller
      throw Exception('Terjadi kesalahan saat validasi: $e');
    }
  }
}
