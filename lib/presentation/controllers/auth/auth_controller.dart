import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  final storage = GetStorage();
  var isLoggedIn = false.obs;
  var token = ''.obs;

  @override
  void onInit() {
    super.onInit();
    token.value = storage.read('token') ?? '';
    isLoggedIn.value = token.isNotEmpty;
  }

  void saveAuthData(String newToken) {
    token.value = newToken;
    storage.write('token', newToken);
    isLoggedIn.value = true;
  }

  void logout() {
    token.value = '';
    storage.remove('token');
    isLoggedIn.value = false;
  }
}
