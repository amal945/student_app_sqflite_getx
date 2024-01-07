import 'package:final_project/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final splashController = Get.put(SplashController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<SplashController>(
      builder: (splashController) {
        return Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "https://i.pinimg.com/originals/a1/52/5a/a1525aa2c74d1eb05bf1f41234727bcf.jpg"))),
        );
      },
    ));
  }
}
