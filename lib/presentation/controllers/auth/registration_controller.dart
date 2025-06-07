import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_kawan_tani/services/auth/auth_service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class RegistrationController extends GetxController {
  var firstName = ''.obs;
  var lastName = ''.obs;
  var email = ''.obs;
  var phoneNumber = ''.obs;
  var dateOfBirth = ''.obs;
  var gender = 0.obs;
  var password = ''.obs;
  var confirmPassword = ''.obs;
  var avatar = Rx<File?>(null);
  var webAvatar = Rx<Uint8List?>(null);
  var avatarFileName = ''.obs;
  var token = ''.obs;
  var isLoading = false.obs;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    try {
      print('Starting image picker...');

      final pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 75,
        maxWidth: 1024,
        maxHeight: 1024,
        preferredCameraDevice: CameraDevice.rear,
      );

      if (pickedFile != null) {
        print('Image picked successfully!');
        print('File path: ${pickedFile.path}');
        print('File name: ${pickedFile.name}');

        // Dapatkan extension dari nama file
        String originalExtension = '';
        if (pickedFile.name.contains('.')) {
          originalExtension = pickedFile.name.split('.').last.toLowerCase();
        }

        print('Original extension: $originalExtension');

        // Validasi extension
        final validExtensions = ['jpg', 'jpeg', 'png'];
        if (originalExtension.isEmpty ||
            !validExtensions.contains(originalExtension)) {
          // Jika extension tidak valid, gunakan jpg sebagai default
          originalExtension = 'jpg';
          print('Invalid or missing extension, using default: jpg');
        }

        if (!kIsWeb) {
          final file = File(pickedFile.path);
          final fileSize = await file.length();
          print(
              'File size: ${fileSize} bytes (${(fileSize / 1024 / 1024).toStringAsFixed(2)} MB)');

          if (fileSize > 5 * 1024 * 1024) {
            Get.snackbar(
              'Error',
              'Ukuran file terlalu besar. Maksimal 5MB.',
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
            return;
          }

          // Verifikasi MIME type untuk mobile
          final mimeType = lookupMimeType(file.path);
          print('Mobile MIME type: $mimeType');

          if (mimeType == null || !mimeType.startsWith('image/')) {
            Get.snackbar(
              'Error',
              'File yang dipilih bukan gambar yang valid.',
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
            return;
          }

          avatar.value = file;
          webAvatar.value = null;
          avatarFileName.value =
              'avatar_${DateTime.now().millisecondsSinceEpoch}.$originalExtension';
          print(
              'Mobile avatar set successfully with filename: ${avatarFileName.value}');
        } else {
          // Web platform
          print('Processing for web...');
          final bytes = await pickedFile.readAsBytes();
          print('Web image bytes length: ${bytes.length}');

          // Cek ukuran file untuk web
          if (bytes.length > 5 * 1024 * 1024) {
            Get.snackbar(
              'Error',
              'Ukuran file terlalu besar. Maksimal 5MB.',
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
            return;
          }

          // Verifikasi signature file untuk web
          if (!_isValidImageBytes(bytes)) {
            Get.snackbar(
              'Error',
              'File yang dipilih bukan gambar yang valid.',
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
            return;
          }

          webAvatar.value = bytes;
          avatar.value = null;
          avatarFileName.value =
              'avatar_${DateTime.now().millisecondsSinceEpoch}.$originalExtension';
          print(
              'Web avatar set successfully with filename: ${avatarFileName.value}');
        }

        print('Image selection completed successfully!');
        update();
      } else {
        print('No image selected');
      }
    } catch (e) {
      print('Error picking image: $e');
      Get.snackbar(
        'Error',
        'Gagal memilih gambar: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Helper method untuk validasi signature file gambar
  bool _isValidImageBytes(Uint8List bytes) {
    if (bytes.length < 4) return false;

    // Check for common image signatures
    // JPEG: FF D8 FF
    if (bytes[0] == 0xFF && bytes[1] == 0xD8 && bytes[2] == 0xFF) {
      return true;
    }

    // PNG: 89 50 4E 47
    if (bytes.length >= 8 &&
        bytes[0] == 0x89 &&
        bytes[1] == 0x50 &&
        bytes[2] == 0x4E &&
        bytes[3] == 0x47) {
      return true;
    }

    return false;
  }

  Future<bool> registerAccount() async {
    isLoading.value = true;

    try {
      // Validasi input
      if (firstName.value.isEmpty ||
          lastName.value.isEmpty ||
          email.value.isEmpty ||
          password.value.isEmpty) {
        throw Exception('Semua field wajib diisi');
      }

      print('Input validation passed');
      print('Has selected avatar: $hasSelectedAvatar');

      final uri = Uri.parse('${AuthService.baseUrl}/auth/register');
      print('Registration endpoint: $uri');

      final request = http.MultipartRequest('POST', uri);

      // Headers
      request.headers.addAll({
        'Accept': 'application/json',
        'Content-Type': 'multipart/form-data',
      });

      // Fields
      request.fields['firstName'] = firstName.value;
      request.fields['lastName'] = lastName.value;
      request.fields['email'] = email.value;
      request.fields['phoneNumber'] = phoneNumber.value;
      request.fields['dateOfBirth'] = dateOfBirth.value;
      request.fields['gender'] = gender.value.toString();
      request.fields['password'] = password.value;
      request.fields['confirmPassword'] = confirmPassword.value;

      print('Form fields added: ${request.fields.keys.toList()}');

      // Handle avatar dengan content type yang tepat
      if (hasSelectedAvatar) {
        print('Adding avatar to request...');

        if (kIsWeb && webAvatar.value != null) {
          print('Web avatar size: ${webAvatar.value!.length} bytes');
          print('Web avatar filename: ${avatarFileName.value}');

          // Tentukan content type berdasarkan extension
          String contentType = 'image/jpeg'; // default
          if (avatarFileName.value.toLowerCase().endsWith('.png')) {
            contentType = 'image/png';
          } else if (avatarFileName.value.toLowerCase().endsWith('.jpg') ||
              avatarFileName.value.toLowerCase().endsWith('.jpeg')) {
            contentType = 'image/jpeg';
          }

          final multipartFile = http.MultipartFile.fromBytes(
            'avatar',
            webAvatar.value!,
            filename: avatarFileName.value,
            contentType: MediaType.parse(contentType),
          );

          request.files.add(multipartFile);
          print('Web avatar added to request with content type: $contentType');
        } else if (avatar.value != null) {
          final file = avatar.value!;
          final fileSize = await file.length();
          print('Mobile avatar size: $fileSize bytes');
          print('Mobile avatar path: ${file.path}');
          print('Mobile avatar filename: ${avatarFileName.value}');

          // Tentukan content type
          String contentType = lookupMimeType(file.path) ?? 'image/jpeg';
          print('Mobile content type: $contentType');

          final multipartFile = await http.MultipartFile.fromPath(
            'avatar',
            file.path,
            filename: avatarFileName.value,
            contentType: MediaType.parse(contentType),
          );

          request.files.add(multipartFile);
          print(
              'Mobile avatar added to request with content type: $contentType');
        }
      } else {
        print('No avatar selected, skipping file upload');
      }

      print('Total files in request: ${request.files.length}');
      print('Sending registration request...');

      final response = await request.send();
      final responseString = await response.stream.bytesToString();

      print('=== REGISTRATION RESPONSE ===');
      print('Status Code: ${response.statusCode}');
      print('Response Headers: ${response.headers}');
      print(
          'Response Body (first 500 chars): ${responseString.length > 500 ? responseString.substring(0, 500) + "..." : responseString}');

      // Check for HTML error response
      if (responseString.trim().startsWith('<!DOCTYPE') ||
          responseString.trim().startsWith('<html')) {
        print('Received HTML error response');

        String errorMsg = 'Server error';
        if (responseString.contains('Format file tidak didukung')) {
          errorMsg =
              'Format file tidak didukung! Pastikan file adalah JPG, JPEG, atau PNG.';
        } else if (responseString.contains('Error: ')) {
          final errorStart = responseString.indexOf('Error: ') + 7;
          final errorEnd = responseString.indexOf('<br>', errorStart);
          if (errorEnd > errorStart) {
            errorMsg = responseString.substring(errorStart, errorEnd);
          }
        }

        print('Extracted error: $errorMsg');
        throw Exception(errorMsg);
      }

      // Parse JSON response
      Map<String, dynamic> responseData;
      try {
        responseData = json.decode(responseString);
        print('JSON parsed successfully');
      } catch (jsonError) {
        print('JSON parse error: $jsonError');
        throw Exception('Server response is not valid JSON');
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (responseData['success'] == true && responseData['data'] != null) {
          token.value = responseData['data']['token'] ?? '';
          print('Registration successful!');
          return true;
        } else {
          throw Exception(responseData['message'] ??
              'Registration failed - invalid response');
        }
      } else {
        throw Exception(responseData['message'] ?? 'Registration failed');
      }
    } catch (e) {
      print('Registration error: $e');
      rethrow;
    } finally {
      isLoading.value = false;
      print('=== REGISTRATION COMPLETED ===');
    }
  }

  bool get hasSelectedAvatar {
    final result = (kIsWeb && webAvatar.value != null) ||
        (!kIsWeb && avatar.value != null);
    print(
        'hasSelectedAvatar: $result (web: ${kIsWeb}, webAvatar: ${webAvatar.value != null}, avatar: ${avatar.value != null})');
    return result;
  }

  void clearAvatar() {
    print('Clearing avatar...');
    avatar.value = null;
    webAvatar.value = null;
    avatarFileName.value = '';
    print('Avatar cleared');
  }

  void printDebugInfo() {
    print('=== DEBUG INFO ===');
    print('Platform: ${kIsWeb ? "Web" : "Mobile"}');
    print('Has selected avatar: $hasSelectedAvatar');
    print('Avatar filename: ${avatarFileName.value}');
    print('Web avatar null: ${webAvatar.value == null}');
    print('Mobile avatar null: ${avatar.value == null}');
    if (!kIsWeb && avatar.value != null) {
      print('Mobile avatar path: ${avatar.value!.path}');
    }
    if (kIsWeb && webAvatar.value != null) {
      print('Web avatar size: ${webAvatar.value!.length} bytes');
    }
    print('==================');
  }
}
