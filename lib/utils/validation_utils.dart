import 'package:intl/intl.dart';

class ValidationService {
  String? validateEmail(String? value) {
    if (value == null) {
      return ("Email harus diisi!");
    }

    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return ("Masukkan Email Yang Valid");
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password harus diisi!";
    }

    if (value.length < 8) {
      return "Passsword harus lebih dari 8 karakter";
    }

    return null;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Nama harus diisi!";
    }

    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "Nomor harus diisi!";
    }

    return null;
  }

  String? validateGender(String? value) {
    if (value == null || value.isEmpty) {
      return "Jenis kelamin harus diisi!";
    }

    return null;
  }

String? validateBirthDate(String? value) {
  if (value == null || value.isEmpty) {
    return "Tanggal lahir harus diisi!";
  }

  try {
    final inputDate = DateFormat('dd/MM/yyyy').parseStrict(value);
    if (inputDate.isAfter(DateTime.now())) {
      return "Tanggal lahir tidak boleh di masa depan!";
    }
  } catch (e) {
    return "Format tanggal tidak valid!";
  }

  return null;
}

}
