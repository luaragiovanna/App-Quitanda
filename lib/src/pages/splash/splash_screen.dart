import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quitanda/src/config/custom_colors.dart';
import 'package:quitanda/src/pages/auth/controller/auth_controller.dart';

import 'package:quitanda/src/pages/widgets/app_name_widget.dart';
import 'package:quitanda/src/pages_routes/app_pages.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<AuthController>().validateToken();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              CustomColors.customSwatchColor,
              const Color.fromARGB(255, 124, 199, 109),
              Colors.white,
            ])),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppNameWidget(
              greenTitleColor: Colors.white,
              textSize: 40,
            ),
            const SizedBox(
              height: 10,
            ),
            CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation(CustomColors.customContrastColor),
            ),
          ],
        ),
      ),
    );
  }
}
