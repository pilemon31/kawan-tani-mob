// services/weather/weather_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart'; // Import geolocator

class WeatherService {
  final String _bigDataCloudBaseUrl =
      'https://api.bigdatacloud.net/data/reverse-geocode-client';
  final String _openMeteoBaseUrl = 'https://api.open-meteo.com/v1/forecast';

  // No API key needed for Open-Meteo basic usage or BigDataCloud reverse geocoding (for reasonable limits)

  Future<Map<String, dynamic>> fetchCurrentWeather() async {
    double latitude;
    double longitude;
    String locationName;

    // 1. Get current position
    try {
      Position position = await _determinePosition();
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print('Geolocation error: $e');
      // Fallback to default location (Surabaya) if geolocation fails or is denied
      latitude = -7.2575; // Latitude for Surabaya
      longitude = 112.7521; // Longitude for Surabaya
    }

    // 2. Get location name (reverse geocoding)
    try {
      final locationUrl = Uri.parse(
          '$_bigDataCloudBaseUrl?latitude=$latitude&longitude=$longitude&localityLanguage=id');
      final locationResponse = await http.get(locationUrl);

      if (locationResponse.statusCode == 200) {
        final Map<String, dynamic> locationData =
            jsonDecode(locationResponse.body);
        final city = locationData['city'];
        final principalSubdivision = locationData['principalSubdivision'];
        final countryName = locationData['countryName'];

        if (city != null && city.isNotEmpty) {
          locationName = '$city, ${principalSubdivision ?? countryName}';
        } else {
          locationName =
              '${locationData['locality'] ?? 'Unknown'}, ${countryName ?? 'Indonesia'}';
        }
      } else {
        print(
            'Failed to load location data: ${locationResponse.statusCode} - ${locationResponse.body}');
        locationName = 'Unknown Location'; // Fallback
      }
    } catch (e) {
      print('Error fetching location: $e');
      locationName = 'Unknown Location'; // Fallback
    }

    // If still Unknown Location after trying geolocation, default to Surabaya
    if (locationName == 'Unknown Location') {
      latitude = -7.2575; // Latitude for Surabaya
      longitude = 112.7521; // Longitude for Surabaya
      locationName = 'Surabaya, Jawa Timur';
    }

    // 3. Get weather data from Open-Meteo
    try {
      final weatherUrl = Uri.parse(
          '$_openMeteoBaseUrl?latitude=$latitude&longitude=$longitude&current_weather=true&hourly=relativehumidity_2m&timezone=auto&forecast_days=1');
      final weatherResponse = await http.get(weatherUrl);

      if (weatherResponse.statusCode == 200) {
        final Map<String, dynamic> weatherData =
            jsonDecode(weatherResponse.body);

        final double temperature =
            weatherData['current_weather']['temperature']?.toDouble() ?? 0.0;
        final List<dynamic>? hourlyHumidity =
            weatherData['hourly']['relativehumidity_2m'];
        final int currentHour = DateTime.now().hour;
        final double humidity =
            hourlyHumidity != null && hourlyHumidity.length > currentHour
                ? hourlyHumidity[currentHour]?.toDouble() ?? 0.0
                : 0.0; // Default if not found

        // Open-Meteo's weather codes are numbers, you'd map them to descriptions/icons
        // For simplicity, we'll just return temperature and humidity for now.
        // You'd need a mapping for weather_code to description if you want text like "Cerah"
        // and a way to get an icon from a weather code if you want weather images.

        return {
          'temperature': temperature,
          'humidity': humidity,
          'location': locationName,
          // Add more fields if Open-Meteo provides them and you map them:
          // 'weatherDescription': 'Cerah', // You'd need to map weatherData['current_weather']['weather_code']
          // 'weatherIconUrl': '...',
        };
      } else {
        throw Exception(
            'Failed to load Open-Meteo weather data: ${weatherResponse.statusCode} - ${weatherResponse.body}');
      }
    } catch (e) {
      throw Exception('Error fetching Open-Meteo weather: $e');
    }
  }

  /// Determine the current position of the device.
  /// When the location services are not enabled or permissions
  /// are denied, then it handles the errors.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now).
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
      desiredAccuracy:
          LocationAccuracy.low, // Lower accuracy for less battery drain
    );
  }
}
