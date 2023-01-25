import 'package:flutter/cupertino.dart';

class DailyWeather with ChangeNotifier {
  var dailyTemperature;
  var condition;
  var date;
  var precipitation;
  var uvi;

  DailyWeather({
    this.dailyTemperature,
    this.condition,
    this.date,
    this.precipitation,
    this.uvi,
  });

  factory DailyWeather.fromJson(Map<String, dynamic> json) {
    final precipitationData = json['daily'][0]['pop'];
    final calculatePrecipitation = precipitationData * 100;
    final precipitation = calculatePrecipitation.toStringAsFixed(0);
    return DailyWeather(
      precipitation: precipitation,
      uvi: json['daily'][0]['uvi'],
    );
  }



  static DailyWeather fromDailyJson(dynamic json) {
    return DailyWeather(
      dailyTemperature: json['temp']['day'],
      condition: json['weather'][0]['main'],
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000, isUtc: true),
    );
  }

  static DailyWeather fromHourlyJson(dynamic json) {
    return DailyWeather(
      dailyTemperature: json['temp'],
      condition: json['weather'][0]['main'],
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
    );
  }
}
