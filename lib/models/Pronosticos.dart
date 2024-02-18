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
    barometricPressure = json['barometricPressure'];
    humidity = json['humidity'];
    temperature = json['temperature'];
  }
}
