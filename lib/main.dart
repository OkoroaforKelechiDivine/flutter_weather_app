import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/screens/home_screen.dart';

// @dart=2.9

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context){
    return const GetMaterialApp(
      home: HomeScreen(),
      title: "Weather",
      debugShowCheckedModeBanner: false,
    );
  }
}