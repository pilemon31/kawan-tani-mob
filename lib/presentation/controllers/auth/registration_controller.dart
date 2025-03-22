import "package:get/get.dart";
import 'package:flutter/foundation.dart';


class RegistrationController extends GetxController {
  //Insialisasi data user
  final firstName = "".obs;
  final lastName = "".obs;
  final emailAddress = "".obs;
  final phoneNumber = "".obs;
  final gender = "".obs;
  final password = "".obs;

  //Function untuk mengirim ke backend
  Future<bool> submitRegistration() async {
    final userData = {
      'First Name': firstName.value,
      'Last Name': firstName.value,
      'Email': emailAddress.value,
      'Phone Number': phoneNumber.value,
      'Gender': gender.value,
      'password': password.value,
    };

    debugPrint('Mengirim data ke backend: $userData');

    await Future.delayed(Duration(seconds: 2));

    return true;
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
