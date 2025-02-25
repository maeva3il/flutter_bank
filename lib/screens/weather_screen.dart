import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/location_service.dart';
import 'package:flutter_application_1/services/weather_service.dart';
import 'package:geolocator/geolocator.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final LocationService _locationService = LocationService();
  final WeatherService _weatherService = WeatherService();

  Future<Map<String, dynamic>> fetchWeatherData() async {
    try {
      Position position = await _locationService.getCurrentLocation();
      String city = await _locationService.getCityFromCoordinates(position);
      Map<String, dynamic> weatherData = await _weatherService.fetchWeatherData(city);
      
      double temperature = weatherData['main']['temp'] - 273.15;
      
      return {
        'city': city,
        'temperature': temperature.toStringAsFixed(2),
      };
    } catch (e) {
      return {'city': 'Error', 'temperature': 'N/A'};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather App')),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchWeatherData(),
        builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          var data = snapshot.data ?? {'city': '...', 'temperature': '...'};

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('City: ${data['city']}', style: TextStyle(fontSize: 24)),
                Text('Temperature: ${data['temperature']}°C', style: TextStyle(fontSize: 24)),
              ],
            ),
          );
        },
      ),
    );
  }
}
