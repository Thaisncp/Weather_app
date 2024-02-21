import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:weather_app/utils/custom_colors.dart';

import '../controller/Conexion.dart';
import '../controller/service/RespuestaGenerica.dart';
import '../models/WeatherData.dart';

class ComfortLevel extends StatefulWidget {
  @override
  _ComfortLevelState createState() => _ComfortLevelState();
}

class _ComfortLevelState extends State<ComfortLevel> {
  String lastHumidity = "";

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    print('Al menos entra');
    Conexion conexion = Conexion();

    try {
      RespuestaGenerica respuesta = await conexion.solicitudGet('/weatherdatas?limit=1', false);

      print('Respuesta del backend: ${respuesta.msg}');

      if (respuesta.msg == 'OK' && respuesta.results != null) {
        // Verificar si la respuesta.data no es nula
        final List<dynamic> dataList = respuesta.results;
        if (dataList.isNotEmpty) {
          final WeatherEntry lastEntry = WeatherEntry.fromJson(dataList.last);
          setState(() {
            lastHumidity = "${lastEntry.humidity.toStringAsFixed(0)}%";
          });
        } else {
          print('La lista de datos está vacía.');
        }
      } else {
        // Manejar error de solicitud
        print('Error en la solicitud: ${respuesta.msg}');
      }
    } catch (error) {
      print('Error en fetchData: $error');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 1, left: 20, right: 20, bottom: 20),
          child: const Text(
            "Porcentaje de humedad",
            style: TextStyle(fontSize: 18),
          ),
        ),
        SizedBox(
          height: 180,
          child: Column(
            children: [
              Center(
                child: SleekCircularSlider(
                  min: 0,
                  max: 100,
                  initialValue: lastHumidity.isNotEmpty ? double.parse(lastHumidity.replaceAll('%', '')) : 0,
                  // Usar el último porcentaje de humedad o 0 si es vacío
                  appearance: CircularSliderAppearance(
                    customWidths: CustomSliderWidths(
                      handlerSize: 0,
                      trackWidth: 12,
                      progressBarWidth: 12,
                    ),
                    infoProperties: InfoProperties(
                      bottomLabelText: "Humedad",
                      bottomLabelStyle: const TextStyle(
                        letterSpacing: 0.1,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                    animationEnabled: true,
                    size: 140,
                    customColors: CustomSliderColors(
                      hideShadow: true,
                      trackColor: CustomColors.firstGradientColor.withAlpha(100),
                      progressBarColors: [
                        CustomColors.firstGradientColor,
                        CustomColors.secondGradientColor,
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 25,
                    margin: const EdgeInsets.only(left: 40, right: 40),
                    width: 1,
                    color: CustomColors.dividerLine,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
