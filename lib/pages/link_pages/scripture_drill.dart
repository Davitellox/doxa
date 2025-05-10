import 'dart:math';
import 'package:doxa/component/typewriter_text.dart';
import 'package:doxa/logic/splash_screen_to.dart';
import 'package:doxa/pages/cmenu_screen.dart';
import 'package:flutter/material.dart';

class ScriptureDrill extends StatefulWidget {
  const ScriptureDrill({super.key});

  @override
  State<ScriptureDrill> createState() => _ScriptureDrillState();
}

class _ScriptureDrillState extends State<ScriptureDrill> {
  // List of image assets
  final List<String> imageAssets = [
    'assets/images/biblequiz.jpg',
    'assets/images/biblequiz.jpg',
    // 'assets/images/ScriptureDrill.jpg',
  ];

  // Function to get a random image
  String getRandomImage() {
    final random = Random();
    return imageAssets[random.nextInt(imageAssets.length)];
  }

  @override
  Widget build(BuildContext context) {
    final random = Random();
    String randomImage = imageAssets[random.nextInt(imageAssets.length)];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Let's talk about the bible",
          style: TextStyle(fontSize: 15),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const SplashScreenTo(
                    screen: MenuScreen(),
                  ),
                ));
          },
          child: IconButton(
            icon: const Icon(
              Icons.home,
              size: 50,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SplashScreenTo(
                      screen: MenuScreen(),
                    ),
                  ));
            },
          ),
        ),
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 25,
            ),
            GestureDetector(
              child: Image.asset(
                randomImage,
                // width: 350.0,
                // height: 350.0,
                fit: BoxFit.cover,
              ),
              onTap: () {
                ScriptureAlgorithm();
              },
            ),
            const SizedBox(
              height: 30,
            ),
            const TypewriterTextCustom(
                textchoice: "Tap to Speak!",
                fontsizee: 28,
                bold: true,
                millisecspd: 150)
          ],
        ),
      ),
    );
  }

  void ScriptureAlgorithm() {
    // POPup dialog and mic read guage
  }
}
