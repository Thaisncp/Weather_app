import 'dart:convert';

class WeatherData {
  final String msg;
  final int totalCount;
  final List<WeatherEntry> results;

  WeatherData({
    required this.msg,
    required this.totalCount,
    required this.results,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      msg: json['msg'],
      totalCount: json['totalCount'],
      results: (json['results'] as List)
          .map((entry) => WeatherEntry.fromJson(entry))
          .toList(),
    );
  }
}

class WeatherEntry {
  DateTime? dateTime;
  double windSpeed;
  double temperature;
  int humidity;
  double barometricPressure;
  String state;
  DateTime? deletedAt;
  DateTime? createdAt;
  String id;

  WeatherEntry({
    this.dateTime,
    required this.windSpeed,
    required this.temperature,
    required this.humidity,
    required this.barometricPressure,
    required this.state,
    this.deletedAt,
    this.createdAt,
    required this.id,
  });

  factory WeatherEntry.fromJson(Map<String, dynamic> json) {
    return WeatherEntry(
      dateTime: json['dateTime'] != null ? DateTime.parse(json['dateTime']) : null,
      windSpeed: json['windSpeed']?.toDouble() ?? 0.0,
      temperature: json['temperature']?.toDouble() ?? 0.0,
      humidity: json['humidity'] ?? 0,
      barometricPressure: json['barometricPressure']?.toDouble() ?? 0.0,
      state: json['state'] ?? "",
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      id: json['id'] ?? "",
    );
  }
}
