import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/utils/custom_colors.dart';

class DailyDataForecast extends StatelessWidget {
  // string manipulation
  String getDay(final day) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(day * 1000);
    final x = DateFormat('EEE').format(time);
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: CustomColors.dividerLine.withAlpha(150),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(bottom: 10),
            child: const Text(
              "Proximos dias",
              style:
              TextStyle(color: CustomColors.textColorBlack, fontSize: 17),
            ),
          ),
          dailyList(),
        ],
      ),
    );
  }

  Widget dailyList() {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 8 /**QUEMADO*/ > 7
            ? 7
            : 15,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                  height: 60,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 80,
                        child: Text(
                          getDay(07), //QUEMADO
                          style: const TextStyle(
                              color: CustomColors.textColorBlack, fontSize: 13),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: Image.network(
                            "https://cdn-icons-png.flaticon.com/512/5566/5566148.png"), //QUEMADA
                      ),
                      Text(
                          "50°C/0")//TEMPERATURA MAX/MIN QUEMADO
                    ],
                  )),
              Container(
                height: 1,
                color: CustomColors.dividerLine,
              )
            ],
          );
        },
      ),
    );
  }
}
