import 'dart:convert';
import 'package:flutter_kawan_tani/services/auth/auth_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_kawan_tani/presentation/controllers/auth/auth_controller.dart';

class LoginController extends GetxController {
  final AuthController _authController = Get.find<AuthController>();
  final email = "".obs;
  final password = "".obs;
  var isLoading = false.obs;
  var errorMessage = "".obs;

  Future<bool> loginAccount() async {
    isLoading.value = true;
    errorMessage.value = "";

    try {
      final response = await AuthService.loginUser(
        email: email.value,
        password: password.value,
      );

      final Map<String, dynamic> responseBody = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (responseBody['success'] == true) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', responseBody['data']['token']);
          await prefs.setString(
              'user', jsonEncode(responseBody['data']['user']));

          _authController.saveAuthData(responseBody['data']['token']);

          return true;
        } else {
          errorMessage.value = responseBody['message'] ?? "Gagal login";
          return false;
        }
      } else {
        errorMessage.value =
            responseBody['message'] ?? "Gagal login (${response.statusCode})";
        return false;
      }
    } catch (error) {
      errorMessage.value = "Error: ${error.toString()}";
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
