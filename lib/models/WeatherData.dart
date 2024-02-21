class WeatherData {
  final String? msg;
  final int? totalCount;
  final List<WeatherEntry> data;

  WeatherData({
    this.msg = "",
    this.totalCount = 0,
    required this.data,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      msg: json['msg'],
      totalCount: json['totalCount'],
      data: (json['results'] as List)
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
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String state;
  final String id;

  WeatherEntry({
    this.dateTime = '',
    this.windSpeed = 0,
    this.temperature = 0.0,
    this.humidity = 0,
    this.barometricPressure = 0.0,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.state = '',
    this.id = '',
  });

  factory WeatherEntry.fromJson(Map<String, dynamic> json) {
    return WeatherEntry(
      dateTime: json['dateTime'],
      windSpeed: json['windSpeed'],
      temperature: json['temperature'],
      humidity: json['humidity'],
      barometricPressure: json['barometricPressure'],
      deletedAt:
          json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
      createdAt: DateTime.parse(json['createdAt']),
      // updatedAt: DateTime.parse(json['updatedAt']),
      state: json['state'],
      id: json['id'],
    );
  }
}
