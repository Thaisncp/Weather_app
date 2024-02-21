import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/WeatherData.dart';
import 'package:weather_app/utils/api_endpoints.dart';
import 'package:weather_app/utils/custom_colors.dart';
import 'package:weather_app/widgets/comfort_level.dart';
import 'package:weather_app/widgets/current_weather_widget.dart';
import 'package:weather_app/widgets/header_widget.dart';
import 'package:weather_app/widgets/hourly_data_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late WeatherEntry _lastWeatherData = WeatherEntry();

  @override
  void initState() {
    super.initState();
    _fetchData(); // Llama a la función fetchData al iniciar la vista
  }

  Future<void> _fetchData() async {
    try {
      final respuesta = await http.get(
        Uri.parse('${ApiEndPoints.baseUrlApi}/weatherdatas?limit=1'),
        headers: {'Content-type': "application/json"},
      );

      if (respuesta.statusCode == 200) {
        final Map<String, dynamic> weatherDatas = json.decode(respuesta.body);
        // final List<dynamic> weatherDatas = json.decode(respuesta.body);

        if (weatherDatas.isNotEmpty) {
          final Map<String, dynamic> last = weatherDatas['results'][0];

          final WeatherEntry lastEntry = WeatherEntry.fromJson(last);

          setState(() {
            _lastWeatherData = lastEntry;
          });
        } else {
          print("No se encontraron datos meteorológicos");
        }
      } else {
        print(
            "No se recibió una respuesta exitosa al obtener los últimos datos meteorológicos");
      }
    } catch (error) {
      print('Error en fetchData: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              const SizedBox(
                height: 20,
              ),
              const HeaderWidget(),
              CurrentWeatherWidget(
                lastBarometricPressure:
                    '${_lastWeatherData.barometricPressure.toStringAsFixed(0)}Pa',
                lastTemperature:
                    '${_lastWeatherData.temperature.toStringAsFixed(0)}°C',
                lastHumidity:
                    '${_lastWeatherData.humidity.toStringAsFixed(0)}%',
              ),
              const SizedBox(
                height: 20,
              ),
              HourlyDataWidget(),
              Container(
                height: 1,
                color: CustomColors.dividerLine,
              ),
              const SizedBox(
                height: 10,
              ),
              ComfortLevel(
                  lastHumidity:
                      "${_lastWeatherData.humidity.toStringAsFixed(0)}%")
            ],
          ),
        ),
      ),
    );
  }
}
