import "package:flutter_kawan_tani/models/workshop_model.dart";
import 'package:flutter_kawan_tani/services/workshops/workshop_service.dart';
import "package:get/get.dart";

class RegisterWorkshopController extends GetxController {
  final WorkshopService workshopService = WorkshopService();
  var isLoading = false.obs;
  final firstName = "".obs;
  final lastName = "".obs;
  final emailAddress = "".obs;
  final phoneNumber = "".obs;
  final gender = 0.obs;
  final paymentMethod = (-1).obs;

  Future<void> registerForWorkshop({
    required String workshopId,
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required int gender,
    required int paymentMethod,
  }) async {
    try {
      isLoading(true);
      final request = RegisterWorkshopRequest(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phoneNumber: phoneNumber,
        gender: gender,
        paymentMethod: paymentMethod,
      );

      await workshopService.registerWorkshop(workshopId, request);
      Get.back();
      Get.snackbar('Success', 'Registered for workshop successfully');
    } catch (e) {
      // errorMessage(e.toString());
      Get.snackbar('Error', 'Failed to register for workshop');
    } finally {
      isLoading(false);
    }
  }

  void resetForm() {
    firstName.value = '';
    lastName.value = '';
    emailAddress.value = '';
    phoneNumber.value = '';
    gender.value = 0;
    paymentMethod.value = 0;
  }

  String get paymentMethodText {
    switch (paymentMethod.value) {
      case 0:
        return 'Gopay';
      case 1:
        return 'Dana';
      case 2:
        return 'Ovo';
      case 3:
        return 'Qris';
      default:
        return 'Metode tidak dikenal';
    }
  }
}
