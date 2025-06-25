import 'package:get/get.dart';
import 'package:flutter_kawan_tani/shared/storage_service.dart';
import 'package:flutter_kawan_tani/models/user_model.dart';
import 'package:flutter_kawan_tani/services/auth/auth_service.dart';

class AuthController extends GetxController {
  final StorageService _storageService = StorageService();
  final AuthService _authService = AuthService();
  var isLoggedIn = false.obs;
  var token = ''.obs;
  var isAuthenticated = false.obs;
  var isLoading = false.obs;
  var currentUser = User().obs;

  @override
  void onInit() {
    fetchCurrentUser();
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

   Future<void> fetchCurrentUser() async {
    try {
      isLoading(true);
      final user = await _authService.validateToken();
      currentUser.value = user;
      isAuthenticated.value = true;
    } catch (e) {
      isAuthenticated.value = false;
      print("Gagal mengambil data pengguna: $e");
    } finally {
      isLoading(false);
    }
  }
}
