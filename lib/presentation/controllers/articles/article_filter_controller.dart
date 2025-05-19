import "package:get/get.dart";

class ArticleFilterController extends GetxController {
  var teknikPertanian = false.obs;
  var pengendalianHama = false.obs;
  var peningkatanKualitas = false.obs;
  var teknologiPertanian = false.obs;
  var manajemenBisnis = false.obs;

  var rating = 0.obs;

  void getFilter() {
  }

  void changeRating(newRating) {
    rating.value = newRating;
  }
}
