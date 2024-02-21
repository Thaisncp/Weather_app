import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:weather_app/controller/global_controller.dart';
import 'package:weather_app/utils/api_endpoints.dart';
import 'package:weather_app/utils/custom_colors.dart';

class Pronosticos {
  late Map<String, dynamic> barometricPressure;
  late Map<String, dynamic> humidity;
  late Map<String, dynamic> temperature;

  Pronosticos({
    required this.barometricPressure,
    required this.humidity,
    required this.temperature,
  });

  Pronosticos.fromJson(Map<String, dynamic> json) {
    barometricPressure = _convertToDoubleMap(json['barometricPressure']);
    humidity = _convertToDoubleMap(json['humidity']);
    temperature = _convertToDoubleMap(json['temperature']);
  }

  Map<String, double> _convertToDoubleMap(Map<String, dynamic> input) {
    return input.map(
        (key, value) => MapEntry(key, value is int ? value.toDouble() : value));
  }
}

class HourlyDataWidget extends StatelessWidget {
  final RxInt cardIndex = GlobalController().getIndex();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          alignment: Alignment.topCenter,
          child: const Text("Hoy", style: TextStyle(fontSize: 18)),
        ),
        FutureBuilder<Pronosticos>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error al cargar los datos');
            } else if (snapshot.hasData) {
              return hourlyList(snapshot.data!);
            } else {
              return Text('No hay datos disponibles');
            }
          },
        ),
      ],
    );
  }

  Widget hourlyList(Pronosticos pronosticos) {
    return Container(
      height: 200,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: pronosticos.temperature.length,
        itemBuilder: (context, index) {
          String timeStamp = pronosticos.temperature.keys.toList()[index];
          double temp = pronosticos.temperature[timeStamp]!;
          double pressure = pronosticos.barometricPressure[timeStamp]!;
          double humidity = pronosticos.humidity[timeStamp]!;

          // Determinar el icono en función de la temperatura
          String iconUrl = getIconUrl(temp);

          return GestureDetector(
            onTap: () {
              cardIndex.value = index;
            },
            child: Container(
              width: 100,
              margin: const EdgeInsets.only(left: 20, right: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0.5, 0),
                    blurRadius: 30,
                    spreadRadius: 1,
                    color: CustomColors.dividerLine.withAlpha(150),
                  )
                ],
                gradient: cardIndex.value == index
                    ? const LinearGradient(colors: [
                        CustomColors.firstGradientColor,
                        CustomColors.secondGradientColor
                      ])
                    : null,
              ),
              child: HourlyDetails(
                index: index,
                cardIndex: cardIndex.toInt(),
                temp: temp.round(),
                pressure: pressure,
                humidity: humidity,
                timeStamp:
                    DateTime.parse(timeStamp).millisecondsSinceEpoch ~/ 1000,
                weatherIcon: iconUrl,
              ),
            ),
          );
        },
      ),
    );
  }

  String getIconUrl(double temp) {
    if (temp > 20) {
      return 'https://cdn-icons-png.flaticon.com/128/4215/4215517.png';
    } else if (temp >= 15 && temp <= 20) {
      return 'https://cdn-icons-png.flaticon.com/128/899/899681.png';
    } else if (temp < 15) {
      return 'https://cdn-icons-png.flaticon.com/128/3217/3217172.png';
    } else {
      return 'https://cdn-icons-png.flaticon.com/128/6408/6408911.png';
    }
  }

  Future<Pronosticos> fetchData() async {
    try {
      final response = await http.get(Uri.parse(ApiEndPoints.baseUrlPython));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return Pronosticos.fromJson(jsonData);
      } else {
        throw Exception('Error al cargar los datos');
      }
    } catch (error) {
      print(error.toString());

      throw error;
    }
  }
}

class HourlyDetails extends StatelessWidget {
  final int temp;
  final int index;
  final int cardIndex;
  final int timeStamp;
  final String weatherIcon;
  final double pressure;
  final double humidity;

  HourlyDetails({
    Key? key,
    required this.cardIndex,
    required this.index,
    required this.timeStamp,
    required this.temp,
    required this.weatherIcon,
    required this.pressure,
    required this.humidity,
  }) : super(key: key);

  String getTime(final timeStamp) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    String x = DateFormat('jm').format(time);
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(
            getTime(timeStamp),
            style: TextStyle(
              color: cardIndex == index
                  ? Colors.white
                  : CustomColors.textColorBlack,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(5),
          child: Image.network(
            weatherIcon,
            height: 40,
            width: 40,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Column(
            children: [
              Text(
                "${temp.toStringAsFixed(2)}°",
                style: TextStyle(
                  color: cardIndex == index
                      ? Colors.white
                      : CustomColors.textColorBlack,
                ),
              ),
              Text(
                "${pressure.toStringAsFixed(2)} hPa",
                style: TextStyle(
                  color: cardIndex == index
                      ? Colors.white
                      : CustomColors.textColorBlack,
                ),
              ),
              Text(
                "${humidity.toStringAsFixed(2)}%",
                style: TextStyle(
                  color: cardIndex == index
                      ? Colors.white
                      : CustomColors.textColorBlack,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
