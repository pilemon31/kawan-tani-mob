import 'package:flutter_kawan_tani/services/auth/auth_service.dart';
import 'package:flutter_kawan_tani/shared/theme.dart';
import "package:get/get.dart";
import 'dart:convert';

class RegistrationController extends GetxController {
  final firstName = "".obs;
  final lastName = "".obs;
  final email = "".obs;
  final phoneNumber = "".obs;
  final gender = "".obs;
  final password = "".obs;
  final confirmPassword = "".obs;
  final dateOfBirth = "".obs;
  var isLoading = false.obs;

  Future<void> registerAccount() async {
    isLoading.value = true;

    try {
      final response = await Authservice.registerUser(
          firstName.value,
          lastName.value,
          email.value,
          phoneNumber.value,
          dateOfBirth.value,
          password.value,
          confirmPassword.value);

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
      } else {
        Get.snackbar(
          "Gagal",
          responseBody['message'] ?? "Terjadi kesalahan",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: primaryColor,
          colorText: whiteColor,
        );
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
    }
  }

  void resetForm() {
    firstName.value = '';
    lastName.value = '';
    email.value = '';
    phoneNumber.value = '';
    dateOfBirth.value = '';
    gender.value = '';
    password.value = '';
  }
}
