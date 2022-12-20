import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/controllers/global_controller.dart';
import 'package:weather_app/widgets/header_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // call the controller
  final GlobalController globalController = Get.put(GlobalController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // The text button will call the increment method defined in the controller class and
        // Text which will show the updated value of the count.
        child: Obx(() => globalController.checkLoading().isTrue ? const Center(
          child: CircularProgressIndicator(),
        )
        : ListView(
      scrollDirection: Axis.vertical,
      children: const [
        HeaderWidget(),
      ],
        )),
      ),
    );
  }
}
