import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:bingebox/constants/color.dart';
import 'package:bingebox/view/reception_screen/reception_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: AnimatedSplashScreen(
          splashIconSize:500 ,
            duration: 3000,
            splash: const Image(image: AssetImage('assets/logo.png'),),
            nextScreen: const ReceptionScreen(),
            splashTransition: SplashTransition.fadeTransition,
            backgroundColor: backgroundColor)
    );
  }
}
