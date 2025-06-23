import 'package:get/get.dart';
import 'package:flutter_kawan_tani/services/weather/weather_service.dart';

class WeatherController extends GetxController {
  final WeatherService _weatherService = WeatherService();

  var temperature = 0.0.obs;
  var humidity = 0.0.obs;
  var location = 'Memuat lokasi...'.obs;
  var weatherDescription = '...'.obs;
  var weatherIconCode = ''
      .obs;
  var isLoadingWeather = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    try {
      isLoadingWeather(true);
      final weatherData = await _weatherService.fetchCurrentWeather();

      temperature.value = weatherData['temperature'];
      humidity.value = weatherData['humidity'];
      location.value = weatherData['location'];
    } catch (e) {
      Get.snackbar('Error', 'Gagal memuat data cuaca: ${e.toString()}');
      location.value =
          'Mojokerto, Jawa Timur (Default)';
      temperature.value = 30.0;
      humidity.value = 70.0;
      weatherDescription.value = 'Gagal memuat';
      weatherIconCode.value = '';
    } finally {
      isLoadingWeather(false);
    }
  }
}
