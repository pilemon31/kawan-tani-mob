import 'package:get/get.dart';
import 'package:flutter_kawan_tani/shared/storage_service.dart';

class AuthController extends GetxController {
  final StorageService _storageService = StorageService();
  var isLoggedIn = false.obs;
  var token = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    token.value = await _storageService.getToken() ?? '';
    isLoggedIn.value = token.isNotEmpty;
  }

  Future<void> saveAuthData(String newToken) async {
    token.value = newToken;
    await _storageService.saveToken(newToken);
    isLoggedIn.value = true;
  }

  Future<void> logout() async {
    token.value = '';
    await _storageService.clearAll();
    isLoggedIn.value = false;
  }
}
