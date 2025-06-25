import 'package:flutter_kawan_tani/models/plant_model.dart';
import 'package:get/get.dart';
import 'package:flutter_kawan_tani/models/user_plant_model.dart';
import 'package:flutter_kawan_tani/services/plants/user_plant_service.dart';

class UserPlantController extends GetxController {
  final UserPlantService _userPlantService = UserPlantService();

  var userPlants = <UserPlant>[].obs;
  var selectedUserPlant = Rx<UserPlant>(UserPlant(
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
  ));
  var dailyTasks = <UserPlantingDay>[].obs;
  var todayTasks = <UserPlantingDay>[].obs;
  var isLoading = false.obs;
  var isCreating = false.obs;
  var isUpdating = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTodayTasks();
  }

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
      final now = DateTime.now();
      final filteredPlantingDays = result.plantingDays.where((day) {
        return day.actualDate.isBefore(now.add(const Duration(days: 1)));
      }).toList();

      selectedUserPlant.value = UserPlant(
        id: result.id,
        customName: result.customName,
        plantingDate: result.plantingDate,
        targetHarvestDate: result.targetHarvestDate,
        progress: result.progress,
        status: result.status,
        plant: result.plant,
        plantingDays: filteredPlantingDays,
      );
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
    } catch (e) {
    } finally {
      isCreating(false);
    }
  }

  Future<void> fetchDailyTasksAndUpdate(String userPlantId) async {
    try {
      isLoading(true);

      var result = await _userPlantService.getDailyTasks(
        userPlantId: userPlantId,
      );

      final now = DateTime.now();
      final filteredDailyTasks = result.where((day) {
        return day.actualDate.isBefore(now.add(const Duration(days: 1)));
      }).toList();

      selectedUserPlant.update((plant) {
        if (plant != null) {
          plant.plantingDays.clear();
          plant.plantingDays
              .addAll(filteredDailyTasks);
        }
      });
      dailyTasks.assignAll(
          filteredDailyTasks);
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
      await getUserPlantDetail(
          userPlantId);

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
      await _userPlantService.finishPlant(userPlantId);

      userPlants.removeWhere((plant) => plant.id == userPlantId);
      userPlants.refresh();

      if (selectedUserPlant.value.id == userPlantId) {
        selectedUserPlant.value = UserPlant(
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
              plantingDays: []),
          plantingDays: [],
        );
      }

      Get.snackbar('Success', 'Plant finished successfully and removed.');
    } catch (e) {
      Get.snackbar('Error', 'Failed to finish plant: $e');
    } finally {
      isLoading(false);
    }
  }
}
