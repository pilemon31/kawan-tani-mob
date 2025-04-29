import 'package:http/http.dart' as http;
import 'dart:convert';

class Authservice {
  //Base URL
  final String baseUrl = "http://localhost:3000";  

  //Register User Service
  Future registerUser({
    required String namaDepanPengguna,
    required String namaBelakangPengguna,
    required String emailPengguna,
    required String nomorTeleponPengguna,
    required String passwordPengguna,
    required String confirmPasswordPengguna,
  }) async {
    final url = Uri.parse('$baseUrl/auth/register');

    try{
      final response = await http.post(
      url, 
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "namaDepanPengguna": namaDepanPengguna,
        "namaBelakangPengguna": namaBelakangPengguna,
        "emailPengguna": emailPengguna,
        "nomorTeleponPengguna": nomorTeleponPengguna,
        "passwordPengguna" : passwordPengguna,
        "confirmPasswordPengguna": confirmPasswordPengguna
      }),
    );
    final data = jsonDecode(response.body);
    return data;
    }catch(error){
      final err = error;
      return err;
    }
  }
}