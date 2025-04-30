import 'package:http/http.dart' as http;
import 'dart:convert';

class Authservice {
  //Base URL
  static String baseUrl = "http://localhost:3000/api";

  //Register User Service
  static Future<http.Response> registerUser(
      String firstName,
      String lastName,
      String email,
      String phoneNumber,
      String dateOfBirth,
      String password,
      String confirmPassword) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phoneNumber": phoneNumber,
        "dateOfBirth": dateOfBirth,
        "password": password,
        "confirmPassword": confirmPassword
      }),
    );
    return response;
  }
}
