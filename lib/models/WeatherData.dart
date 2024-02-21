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
  final String dateTime;
  final int windSpeed;
  final double temperature;
  final int humidity;
  final double barometricPressure;
  final DateTime? deletedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String state;
  final String id;

  WeatherEntry({
    required this.dateTime,
    required this.windSpeed,
    required this.temperature,
    required this.humidity,
    required this.barometricPressure,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.state,
    required this.id,
  });

  factory WeatherEntry.fromJson(Map<String, dynamic> json) {
    return WeatherEntry(
      dateTime: json['dateTime'],
      windSpeed: json['windSpeed'],
      temperature: json['temperature'],
      humidity: json['humidity'],
      barometricPressure: json['barometricPressure'],
      deletedAt: json['deletedAt'] != null
          ? DateTime.parse(json['deletedAt'])
          : null,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      state: json['state'],
      id: json['id'],
    );
  }
}
