import 'package:get/get.dart';
import 'package:flutter_kawan_tani/services/auth/auth_service.dart';

class OTPController extends GetxController {
  var verificationCode = ''.obs;
  var isVerifying = false.obs;
  var isResending = false.obs;

  Future<bool> verifyCode(String token, String code) async {
    isVerifying.value = true;
    try {
      final response = await AuthService.verifyAccount(
        token: token,
        verificationCode: code,
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        // Handle error
        return false;
      }
    } catch (e) {
      // Handle exception
      return false;
    } finally {
      isVerifying.value = false;
    }
  }

  Future<bool> resendCode(String token) async {
    isResending.value = true;
    try {
      final response = await AuthService.sendActivation(token);
      if (response.statusCode == 200) {
        return true;
      } else {
        // Handle error
        return false;
      }
    } catch (e) {
      // Handle exception
      return false;
    } finally {
      isResending.value = false;
    }
  }
}
