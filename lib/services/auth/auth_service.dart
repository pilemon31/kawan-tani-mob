import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class AuthService {
  // Ganti sesuai IP kamu kalau di emulator
  static const String baseUrl = "http://localhost:2000/api";

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

      // Tambahkan field biasa
      request.fields['firstName'] = firstName;
      request.fields['lastName'] = lastName;
      request.fields['email'] = email;
      request.fields['phoneNumber'] = phoneNumber;
      request.fields['dateOfBirth'] = dateOfBirth;
      request.fields['gender'] = gender.toString();
      request.fields['password'] = password;
      request.fields['confirmPassword'] = confirmPassword;

      // Tambahkan file avatar jika ada
      if (avatar != null) {
        request.files
            .add(await http.MultipartFile.fromPath('avatar', avatar.path));
      }

      // Kirim request
      return await request.send();
    } catch (e) {
      throw Exception('Gagal register user: $e');
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
  static Future<http.Response> getMe(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/auth/me'),
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

    print('Sending update to: $url'); // Debug log
    print('Payload: $data'); // Debug log

    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(data),
    ).timeout(const Duration(seconds: 10));

    print('Response status: ${response.statusCode}'); // Debug log
    print('Response body: ${response.body}'); // Debug log

    if (response.statusCode >= 400) {
      throw Exception('Server error: ${response.statusCode}');
    }

    return response;
  } catch (e) {
    print('Update profile error: $e'); // Debug log
    throw Exception('Gagal update profil: $e');
  }
}
}
