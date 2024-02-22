import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/utils/api_endpoints.dart';

import '../utils/custom_colors.dart';

class CurrentWeatherWidget extends StatefulWidget {
  final String lastBarometricPressure;
  final String lastTemperature;
  final String lastHumidity;

  const CurrentWeatherWidget({
    Key? key,
    required this.lastBarometricPressure,
    required this.lastTemperature,
    required this.lastHumidity,
  }) : super(key: key);

  @override
  _CurrentWeatherWidgetState createState() => _CurrentWeatherWidgetState();
}

class _CurrentWeatherWidgetState extends State<CurrentWeatherWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Área de temperatura
        tempeatureAreaWidget(),

        const SizedBox(
          height: 20,
        ),
        currentWeatherMoreDetailsWidget(),
      ],
    );
  }

  Widget currentWeatherMoreDetailsWidget() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 60,
              width: 60,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: CustomColors.cardColor,
                  borderRadius: BorderRadius.circular(15)),
              child: Image.network(
                'https://cdn-icons-png.flaticon.com/512/2675/2675979.png',
              ),
            ),
            Container(
              height: 60,
              width: 60,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: CustomColors.cardColor,
                  borderRadius: BorderRadius.circular(15)),
              child: Image.network(
                'https://cdn-icons-png.flaticon.com/128/7074/7074116.png',
              ),
            ),
            Container(
              height: 60,
              width: 60,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: CustomColors.cardColor,
                  borderRadius: BorderRadius.circular(15)),
              child: Image.network(
                'https://cdn-icons-png.flaticon.com/512/4005/4005754.png',
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 20,
              width: 60,
              child: Text(
                widget.lastBarometricPressure, // Última presión atmosférica
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
              width: 60,
              child: Text(
                widget.lastTemperature, // Última temperatura
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
              width: 60,
              child: Text(
                widget.lastHumidity, // Última humedad
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            )
          ],
        )
      ],
    );
  }

  Future<String> fetchWeatherType(
      double temperature, int humidity, double pressure) async {
    final Map<String, dynamic> requestData = {
      "temperature": temperature,
      "humidity": humidity,
      "pressure": pressure,
    };

    final String url = '${ApiEndPoints.baseUrlApi}/weatherconditions/state';
    final Map<String, String> headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);

        if (responseBody['weatherState'] != null) {
          Map<String, dynamic> weatherState = responseBody['weatherState'];
          return weatherState['weatherType'];
        } else {
          print(
              'Error al obtener el estado del clima: weatherState no encontrado');

          return 'Desconocido';
        }
      } else {
        print('Error al obtener el estado del clima: ${response.statusCode}');

        return 'Desconocido';
      }
    } catch (error) {
      print('Error inesperado al obtener el estado del clima: $error');

      return 'Desconocido';
    }
  }

  Widget tempeatureAreaWidget() {
    if (widget.lastTemperature.isEmpty ||
        widget.lastHumidity.isEmpty ||
        widget.lastBarometricPressure.isEmpty) {
      return const CircularProgressIndicator();
    }

    return FutureBuilder<String>(
      future: fetchWeatherType(
        double.parse(widget.lastTemperature.replaceAll('°C', '')),
        int.parse(widget.lastHumidity.replaceAll('%', '')),
        double.parse(widget.lastBarometricPressure.replaceAll('Pa', '')),
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          String weatherType = snapshot.data ?? 'Desconocido';

          // Seleccionar la URL de la imagen según el tipo de clima
          String imageUrl;
          if (weatherType == 'SOLEADO') {
            imageUrl =
                'https://cdn-icons-png.flaticon.com/128/4215/4215517.png';
          } else if (weatherType == 'NUBLADO') {
            imageUrl = 'https://cdn-icons-png.flaticon.com/128/899/899681.png';
          } else if (weatherType == 'LLUVIOSO') {
            imageUrl =
                'https://cdn-icons-png.flaticon.com/128/3217/3217172.png';
          } else {
            imageUrl =
                'https://cdn-icons-png.flaticon.com/128/6408/6408911.png';
          }

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.network(
                imageUrl,
                height: 65,
                width: 65,
              ),
              Container(
                height: 50,
                width: 1,
                color: CustomColors
                    .dividerLine, // Asegúrate de tener CustomColors definido
              ),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: widget.lastTemperature, // Mostrar temperatura
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 50,
                      color: CustomColors
                          .textColorBlack, // Asegúrate de tener CustomColors definido
                    ),
                  ),
                  TextSpan(
                    text: weatherType, // Mostrar el weatherType
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ]),
              )
            ],
          );
        }
      },
    );
  }
}
