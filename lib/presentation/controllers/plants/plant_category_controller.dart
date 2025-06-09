import 'package:get/get.dart';
import 'package:flutter_kawan_tani/models/plant_category_model.dart';
import 'package:flutter_kawan_tani/services/plants/plant_category_service.dart';

class PlantCategoryController extends GetxController {
  final PlantCategoryService _plantCategoryService = PlantCategoryService();

  var categories = <PlantCategory>[].obs;
  var selectedCategory = PlantCategory(id: 0, name: '').obs;
  var isLoading = false.obs;

  Future<void> fetchCategories() async {
    try {
      isLoading(true);
      var result = await _plantCategoryService.getAllCategories();
      categories.assignAll(result);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load plant categories: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> getCategoryById(int id) async {
    try {
      isLoading(true);
      var result = await _plantCategoryService.getCategoryById(id);
      selectedCategory.value = result;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load plant category: $e');
    } finally {
      isLoading(false);
    }
  }
}