import 'package:flutter_kawan_tani/models/workshop_model.dart';
import 'package:flutter_kawan_tani/services/workshops/workshop_service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class WorkshopController extends GetxController {
  final WorkshopService workshopService = WorkshopService();

  var isLoading = false.obs;
  var workshops = <Workshop>[].obs;
  var activeWorkshops = <Workshop>[].obs;
  var ownWorkshops = <Workshop>[].obs;
  var participants = <WorkshopRegistration>[].obs;
  var selectedWorkshop = Workshop(
          idWorkshop: '',
          judulWorkshop: '',
          tanggalWorkshop: '',
          alamatLengkapWorkshop: '',
          waktuMulai: '',
          waktuBerakhir: '',
          statusVerifikasi: '',
          statusAktif: false,
          gambarWorkshop: '')
      .obs;

  // Error handling
  var errorMessage = ''.obs;

  @override
  void onInit() {
    fetchAllWorkshops();
    fetchActiveWorkshops();
    super.onInit();
  }

  Future<void> fetchAllWorkshops() async {
    try {
      isLoading(true);
      final result = await workshopService.getAllWorkshops();
      workshops.assignAll(result);
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchActiveWorkshops() async {
    try {
      isLoading(true);
      final result = await workshopService.getActiveWorkshops();
      activeWorkshops.assignAll(result);
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchRegisteredWorkshop() async {
    try {
      isLoading(true);
      final List<WorkshopRegistration> registrations =
          await workshopService.getRegisteredWorkshops();
      List<Workshop> fetchedWorkshops = []; //

      for (var reg in registrations) {
        //
        try {
          final workshopDetail =
              await workshopService.getWorkshopById(reg.idWorkshop);
          fetchedWorkshops.add(workshopDetail); //
        } catch (e) {
          print('Error fetching workshop detail for ${reg.idWorkshop}: $e');
        }
      }
      activeWorkshops.assignAll(fetchedWorkshops); //
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchWorkshopById(String id) async {
    try {
      isLoading(true);
      final result = await workshopService.getWorkshopById(id);
      selectedWorkshop(result);
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> createWorkshop({
    required String title,
    required String date,
    required String address,
    required String description,
    required String price,
    required String capacity,
    required String lat,
    required String long,
    required String regency,
    required XFile image,
  }) async {
    try {
      isLoading(true);

      final request = CreateWorkshopRequest(
        title: title,
        date: date,
        address: address,
        description: description,
        price: price,
        capacity: capacity,
        lat: lat,
        long: long,
        regency: regency,
        image: image.path,
      );

      await workshopService.createWorkshop(request);
      await fetchAllWorkshops();
      Get.back();
      Get.snackbar('Success', 'Workshop created successfully');
    } catch (e) {
      errorMessage(e.toString());
      Get.snackbar('Error', 'Failed to create workshop');
    } finally {
      isLoading(false);
    }
  }

  Future<void> verifyWorkshop(String id) async {
    try {
      isLoading(true);
      await workshopService.verifyWorkshop(id);
      await fetchAllWorkshops();
      Get.snackbar('Success', 'Workshop verified successfully');
    } catch (e) {
      errorMessage(e.toString());
      Get.snackbar('Error', 'Failed to verify workshop');
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteWorkshop(String id) async {
    try {
      isLoading(true);
      await workshopService.deleteWorkshop(id);
      await fetchAllWorkshops();
      Get.snackbar('Success', 'Workshop deleted successfully');
    } catch (e) {
      errorMessage(e.toString());
      Get.snackbar('Error', 'Failed to delete workshop');
    } finally {
      isLoading(false);
    }
  }

  // Future<void> registerForWorkshop({
  //   required String workshopId,
  //   required String firstName,
  //   required String lastName,
  //   required String email,
  //   required String phoneNumber,
  //   required int gender,
  //   required int paymentMethod,
  // }) async {
  //   try {
  //     isLoading(true);
  //     final request = RegisterWorkshopRequest(
  //       firstName: firstName,
  //       lastName: lastName,
  //       email: email,
  //       phoneNumber: phoneNumber,
  //       gender: gender,
  //       paymentMethod: paymentMethod,
  //     );

  //     await workshopService.registerWorkshop(workshopId, request);
  //     Get.back();
  //     Get.snackbar('Success', 'Registered for workshop successfully');
  //   } catch (e) {
  //     errorMessage(e.toString());
  //     Get.snackbar('Error', 'Failed to register for workshop');
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  // Future<void> payForRegistration(String ticketNumber) async {
  //   try {
  //     isLoading(true);
  //     await workshopService.payRegistration(ticketNumber);
  //     await fetchWorkshopParticipants();
  //     Get.snackbar('Success', 'Payment processed successfully');
  //   } catch (e) {
  //     errorMessage(e.toString());
  //     Get.snackbar('Error', 'Failed to process payment');
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  Future<void> fetchWorkshopParticipants() async {
    try {
      isLoading(true);
      final result = await workshopService.getWorkshopParticipants();
      participants.assignAll(result);
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchOwnWorkshops() async {
    try {
      isLoading(true);
      final result = await workshopService.getOwnWorkshops();
      ownWorkshops.assignAll(result);
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
