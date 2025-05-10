import 'dart:async';
import 'package:doxa/logic/bluetooth_service.dart';
import 'package:doxa/logic/connection_indicator.dart';
import 'package:doxa/logic/splash_screen_to.dart';
import 'package:doxa/pages/cmenu_screen.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class Gyroscope extends StatefulWidget {
  const Gyroscope({super.key});

  @override
  _GyroscopeState createState() => _GyroscopeState();
}

class _GyroscopeState extends State<Gyroscope> {
  String direction = "";
  bool ledon = false;
  StreamSubscription<GyroscopeEvent>? _gyroSubscription;

  void _ledon() {
    print("Led on");
    BluetoothService().sendCommand('x');
    // ledon = true;
  }

  void _ledoff() {
    print("Led off");
    BluetoothService().sendCommand('y');
    // ledon = false;
  }

  void _moveStop() {
    BluetoothService().sendCommand('S');
  }

  @override
  void initState() {
    String command = "";
    super.initState();

    // Listen to gyroscope events
    _gyroSubscription = gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        if (event.y < -1.0) {
          direction = "Left"; // Tilting phone top (A) downward
          command = "L";
        } else if (event.y > 1.0) {
          direction = "Right"; // Tilting phone bottom (B) downward
          command = "R";
        } else if (event.x < -1.0) {
          direction = "Forward"; // Tilting left side (C) downward
          command = "F";
        } else if (event.x > 1.0) {
          direction = "Backward"; // Tilting right side (D) downward
          command = "B";
        } else {
          direction = "Neutral"; // No significant movement
          // command = "P";
        }
      });
      if (command.isNotEmpty) {
        BluetoothService().sendCommand(command);
        // setState(() {
        //   direction = command;
        // });
      }

      if (direction != "Neutral") {
        print("Move: $direction");
        // _moveStop();
      }
    });
  }

  @override
  void dispose() {
    _gyroSubscription?.cancel(); // Stop listening when the screen is closed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Text(
          "Tilt to Move!",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
            child: ConnectionIndicator(),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              _gyroSubscription?.cancel();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SplashScreenTo(
                      screen: MenuScreen(),
                    ),
                  ));
            },
            child: IconButton(
              icon: Icon(
                Icons.home,
                size: 50,
              ),
              onPressed: () {
                _gyroSubscription?.cancel(); // Stop gyroscope updates
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SplashScreenTo(screen: MenuScreen())),
                );
              },
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  _moveStop();
                },
                onDoubleTapDown: (_) {
                  ledon ? ledon = false : ledon = true;
                  ledon ? _ledon() : _ledoff();
                },
              ),
            ),
            Positioned(
                top: 140,
                child: Image.asset('assets/images/gyro-up.png',
                    width: 80, height: 80)),
            Positioned(
                bottom: 140,
                child: Image.asset('assets/images/gyro-down.png',
                    width: 80, height: 80)),
            Positioned(
                left: 50,
                child: Image.asset('assets/images/gyro-left.png',
                    width: 80, height: 80)),
            Positioned(
                right: 50,
                child: Image.asset('assets/images/gyro-right.png',
                    width: 80, height: 80)),
            Positioned(
              bottom: 50,
              child: Text(
                "Direction: $direction",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
