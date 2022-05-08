class DailyWeatherData {
  final DateTime date;
  final int temp;
  final String main;
  final String icon;

  DailyWeatherData(
      {required this.date,
      required this.temp,
      required this.main,
      required this.icon});

  factory DailyWeatherData.fromJson(Map<String, dynamic> json) {
    return DailyWeatherData(
      date: new DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000,
          isUtc: false),
      temp: json['temp']['max'].toInt(),
      main: json['weather'][0]['main'],
      icon: json['weather'][0]['icon'],
    );
  }
}
