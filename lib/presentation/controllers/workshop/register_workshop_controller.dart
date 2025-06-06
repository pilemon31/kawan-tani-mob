import "package:get/get.dart";
import 'package:flutter/foundation.dart';

class RegisterWorkshopController extends GetxController {
  //Insialisasi data user
  final firstName = "".obs;
  final lastName = "".obs;
  final emailAddress = "".obs;
  final phoneNumber = "".obs;
  final birthDate = "".obs;
  final gender = 0.obs;

  //Function untuk mengirim ke backend
  Future<bool> submitRegistration() async {
    final userData = {
      'Nama Depan': firstName.value,
      'Nama Belakang': lastName.value,
      'Nomor Telepon': phoneNumber.value,
      'Tanggal Lahir': birthDate.value,
      'Jenis Kelamin': gender.value,
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
    birthDate.value = '';
    gender.value = 0;
  }
}
