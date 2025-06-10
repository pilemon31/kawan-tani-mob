import 'package:get/get.dart';
import 'package:flutter_kawan_tani/models/plant_model.dart';
import 'package:flutter_kawan_tani/services/plants/plant_service.dart';

class PlantController extends GetxController {
  final PlantService _plantService = PlantService();

  var plants = <Plant>[].obs;
  var selectedPlant = Plant(
    id: '',
    name: '',
    description: '',
    plantingDuration: 0,
    instructions: [],
    plantingDays: [],
  ).obs;
  var isLoading = false.obs;

  Future<void> fetchPlants() async {
    try {
      isLoading(true);
      var result = await _plantService.getAllPlants();
      plants.assignAll(result);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load plants: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> getPlantById(String id) async {
    try {
      isLoading(true);
      var result = await _plantService.getPlantById(id);
      selectedPlant.value = result;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load plant: $e');
    } finally {
      isLoading(false);
    }
  }
}
