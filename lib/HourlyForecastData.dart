class HourlyForecastData {
  final DateTime time;
  final int temp;
  final String condition;
  final String icon;

  HourlyForecastData(
      {required this.time,
      required this.temp,
      required this.condition,
      required this.icon});

  factory HourlyForecastData.fromJson(Map<String, dynamic> json) {
    return HourlyForecastData(
      time:
          DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000, isUtc: false),
      temp: json['temp'].toInt(),
      condition: json['weather'][0]['main'],
      icon: json['weather'][0]['icon'],
    );
  }
}
