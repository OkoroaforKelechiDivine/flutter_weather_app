import 'package:flutter/material.dart';
import 'package:flutter_weather_icons/flutter_weather_icons.dart';

class UvIndex {
  static String mapUviValueToString({var uvi}) {
    String weatherCondition;
    if (uvi <= 2) {
      return weatherCondition = 'Low';
    } else if (uvi <= 5) {
      return weatherCondition = 'Medium';
    } else if (uvi <= 7) {
      return weatherCondition = 'High';
    } else if (uvi <= 10) {
      return weatherCondition = 'Very High';
    } else if (uvi >= 11) {
      return weatherCondition = 'Extreme';
    } else {
      weatherCondition = 'Unknown';
    }
    return weatherCondition;
  }
}

class MapString {
  static Widget mapInputToWeather(String input, BuildContext context) {
    String textInput;
    switch (input) {
      case 'Tornado': textInput = 'Tornado';
        break;
      case 'Thunderstorm': textInput = 'Thunderstorm';
        break;
      case 'Drizzle': textInput = 'Drizzly';
        break;
      case 'Rain': textInput = 'Raining';
        break;
      case 'Snow': textInput = 'Snowing';
        break;
      case 'Mist': textInput = 'Misty';
        break;
      case 'fog': textInput = 'Foggy';
        break;
      case 'Smoke': textInput = 'Smoky';
        break;
      case 'Squall': textInput = 'Squally';
        break;
      case 'Haze': textInput = 'Hazy';
        break;
      case 'Dust': textInput = 'Dusty';
        break;
      case 'Sand': textInput = 'Sandy';
        break;
      case 'Ash': textInput = 'Ashy';
        break;
      case 'Clear': textInput = "Sunny";
        break;
      case 'Clouds': textInput = "Cloudy";
        break;
      default: textInput = "No Info";
    }
    return Text(
      textInput, style: TextStyle(fontSize: 15,),
    );
  }

  static Icon mapStringToIcon(String input, BuildContext context, double iconSize) {
    IconData inputIcon;
    switch (input) {
      case 'Thunderstorm': inputIcon = WeatherIcons.wiThunderstorm;
        break;
      case 'Drizzle': inputIcon = WeatherIcons.wiSprinkle;
        break;
      case 'Rain': inputIcon = WeatherIcons.wiRain;
        break;
      case 'Snow': inputIcon = WeatherIcons.wiSnow;
        break;
      case 'Clear': inputIcon = WeatherIcons.wiDaySunny;
        break;
      case 'Clouds': inputIcon = WeatherIcons.wiCloudy;
        break;
      case 'Mist': inputIcon = WeatherIcons.wiFog;
        break;
      case 'fog': inputIcon = WeatherIcons.wiFog;
        break;
      case 'Smoke': inputIcon = WeatherIcons.wiSmoke;
        break;

      case 'Haze':
      case 'Dust':
      case 'Sand': inputIcon = WeatherIcons.wiSandstorm;
        break;
      case 'Ash': inputIcon = WeatherIcons.wiVolcano;
        break;
      case 'Squall':
      case 'Tornado': inputIcon = WeatherIcons.wiHurricaneWarning;
        break;
      default: inputIcon = WeatherIcons.wiNa;
    }
    return Icon(
      inputIcon, size: iconSize, color: Theme.of(context).primaryColor,
    );
  }
}
