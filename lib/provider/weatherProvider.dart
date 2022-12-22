import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'dart:convert';

import '../models/weather.dart';
import '../models/dailyWeather.dart';

class WeatherProvider with ChangeNotifier {
  String apiKey = '0e90a2ee9d09b58ca359037e52be2b7a';

  Weather weather = Weather();
  DailyWeather currentWeather = DailyWeather();

  List<DailyWeather> hourlyWeather = [];
  List<DailyWeather> hourly24Weather = [];
  List<DailyWeather> fiveDayWeather = [];
  List<DailyWeather> sevenDayWeather = [];

  bool isLoading;
  bool isRequestError = false;
  bool isLocationError = false;

  getWeatherData() async {
    isLoading = true;
    isRequestError = false;
    isLocationError = false;

    // request weather service location
    await Location().requestService().then((value) async {
      if (value) {
        final locationData = await Location().getLocation();
        var latitude = locationData.latitude;
        var longitude = locationData.longitude;

        Uri url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&units=metric&appid=$apiKey');
        Uri dailyUrl = Uri.parse('https://api.openweathermap.org/data/2.5/onecall?lat=$latitude&lon=$longitude&units=metric&exclude=minutely,current&appid=$apiKey');

        try {
          final response = await http.get(url);
          final extractedData = json.decode(response.body) as Map<String, dynamic>;
          weather = Weather.fromJson(extractedData);
        } catch (error) {
          isLoading = false;
          this.isRequestError = true;
          notifyListeners();
        }

        try {
          final response = await http.get(dailyUrl);
          final dailyData = json.decode(response.body) as Map<String, dynamic>;
          currentWeather = DailyWeather.fromJson(dailyData);

          var hourlyTemperature = [];
          var temperatureIn24Hours = [];
          var temperatureInSevenDays = [];

          List items = dailyData['daily'];
          List itemsHourly = dailyData['hourly'];

          hourlyTemperature = itemsHourly
              .map((item) => DailyWeather.fromHourlyJson(item))
              .toList()
              .skip(1)
              .take(3)
              .toList();

          temperatureIn24Hours = itemsHourly
              .map((item) => DailyWeather.fromHourlyJson(item))
              .toList()
              .skip(1)
              .take(24)
              .toList();

          temperatureInSevenDays = items
              .map((item) => DailyWeather.fromDailyJson(item))
              .toList()
              .skip(1)
              .take(7)
              .toList();

          hourlyWeather = hourlyTemperature;
          hourly24Weather = temperatureIn24Hours;
          sevenDayWeather = temperatureInSevenDays;
          isLoading = false;
          notifyListeners();
        } catch (error) {
          isLoading = false;
          this.isRequestError = true;
          notifyListeners();
          throw error;
        }
      } else {
        isLoading = false;
        isLocationError = true;
        notifyListeners();
      }
    });
  }

  searchWeatherData({String location}) async {
    isLoading = true;
    isRequestError = false;
    isLocationError = false;
    Uri url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$location&units=metric&appid=$apiKey');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      weather = Weather.fromJson(extractedData);
    } catch (error) {
      isLoading = false;
      this.isRequestError = true;
      notifyListeners();
      throw error;
    }

    var latitude = weather.latitude;
    var longitude = weather.longitude;
    print(latitude);
    print(longitude);

    Uri dailyUrl = Uri.parse('https://api.openweathermap.org/data/2.5/onecall?lat=$latitude&lon=$longitude&units=metric&exclude=minutely,current&appid=$apiKey');

    try {
      final response = await http.get(dailyUrl);
      final dailyData = json.decode(response.body) as Map<String, dynamic>;
      print(dailyUrl);
      currentWeather = DailyWeather.fromJson(dailyData);

      var hourlyTemperature = [];
      var temperatureIn24hours = [];
      var temperatureInSevenDays = [];

      List items = dailyData['daily'];
      List itemsHourly = dailyData['hourly'];

      hourlyTemperature = itemsHourly
          .map((item) => DailyWeather.fromHourlyJson(item))
          .toList()
          .skip(1)
          .take(3)
          .toList();

      temperatureIn24hours = itemsHourly
          .map((item) => DailyWeather.fromHourlyJson(item))
          .toList()
          .skip(1)
          .take(24)
          .toList();

      temperatureInSevenDays = items
          .map((item) => DailyWeather.fromDailyJson(item))
          .toList()
          .skip(1)
          .take(7)
          .toList();

      hourlyWeather = hourlyTemperature;
      hourly24Weather = temperatureIn24hours;
      sevenDayWeather = temperatureInSevenDays;
      isLoading = false;
      notifyListeners();
    } catch (error) {
      isLoading = false;
      this.isRequestError = true;
      notifyListeners();
      throw error;
    }
  }
}
