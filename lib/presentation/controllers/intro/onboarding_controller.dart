import "package:get/get.dart";

class OnboardingController extends GetxController {
  var currentIndex = 0.obs;

  void nextIndex() => currentIndex++;

  void prevIndex() => currentIndex--;
}
