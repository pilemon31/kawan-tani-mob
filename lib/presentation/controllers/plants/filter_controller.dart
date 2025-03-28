import 'package:get/get.dart';

class FilterController extends GetxController {
  var tanamanPangan = false.obs;
  var tanamanPerkebunan = false.obs;
  var tanamanHortikultura = false.obs;

  bool isValid() {
    return tanamanPangan.value || tanamanPerkebunan.value || tanamanHortikultura.value;
  }
}
