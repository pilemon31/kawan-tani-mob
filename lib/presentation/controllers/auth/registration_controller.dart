import 'package:flutter_kawan_tani/services/auth/auth_service.dart';
import 'package:flutter_kawan_tani/shared/theme.dart';
import "package:get/get.dart";
import 'dart:convert';

class RegistrationController extends GetxController {
  final firstName = "".obs;
  final lastName = "".obs;
  final email = "".obs;
  final phoneNumber = "".obs;
  final gender = 0.obs;
  final password = "".obs;
  final confirmPassword = "".obs;
  final dateOfBirth = "".obs;
  final RxString token = ''.obs;
  var isLoading = false.obs;

  Future<bool> registerAccount() async {
    isLoading.value = true;

    try {
      final response = await AuthService.registerUser(
        firstName: firstName.value,
        lastName: lastName.value,
        email: email.value,
        phoneNumber: phoneNumber.value,
        dateOfBirth: dateOfBirth.value,
        gender: gender.value,
        password: password.value,
        confirmPassword: confirmPassword.value,
      );

      isLoading.value = false;
      final Map<String, dynamic> responseBody = jsonDecode(response.body);

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
