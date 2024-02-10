import 'package:flutter/material.dart';
import 'package:weather_app/utils/custom_colors.dart';

class CurrentWeatherWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //tempeture area
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
                'https://www.pngall.com/wp-content/uploads/2017/01/Temperature-PNG-Clipart.png',
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
                "${5}hPa", //PRESION ATMOSFERICA
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
              width: 60,
              child: Text(
                "20°C",//TEMPERATURAAAAA
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
              width: 60,
              child: Text(
                "50%", //HUMEDADDD
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            )
          ],
        )
      ],
    );
  }

  Widget tempeatureAreaWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.network(
          "https://cdn-icons-png.freepik.com/256/10961/10961088.png", //ESTA QUEMADA
          height: 80,
          width: 80,
        ),
        Container(
          height: 50,
          width: 1,
          color: CustomColors.dividerLine,
        ),
        RichText(
          text: TextSpan(children: [
            TextSpan(
                text: "25°C", //VALOR QUEMADO
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 68,
                  color: CustomColors.textColorBlack,
                )),
            TextSpan(
                text: "Soleado", //ESTOS VALORES ESTAN QUEMADOS
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Colors.grey,
                )),
          ]),
        )
      ],
    );
  }
}
