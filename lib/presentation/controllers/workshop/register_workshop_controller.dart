import "package:get/get.dart";
import 'package:flutter/foundation.dart';

class RegisterWorkshopController extends GetxController {
  //Insialisasi data user
  final attendeesName = "".obs;
  final emailAddress = "".obs;
  final phoneNumber = "".obs;
  final birthDate = "".obs;
  final gender = "".obs;

  //Function untuk mengirim ke backend
  Future<bool> submitRegistration() async {
    final userData = {
      'Nama': attendeesName.value,
      'Email': emailAddress.value,
      'Nomor Telepon': phoneNumber.value,
      'Tanggal Lahir': birthDate.value,
      'Jenis Kelamin': gender.value,
    };

    debugPrint('Mengirim data ke backend: $userData');

    await Future.delayed(Duration(seconds: 2));

    return true;
  }

  void resetForm() {
    attendeesName.value = '';
    emailAddress.value = '';
    phoneNumber.value = '';
    birthDate.value = '';
    gender.value = '';
  }
}
