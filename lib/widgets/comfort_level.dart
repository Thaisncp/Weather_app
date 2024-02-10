import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:weather_app/utils/custom_colors.dart';

class ComfortLevel extends StatelessWidget {
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
                  initialValue: 15.8, // HUMEDAD VALOR
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
                  RichText(
                    text: TextSpan(children: [
                      const TextSpan(
                        text: "ESTADO: ",
                        style: TextStyle(
                          fontSize: 14,
                          height: 0.8,
                          color: CustomColors.textColorBlack,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: "BIEN", // NOSE
                        style: const TextStyle(
                          fontSize: 14,
                          height: 0.8,
                          color: CustomColors.textColorBlack,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ]),
                  ),
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
