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

        String originalExtension = '';
        if (pickedFile.name.contains('.')) {
          originalExtension = pickedFile.name.split('.').last.toLowerCase();
        }

        final validExtensions = ['jpg', 'jpeg', 'png'];
        if (originalExtension.isEmpty ||
            !validExtensions.contains(originalExtension)) {
          originalExtension = 'jpg';
        }

        if (!kIsWeb) {
          final file = File(pickedFile.path);
          final fileSize = await file.length();

          if (fileSize > 5 * 1024 * 1024) {
            Get.snackbar(
              'Error',
              'Ukuran file terlalu besar. Maksimal 5MB.',
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
            return;
          }

          final mimeType = lookupMimeType(file.path);

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

        } else {
          final bytes = await pickedFile.readAsBytes();

          if (bytes.length > 5 * 1024 * 1024) {
            Get.snackbar(
              'Error',
              'Ukuran file terlalu besar. Maksimal 5MB.',
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
            return;
          }

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
        }
        update();
      } else {
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal memilih gambar: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  bool _isValidImageBytes(Uint8List bytes) {
    if (bytes.length < 4) return false;

    if (bytes[0] == 0xFF && bytes[1] == 0xD8 && bytes[2] == 0xFF) {
      return true;
    }

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
      if (firstName.value.isEmpty ||
          lastName.value.isEmpty ||
          email.value.isEmpty ||
          password.value.isEmpty) {
        throw Exception('Semua field wajib diisi');
      }


      final uri = Uri.parse('${AuthService.baseUrl}/auth/register');

      final request = http.MultipartRequest('POST', uri);

      request.headers.addAll({
        'Accept': 'application/json',
        'Content-Type': 'multipart/form-data',
      });

      request.fields['firstName'] = firstName.value;
      request.fields['lastName'] = lastName.value;
      request.fields['email'] = email.value;
      request.fields['phoneNumber'] = phoneNumber.value;
      request.fields['dateOfBirth'] = dateOfBirth.value;
      request.fields['gender'] = gender.value.toString();
      request.fields['password'] = password.value;
      request.fields['confirmPassword'] = confirmPassword.value;

      if (hasSelectedAvatar) {

        if (kIsWeb && webAvatar.value != null) {
          String contentType = 'image/jpeg';
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
        } else if (avatar.value != null) {
          final file = avatar.value!;

          String contentType = lookupMimeType(file.path) ?? 'image/jpeg';

          final multipartFile = await http.MultipartFile.fromPath(
            'avatar',
            file.path,
            filename: avatarFileName.value,
            contentType: MediaType.parse(contentType),
          );

          request.files.add(multipartFile);
        }
      } else {
      }

      final response = await request.send();
      final responseString = await response.stream.bytesToString();

      if (responseString.trim().startsWith('<!DOCTYPE') ||
          responseString.trim().startsWith('<html')) {

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

        throw Exception(errorMsg);
      }

      Map<String, dynamic> responseData;
      try {
        responseData = json.decode(responseString);
      } catch (jsonError) {
        throw Exception('Server response is not valid JSON');
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (responseData['success'] == true && responseData['data'] != null) {
          token.value = responseData['data']['token'] ?? '';
          return true;
        } else {
          throw Exception(responseData['message'] ??
              'Registration failed - invalid response');
        }
      } else {
        throw Exception(responseData['message'] ?? 'Registration failed');
      }
    } catch (e) {
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  bool get hasSelectedAvatar {
    final result = (kIsWeb && webAvatar.value != null) ||
        (!kIsWeb && avatar.value != null);
    return result;
  }

  void clearAvatar() {
    avatar.value = null;
    webAvatar.value = null;
    avatarFileName.value = '';
  }
}
