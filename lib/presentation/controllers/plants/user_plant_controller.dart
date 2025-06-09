import 'package:flutter_kawan_tani/models/plant_model.dart';
import 'package:get/get.dart';
import 'package:flutter_kawan_tani/models/user_plant_model.dart';
import 'package:flutter_kawan_tani/services/plants/user_plant_service.dart';

class UserPlantController extends GetxController {
  final UserPlantService _userPlantService = UserPlantService();

  var userPlants = <UserPlant>[].obs;
  var selectedUserPlant = UserPlant(
    id: '',
    customName: '',
    plantingDate: DateTime.now(),
    targetHarvestDate: DateTime.now(),
    progress: 0,
    status: '',
    plant: Plant(
      id: '',
      name: '',
      description: '',
      plantingDuration: 0,
      instructions: [],
      plantingDays: [],
    ),
    plantingDays: [],
  ).obs;
  var dailyTasks = <UserPlantingDay>[].obs;
  var todayTasks = <UserPlantingDay>[].obs;
  var isLoading = false.obs;
  var isCreating = false.obs;
  var isUpdating = false.obs;

  Future<void> fetchUserPlants() async {
    try {
      isLoading(true);
      var result = await _userPlantService.getUserPlants();
      userPlants.assignAll(result);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load user plants: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> getUserPlantDetail(String userPlantId) async {
    try {
      isLoading(true);
      var result = await _userPlantService.getUserPlantDetail(userPlantId);
      selectedUserPlant.value = result;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load user plant detail: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> createUserPlant({
    required String plantId,
    required String customName,
  }) async {
    try {
      isCreating(true);
      var result = await _userPlantService.createUserPlant(
        plantId: plantId,
        customName: customName,
      );
      userPlants.insert(0, result);
      Get.snackbar('Success', 'Plant added successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to create user plant: $e');
    } finally {
      isCreating(false);
    }
  }

  Future<void> fetchDailyTasks({
    required String userPlantId,
    String? date,
  }) async {
    try {
      isLoading(true);
      var result = await _userPlantService.getDailyTasks(
        userPlantId: userPlantId,
        date: date,
      );
      dailyTasks.assignAll(result);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load daily tasks: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchTodayTasks() async {
    try {
      isLoading(true);
      var result = await _userPlantService.getTodayTasks();
      todayTasks.assignAll(result);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load today tasks: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateTaskProgress({
    required String userPlantId,
    required String taskId,
    required bool doneStatus,
  }) async {
    try {
      isUpdating(true);
      await _userPlantService.updateTaskProgress(
        userPlantId: userPlantId,
        taskId: taskId,
        doneStatus: doneStatus,
      );
      
      // Update the task in the local state
      for (var day in dailyTasks) {
        for (var task in day.tasks) {
          if (task.id == taskId) {
            task.isCompleted = doneStatus;
            task.completedDate = doneStatus ? DateTime.now() : null;
            break;
          }
        }
      }
      
      Get.snackbar('Success', 'Task updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update task: $e');
    } finally {
      isUpdating(false);
    }
  }

  Future<void> finishPlant(String userPlantId) async {
    try {
      isLoading(true);
      var result = await _userPlantService.finishPlant(userPlantId);
      
      // Update the plant in the local state
      final index = userPlants.indexWhere((plant) => plant.id == userPlantId);
      if (index != -1) {
        userPlants[index] = result;
      }
      
      Get.snackbar('Success', 'Plant finished successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to finish plant: $e');
    } finally {
      isLoading(false);
    }
  }
}