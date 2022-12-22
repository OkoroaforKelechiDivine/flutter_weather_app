import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../helper/utils.dart';

class MainWeather extends StatelessWidget {
  final weatherData;

  MainWeather({this.weatherData});

  final TextStyle _style1 = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 20,
  );
  final TextStyle _style2 = TextStyle(
    fontWeight: FontWeight.w400,
    color: Colors.grey[700],
    fontSize: 16,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(25, 15, 25, 5),
      height: MediaQuery.of(context).size.height / 3.4,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on_outlined),
              Text('${weatherData.weather.cityName}', style: _style1),
            ],
          ),
          SizedBox(height: 5),
          Text(
            DateFormat.yMMMEd().add_jm().format(DateTime.now()),
            style: _style2,
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 25, right: 25),
                child: MapString.mapStringToIcon(
                    '${weatherData.weather.currently}', context, 55),
              ),
              Text(
                '${weatherData.weather.temperature.toStringAsFixed(0)}°C',
                style: TextStyle(
                  fontSize: 55,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            '${weatherData.weather.maxTemperature.toStringAsFixed(0)}°/ ${weatherData.weather.minTemperature.toStringAsFixed(0)}° Feels like ${weatherData.weather.feelsLike.toStringAsFixed(0)}°',
            style: _style1.copyWith(fontSize: 19),
          ),
          SizedBox(height: 5),
          Text(
            toBeginningOfSentenceCase('${weatherData.weather.description}'),
            style: _style1.copyWith(fontSize: 19),
          ),
        ],
      ),
    );
  }
}
