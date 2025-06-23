// services/weather/weather_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class WeatherService {
  final String _bigDataCloudBaseUrl =
      'https://api.bigdatacloud.net/data/reverse-geocode-client';
  final String _openMeteoBaseUrl = 'https://api.open-meteo.com/v1/forecast';

  Future<Map<String, dynamic>> fetchCurrentWeather() async {
    double latitude;
    double longitude;
    String locationName;

    try {
      Position position = await _determinePosition();
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print('Geolocation error: $e');
      latitude = -7.2575;
      longitude = 112.7521;
    }

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
        locationName = 'Unknown Location';
      }
    } catch (e) {
      print('Error fetching location: $e');
      locationName = 'Unknown Location';
    }

    if (locationName == 'Unknown Location') {
      latitude = -7.2575;
      longitude = 112.7521;
      locationName = 'Surabaya, Jawa Timur';
    }

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
                : 0.0;

        return {
          'temperature': temperature,
          'humidity': humidity,
          'location': locationName,
        };
      } else {
        throw Exception(
            'Failed to load Open-Meteo weather data: ${weatherResponse.statusCode} - ${weatherResponse.body}');
      }
    } catch (e) {
      throw Exception('Error fetching Open-Meteo weather: $e');
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy:
          LocationAccuracy.low,
    );
  }
}
