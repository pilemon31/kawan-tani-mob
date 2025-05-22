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

      print('🔄 Loading initial data...');

      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString('user');

      if (userJson != null) {
        final localUser = Map<String, dynamic>.from(jsonDecode(userJson));
        user.assignAll(localUser);
        print('📱 Loaded from local storage: ${user.toString()}');
      }

      // Skip server fetch since /api/auth/me endpoint doesn't work
      // We'll rely on local data and update responses
      print('ℹ️ Using local data only (server /api/auth/me not available)');
    } catch (e) {
      print('❌ Error loading initial data: $e');
      errorMessage('Gagal memuat data: ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchUserData() async {
    try {
      print('🌐 Fetching user data from server...');

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        print('⚠️ No token found, skipping fetch');
        return;
      }

      // Skip fetching from server since /api/auth/me endpoint doesn't exist
      // We'll rely on the data we get from update response
      print('⚠️ Skipping server fetch since /api/auth/me endpoint returns 404');
      return;
    } catch (e) {
      print('❌ Error fetching user data: $e');
    }
  }

  Future<bool> updateProfile(Map<String, dynamic> newData) async {
    try {
      isLoading(true);
      errorMessage('');

      print('🔄 Updating profile with data: $newData');

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

      print('📡 Update response status: ${response.statusCode}');
      print('📡 Update response body: ${response.body}');

      // Parse response
      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print('✅ Profile updated successfully on server');

        // Extract user data from response - check both possible locations
        Map<String, dynamic>? updatedUser;

        if (responseBody['data'] != null) {
          // Try data.pengguna first (based on your server response)
          if (responseBody['data']['pengguna'] != null) {
            updatedUser =
                Map<String, dynamic>.from(responseBody['data']['pengguna']);
            print('📦 Found user data in data.pengguna: $updatedUser');
          }
          // Fallback to data.user
          else if (responseBody['data']['user'] != null) {
            updatedUser =
                Map<String, dynamic>.from(responseBody['data']['user']);
            print('📦 Found user data in data.user: $updatedUser');
          }
          // Fallback to data directly
          else {
            updatedUser = Map<String, dynamic>.from(responseBody['data']);
            print('📦 Using data directly: $updatedUser');
          }
        }

        if (updatedUser != null) {
          // Fix the typo in server response if it exists
          if (updatedUser.containsKey('fistName') &&
              !updatedUser.containsKey('firstName')) {
            updatedUser['firstName'] = updatedUser['fistName'];
            updatedUser.remove('fistName');
            print('🔧 Fixed firstName typo from server response');
          }

          // Merge with existing data to preserve fields not returned by server
          final mergedData = Map<String, dynamic>.from(user);
          mergedData.addAll(updatedUser);

          // Update user data
          user.clear();
          user.assignAll(mergedData);
          print('✅ User data updated locally: ${user.toString()}');

          // Save to SharedPreferences
          await prefs.setString('user', jsonEncode(mergedData));
          print('💾 Saved updated data to SharedPreferences');

          // Force UI refresh
          user.refresh();
        }

        return true;
      } else {
        throw Exception(responseBody['message'] ?? 'Gagal memperbarui profil');
      }
    } catch (e) {
      print('❌ Error updating profile: $e');
      errorMessage(e.toString());
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  // Method untuk manual refresh (hanya refresh dari local storage)
  Future<void> refreshProfile() async {
    print('🔄 Manual refresh triggered');
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');

    if (userJson != null) {
      final localUser = Map<String, dynamic>.from(jsonDecode(userJson));
      user.clear();
      user.assignAll(localUser);
      user.refresh();
      print('✅ Profile refreshed from local storage: ${user.toString()}');
    }
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
