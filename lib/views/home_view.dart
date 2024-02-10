import 'package:flutter/material.dart';
import 'package:weather_app/utils/custom_colors.dart';
import 'package:weather_app/widgets/comfort_level.dart';
import 'package:weather_app/widgets/current_weather_widget.dart';
import 'package:weather_app/widgets/daily_data_forecast.dart';
import 'package:weather_app/widgets/header_widget.dart';
import 'package:weather_app/widgets/hourly_data_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // call
  //final GlobalController globalController =
  //Get.put(GlobalController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:
            Center(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              const SizedBox(
                height: 20,
              ),
              const HeaderWidget(),
              // for our current temp ('current')
              CurrentWeatherWidget(),
              const SizedBox(
                height: 20,
              ),
              HourlyDataWidget(),
              DailyDataForecast(
                
              ),
              Container(
                height: 1,
                color: CustomColors.dividerLine,
              ),
              const SizedBox(
                height: 10,
              ),
              ComfortLevel(
                  )
            ],
          ),
        ),
      ),
    );
  }
}
