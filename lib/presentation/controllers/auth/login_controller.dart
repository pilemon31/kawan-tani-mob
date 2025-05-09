import 'dart:convert';

import 'package:flutter_kawan_tani/services/auth/auth_service.dart';
import 'package:flutter_kawan_tani/shared/theme.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final email = "".obs;
  final password = "".obs;
  var isLoading = false.obs;
  Future<bool> loginAccount() async {
    isLoading.value = true;
    try {
      final response = await Authservice.loginUser(
        email.value,
        password.value,
      );

      final Map<String, dynamic> responseBody = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar(
          "Sukses",
          responseBody['message'] ?? "Login berhasil!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: primaryColor,
          colorText: whiteColor,
        );
        return true;
      } else {
        Get.snackbar(
          "Gagal",
          responseBody['message'] ?? "Email atau password salah",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: primaryColor,
          colorText: whiteColor,
        );
        return false;
      }
    } catch (error) {
      Get.snackbar(
        "Error",
        "Terjadi kesalahan saat login",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: primaryColor,
        colorText: whiteColor,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
