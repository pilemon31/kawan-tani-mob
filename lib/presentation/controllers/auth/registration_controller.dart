import 'package:flutter_kawan_tani/services/auth/auth_service.dart';
import 'package:flutter_kawan_tani/shared/theme.dart';
import "package:get/get.dart";

class RegistrationController extends GetxController {
  final Authservice _authservice = new Authservice();

  final firstName = "".obs;
  final lastName = "".obs;
  final emailAddress = "".obs;
  final phoneNumber = "".obs;
  final gender = "".obs;
  final password = "".obs;
  var isLoading = false.obs;

  Future<void> registerAccount() async {
    isLoading.value = true;
    
    try{
      final response = await _authservice.registerUser(
      namaDepanPengguna: firstName.value,
      namaBelakangPengguna: lastName.value,
      emailPengguna: emailAddress.value,
      nomorTeleponPengguna: phoneNumber.value,
      passwordPengguna: password.value,
      confirmPasswordPengguna: password.value);
    isLoading.value = false;

    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.snackbar(
        "Sukses",
        response['message'] ?? "Registrasi berhasil!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: primaryColor,
        colorText: whiteColor,
      );
      resetForm();
    } else {
      Get.snackbar(
        "Gagal",
        response['message'] ?? "Terjadi kesalahan",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: primaryColor,
        colorText: whiteColor,
      );
    }
    }catch(error){
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
    emailAddress.value = '';
    phoneNumber.value = '';
    gender.value = '';
    password.value = '';
  }
}
