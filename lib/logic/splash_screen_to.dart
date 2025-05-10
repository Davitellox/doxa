import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreenTo extends StatelessWidget {
  final screen;
  const SplashScreenTo({super.key, required this.screen});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(
        child: Lottie.asset('assets/animation/planet.json'),
      ),
      nextScreen: screen,
      duration: 1200,
      backgroundColor: Colors.white,
      splashIconSize: 400,
    );
  }
}
