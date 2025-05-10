import 'package:doxa/pages/bluetooth_connect.dart';
import 'package:flutter/material.dart';

class IntroSplash extends StatefulWidget {
  const IntroSplash({super.key});

  @override
  State<IntroSplash> createState() => _IntroSplashState();
}

class _IntroSplashState extends State<IntroSplash> {
  // List of image assets

  @override
  void initState() {
    super.initState();
    // Navigate to another screen after 3 Sec,
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BluetoothConnect(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return introWelcomeScreen();
  }

  Widget introWelcomeScreen() {
    // Get a random image each time the widget is built
    // String randomImage = getRandomImage();

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.black
            ),
          ),
          Center(
            child: Image.asset(
              "assets/doxa_intro.gif",
              width: 400.0,
              height: 400.0,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
