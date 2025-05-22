import 'dart:convert';
import 'package:flutter/material.dart';
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
        user.assignAll(Map<String, dynamic>.from(jsonDecode(userJson)));
      }
    } catch (e) {
      errorMessage('Gagal memuat data: ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchUserData() async {
    try {
      isLoading(true);
      errorMessage('');

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) throw Exception('Token tidak tersedia');

      final response = await AuthService.getMe(token);
      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200 && responseBody['success'] == true) {
        final userData =
            Map<String, dynamic>.from(responseBody['data']['user'] ?? {});
        user.assignAll(userData);
        await prefs.setString('user', jsonEncode(user));
      } else {
        throw Exception(responseBody['message'] ?? 'Gagal mengambil data');
      }
    } catch (e) {
      errorMessage('Gagal memuat data pengguna: ${e.toString()}');
      rethrow;
    } finally {
      isLoading(false);
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

      // Prepare the complete data to be sent
      final dataToSend = {
        'firstName': newData['firstName'],
        'lastName': newData['lastName'],
        'phoneNumber': newData['phoneNumber'],
        'email': newData['email'],
        'dateOfBirth': newData['dateOfBirth'],
        'gender': newData['gender'],
        'password':
            newData['password'] ?? '', // Add empty string if not provided
        'confirmPassword': newData['confirmPassword'] ??
            '', // Add empty string if not provided
      };

      // Send update to server
      final response = await AuthService.updateProfile(
        token: token,
        data: dataToSend,
      );

      // Handle HTML responses that might come from server errors
      if (response.body.trim().startsWith('<!DOCTYPE')) {
        throw Exception('Server mengalami masalah. Silakan coba lagi nanti.');
      }

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200 && responseBody['success'] == true) {
        // Update local user data (excluding password fields)
        final updatedUser = Map<String, dynamic>.from(user)
          ..addAll({
            'firstName': newData['firstName'],
            'lastName': newData['lastName'],
            'phoneNumber': newData['phoneNumber'],
            'email': newData['email'],
            'dateOfBirth': newData['dateOfBirth'],
            'gender': newData['gender'],
          });

        user.assignAll(updatedUser);
        await prefs.setString('user', jsonEncode(updatedUser));

        Get.snackbar(
          'Sukses',
          'Profil berhasil diperbarui',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        return true;
      } else {
        throw Exception(responseBody['message'] ?? 'Gagal memperbarui profil');
      }
    } on FormatException {
      throw Exception('Format respons server tidak valid');
    } catch (e) {
      throw Exception('Gagal memperbarui profil: ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }

  Future<void> logout() async {
    try {
      isLoading(true);
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      await prefs.remove('user');
      Get.offAll(() => LogInScreen());
    } finally {
      isLoading(false);
    }
  }
}
