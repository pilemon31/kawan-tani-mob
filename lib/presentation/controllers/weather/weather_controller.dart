import 'package:get/get.dart';

class WeatherController extends GetxController {
  var temperature = "30°C".obs;
  var humidity = "60%".obs;
  var windSpeed = "12 km/h".obs;

  void updateWeather({required String temp, required String hum, required String wind}) {
    temperature.value = temp;
    humidity.value = hum;
    windSpeed.value = wind;
  }
}
