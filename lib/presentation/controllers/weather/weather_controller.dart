// presentation/controllers/weather/weather_controller.dart
import 'package:get/get.dart';
import 'package:flutter_kawan_tani/services/weather/weather_service.dart';

class WeatherController extends GetxController {
  final WeatherService _weatherService = WeatherService();

  var temperature = 0.0.obs;
  var humidity = 0.0.obs;
  var location = 'Memuat lokasi...'.obs; // More descriptive initial state
  var weatherDescription = '...'.obs;
  var weatherIconCode = ''
      .obs; // Open-Meteo typically uses numeric codes, not OpenWeatherMap's string icons
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
      // If your WeatherService was extended to parse description/icon from Open-Meteo,
      // you would set them here:
      // weatherDescription.value = weatherData['weatherDescription'] ?? 'Tidak diketahui';
      // weatherIconCode.value = weatherData['weatherIconCode'] ?? '';
    } catch (e) {
      Get.snackbar('Error', 'Gagal memuat data cuaca: ${e.toString()}');
      location.value =
          'Mojokerto, Jawa Timur (Default)'; // Fallback if API fails
      temperature.value = 30.0; // Default temperature
      humidity.value = 70.0; // Default humidity
      weatherDescription.value = 'Gagal memuat';
      weatherIconCode.value = '';
    } finally {
      isLoadingWeather(false);
    }
  }
}
