import 'dart:convert';
import 'package:flutter_kawan_tani/services/auth/auth_service.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final email = "".obs;
  final password = "".obs;
  var isLoading = false.obs;
  var errorMessage = "".obs;

  Future<bool> loginAccount() async {
    isLoading.value = true;
    errorMessage.value = "";
    try {
      final response = await Authservice.loginUser(
        email.value,
        password.value,
      );

      final Map<String, dynamic> responseBody = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        errorMessage.value = responseBody['message'] == "Credential invalid!"
            ? "Email atau password salah!"
            : responseBody['message'];
        return false;
      }
    } catch (error) {
      errorMessage.value = "Terjadi kesalahan saat login";
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
