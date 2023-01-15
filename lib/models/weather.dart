import 'package:flutter/cupertino.dart';

class Weather with ChangeNotifier {
  var temperature;
  var maxTemperature;
  var minTemperature;
  var latitude;
  var longitude;
  var feelsLike;
  var pressure;
  var description;
  var currently;
  var humidity;
  var windSpeed;
  var cityName;

  Weather({
    this.temperature,
    this.maxTemperature,
    this.minTemperature,
    this.latitude,
    this.longitude,
    this.feelsLike,
    this.pressure,
    this.description,
    this.currently,
    this.humidity,
    this.windSpeed,
    this.cityName,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temperature: json['main']['temp'],
      maxTemperature: json['main']['temp_max'],
      minTemperature: json['main']['temp_min'],
      latitude: json['coord']['lat'],
      longitude: json['coord']['lon'],
      feelsLike: json['main']['feels_like'],
      pressure: json['main']['pressure'],
      description: json['weather'][0]['description'],
      currently: json['weather'][0]['main'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'],
      cityName: json['name'],
    );
  }
}
