import 'dart:convert';
import 'package:flutter_kawan_tani/presentation/pages/login/login_screen.dart';
import 'package:flutter_kawan_tani/services/auth/auth_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  final RxMap<String, dynamic> user = <String, dynamic>{}.obs;
  final isLoading = true.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadInitialData();
  }

  Future<void> loadInitialData() async {
    try {
      isLoading(true);
      errorMessage('');

      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString('user');

      if (userJson != null) {
        final localUser = Map<String, dynamic>.from(jsonDecode(userJson));
        user.assignAll(localUser);
      }

      await fetchUserData();
    } catch (e) {
      errorMessage('Gagal memuat data: ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        return;
      }

      final response = await AuthService.getUserData(token: token);

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);

        if (responseBody['success'] == true && responseBody['data'] != null) {
          final userData = responseBody['data']['user'];

          final mappedUser = {
            'id': userData['id_pengguna'],
            'firstName': userData['nama_depan_pengguna'],
            'lastName': userData['nama_belakang_pengguna'],
            'email': userData['email_pengguna'],
            'phoneNumber': userData['nomor_telepon_pengguna'],
            'gender': userData['jenisKelamin'],
            'avatar': userData['avatar'],
            'dateOfBirth': userData['tanggal_lahir_pengguna'],
            'status_verifikasi': userData['status_verfikasi'],
          };

          user.clear();
          user.assignAll(mappedUser);

          await prefs.setString('user', jsonEncode(mappedUser));
          user.refresh();
        }
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<bool> updateProfile(Map<String, dynamic> newData) async {
    try {
      isLoading(true);
      errorMessage('');

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        throw Exception('Token tidak tersedia. Silakan login kembali.');
      }

      // Kirim permintaan update
      final response = await AuthService.updateProfile(
        token: token,
        data: newData,
      );
      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Map<String, dynamic>? updatedUser;

        if (responseBody['data'] != null) {
          if (responseBody['data']['pengguna'] != null) {
            updatedUser =
                Map<String, dynamic>.from(responseBody['data']['pengguna']);
          } else if (responseBody['data']['user'] != null) {
            updatedUser =
                Map<String, dynamic>.from(responseBody['data']['user']);
          } else {
            updatedUser = Map<String, dynamic>.from(responseBody['data']);
          }
        }

        if (updatedUser != null) {
          if (updatedUser.containsKey('fistName') &&
              !updatedUser.containsKey('firstName')) {
            updatedUser['firstName'] = updatedUser['fistName'];
            updatedUser.remove('fistName');
          }

          final mergedData = Map<String, dynamic>.from(user);
          mergedData.addAll(updatedUser);

          user.clear();
          user.assignAll(mergedData);

          await prefs.setString('user', jsonEncode(mergedData));
          user.refresh();
        }
        await fetchUserData();
        return true;
      } else {
        throw Exception(responseBody['message'] ?? 'Gagal memperbarui profil');
      }
    } catch (e) {
      errorMessage(e.toString());
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  Future<void> refreshProfile() async {
    try {
      isLoading(true);

      await fetchUserData();

      if (user.isEmpty) {
        final prefs = await SharedPreferences.getInstance();
        final userJson = prefs.getString('user');

        if (userJson != null) {
          final localUser = Map<String, dynamic>.from(jsonDecode(userJson));
          user.clear();
          user.assignAll(localUser);
          user.refresh();
        }
      }
    } catch (e) {
      print('Error refreshing profile: $e');
    } finally {
      isLoading(false);
    }
  }

  String getAvatarUrl() {
    final avatar = user['avatar'];
    if (avatar != null && avatar.toString().isNotEmpty) {
      return 'https://kawan-tani-backend-production.up.railway.app/uploads/users/$avatar';
    }
    return '';
  }

  Future<void> logout() async {
    try {
      isLoading(true);
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      await prefs.remove('user');
      user.clear();
      Get.offAll(() => LogInScreen());
    } finally {
      isLoading(false);
    }
  }
}
