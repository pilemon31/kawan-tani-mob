import 'package:http/http.dart' as http;
import 'dart:convert';

class Authservice {
  //Base URL
  static String baseUrl = "http://localhost:2000/api";

  //Register User Service
  static Future<http.Response> registerUser(
      String firstName,
      String lastName,
      String email,
      String phoneNumber,
      String dateOfBirth,
      int gender,
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
        "gender": gender,
        "password": password,
        "confirmPassword": confirmPassword
      }),
    );
    return response;
  }

  // Login User Service
  static Future<http.Response> loginUser(String email, String password) async {
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

  //Register Workshop
  static Future<http.Response> registerUserWorkshop(String attendeesName,
      String email, String dateOfBirth, String phoneNumber, int gender) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "attendeesName": attendeesName,
        "email": email,
        "dateOfBirth": dateOfBirth,
        "phoneNumber": phoneNumber,
        "gender": gender,
      }),
    );
    return response;
  }
}
