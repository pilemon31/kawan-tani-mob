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
    if (value == null) {
      return "Password harus diisi!";
    }

    if (value.length < 8) {
      return "Passsword harus lebih dari 8 karakter";
    }

    return null;
  }
}
