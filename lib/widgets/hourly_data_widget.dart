import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/utils/custom_colors.dart';
import 'package:weather_app/controller/global_controller.dart';

class HourlyDataWidget extends StatelessWidget {
  // card index
  RxInt cardIndex = GlobalController().getIndex();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          alignment: Alignment.topCenter,
          child: const Text("Hoy", style: TextStyle(fontSize: 18)),
        ),
        hourlyList(),
      ],
    );
  }

  Widget hourlyList() {
    return Container(
      height: 160,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10/* quemado*/ > 12
            ? 14
            : 24, //quemado
        itemBuilder: (context, index) {
          return Obx((() => GestureDetector(
              onTap: () {
                cardIndex.value = index;
              },
              child: Container(
                width: 90,
                margin: const EdgeInsets.only(left: 20, right: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(0.5, 0),
                          blurRadius: 30,
                          spreadRadius: 1,
                          color: CustomColors.dividerLine.withAlpha(150))
                    ],
                    gradient: cardIndex.value == index
                        ? const LinearGradient(colors: [
                      CustomColors.firstGradientColor,
                      CustomColors.secondGradientColor
                    ])
                        : null),
                child: HourlyDetails(
                  index: index,
                  cardIndex: cardIndex.toInt(),
                  temp: 25, // QUEMADO
                  timeStamp: DateTime.now().millisecondsSinceEpoch ~/ 1000,
                  weatherIcon:
                  "01d",
                ),
              ))));
        },
      ),
    );
  }
}

// hourly details class
class HourlyDetails extends StatelessWidget {
  int temp;
  int index;
  int cardIndex;
  int timeStamp;
  String weatherIcon;

  HourlyDetails(
      {Key? key,
        required this.cardIndex,
        required this.index,
        required this.timeStamp,
        required this.temp,
        required this.weatherIcon})
      : super(key: key);
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
          child: Text(getTime(timeStamp),
              style: TextStyle(
                color: cardIndex == index
                    ? Colors.white
                    : CustomColors.textColorBlack,
              )),
        ),
        Container(
            margin: const EdgeInsets.all(5),
            child: Image.network(
              "https://cdn-icons-png.freepik.com/256/10961/10961088.png",
              height: 40,
              width: 40,
            )),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Text("$temp°",
              style: TextStyle(
                color: cardIndex == index
                    ? Colors.white
                    : CustomColors.textColorBlack,
              )),
        )
      ],
    );
  }
}
