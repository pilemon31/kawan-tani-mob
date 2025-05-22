import 'dart:io';
import 'package:flutter_kawan_tani/services/auth/auth_service.dart';
import 'package:flutter_kawan_tani/shared/theme.dart';
import "package:get/get.dart";
import 'dart:convert';
import 'package:http/http.dart' as http;

class RegistrationController extends GetxController {
  final firstName = ''.obs;
  final lastName = ''.obs;
  final email = ''.obs;
  final phoneNumber = ''.obs;
  final dateOfBirth = ''.obs;
  final gender = 0.obs; // 0: male, 1: female
  final password = ''.obs;
  final confirmPassword = ''.obs;
  final avatar = Rx<File?>(null);
  final token = ''.obs;
  var isLoading = false.obs;

  Future<bool> registerAccount() async {
    isLoading.value = true;

    try {
      final streamedResponse = await AuthService.registerUser(
        firstName: firstName.value,
        lastName: lastName.value,
        email: email.value,
        phoneNumber: phoneNumber.value,
        dateOfBirth: dateOfBirth.value,
        gender: gender.value,
        password: password.value,
        confirmPassword: confirmPassword.value,
        avatar: avatar.value,
      );

      final http.Response response =
          await http.Response.fromStream(streamedResponse);
      final Map<String, dynamic> responseBody = jsonDecode(response.body);

      isLoading.value = false;

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar(
          "Sukses",
          responseBody['message'] ?? "Registrasi berhasil!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: primaryColor,
          colorText: whiteColor,
        );
        resetForm();
        return true;
      } else {
        Get.snackbar(
          "Gagal",
          responseBody['message'] ?? "Terjadi kesalahan",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: primaryColor,
          colorText: whiteColor,
        );
        return false;
      }
    } catch (error) {
      isLoading.value = false;
      Get.snackbar(
        "Error",
        error.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: primaryColor,
        colorText: whiteColor,
      );
      return false;
    }
  }

  void resetForm() {
    firstName.value = '';
    lastName.value = '';
    email.value = '';
    phoneNumber.value = '';
    dateOfBirth.value = '';
    gender.value = 0;
    password.value = '';
    confirmPassword.value = '';
  }

  void setToken(String newToken) {
    token.value = newToken;
  }
}
