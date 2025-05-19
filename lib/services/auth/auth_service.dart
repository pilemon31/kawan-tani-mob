import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  // Ganti dengan IP kamu jika test di emulator
  static const String baseUrl = "http://localhost:2000/api";

  // Register User
  static Future<http.Response> registerUser({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String dateOfBirth,
    required int gender,
    required String password,
    required String confirmPassword,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phoneNumber": phoneNumber,
        "dateOfBirth": dateOfBirth,
        "gender": gender,
        "password": password,
        "confirmPassword": confirmPassword,
      }),
    );
    return response;
  }

  // Login User
  static Future<http.Response> loginUser({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );
    return response;
  }

  // Get Me (Current User)
  static Future<http.Response> getMe(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/auth/me'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    return response;
  }

  // Send Activation Code
  static Future<http.Response> sendActivation(String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/sendcode'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    return response;
  }

  // Verify Account
  static Future<http.Response> verifyAccount({
    required String token,
    required String verificationCode,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/verify'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        "verificationCode": verificationCode,
      }),
    );
    return response;
  }

  // Login Admin
  static Future<http.Response> loginAdmin({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/admin/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );
    return response;
  }
}
