import 'package:doxa/logic/bluetooth_service.dart';
import 'package:doxa/logic/connection_indicator.dart';
import 'package:doxa/logic/splash_screen_to.dart';
import 'package:doxa/pages/cmenu_screen.dart';
import 'package:flutter/material.dart';

class MotionScreen extends StatefulWidget {
  const MotionScreen({super.key});

  @override
  State<MotionScreen> createState() => _MotionScreenState();
}

class _MotionScreenState extends State<MotionScreen> {
  bool ledon = false;
  double speed = 3;

  void _Horn() {
    BluetoothService().sendCommand('H');
  }

  void _ledon() {
    BluetoothService().sendCommand('x');
  }

  void _ledoff() {
    BluetoothService().sendCommand('y');
  }

  void _moveUp() {
    print("up");
    BluetoothService().sendCommand('F');
  }

  void _moveDown() {
    print("down");
    BluetoothService().sendCommand('B');
  }

  void _moveRight() {
    print("right");
    BluetoothService().sendCommand('R');
  }

  void _moveLeft() {
    print("left");
    BluetoothService().sendCommand('L');
  }

  void _moveStop() {
    BluetoothService().sendCommand('S');
  }

  void _setSpeed(double value) {
    setState(() {
      speed = value;
    });

    List<String> speedCommands = ['g', 'h', 'i', 'j', 'k', 'l'];
    BluetoothService().sendCommand(speedCommands[value.toInt()]);
  }

  // ✅ New functions for arm control
  void _armLeft() {
    BluetoothService().sendCommand('q');
  }

  void _armRight() {
    BluetoothService().sendCommand('p');
  }

  void _armStop() {
    BluetoothService().sendCommand('r');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        decoration: BoxDecoration(color: Colors.white),
        padding: EdgeInsets.symmetric(horizontal: 2, vertical: 25),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
            onPressed: () {
              ledon ? ledon = false : ledon = true;
              ledon ? _ledon() : _ledoff();
            },
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              padding: EdgeInsets.all(12),
            ),
            child: Image.asset('assets/images/led.png', width: 40, height: 40),
          ),
        ]),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Whoo.. Let's Move..!",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: Center(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ConnectionIndicator()),
        ),
        actions: [
          GestureDetector(
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
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              // ✅ Arm Control Buttons (Above Slider)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTapDown: (_) {
                      _armLeft();
                    },
                    onTapUp: (_) {
                      _armStop();
                    },
                    onTapCancel: () {
                      _armStop();
                    },
                    child: ElevatedButton(
                      //arm left
                      onPressed: _armLeft,
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      ),
                      child: Image.asset('assets/images/left-arm.png',
                          width: 40, height: 40),
                    ),
                  ),
                  GestureDetector(
                    onTapDown: (_) {
                      _armRight();
                    },
                    onTapUp: (_) {
                      _armStop();
                    },
                    onTapCancel: () {
                      _armStop();
                    },
                    child: ElevatedButton(
                      //arm right
                      onPressed: _armRight,
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      ),
                      child: Image.asset('assets/images/right-arm.png',
                          width: 40, height: 40),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10),

              // ✅ Speed Slider
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Text("Speed: ${speed.toInt()}",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Slider(
                      value: speed,
                      min: 0,
                      max: 5,
                      divisions: 5,
                      label: speed.toInt().toString(),
                      onChanged: _setSpeed,
                    ),
                  ],
                ),
              ),

              // ✅upButton
              GestureDetector(
                onTapDown: (_) {
                  _moveUp();
                },
                onTapUp: (_) {
                  _moveStop();
                },
                onTapCancel: () {
                  _moveStop();
                },
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(20),
                  ),
                  child: Image.asset('assets/images/up.png',
                      width: 70, height: 70),
                ),
              ),

              SizedBox(height: 10),

              //
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Left Button
                  GestureDetector(
                    onTapDown: (_) {
                      _moveLeft();
                    },
                    onTapUp: (_) {
                      _moveStop();
                    },
                    onTapCancel: () {
                      _moveStop();
                    },
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(20),
                      ),
                      child: Image.asset('assets/images/left.png',
                          width: 70, height: 70),
                    ),
                  ),

                  SizedBox(width: 30),

                  // Horn Button
                  ElevatedButton(
                    onPressed: _Horn,
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(12),
                    ),
                    child: Image.asset('assets/images/horn.png',
                        width: 40, height: 40),
                  ),

                  SizedBox(width: 30),

                  // Down Button
                  GestureDetector(
                    onTapDown: (_) {
                      _moveRight();
                    },
                    onTapUp: (_) {
                      _moveStop();
                    },
                    onTapCancel: () {
                      _moveStop();
                    },
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(20),
                      ),
                      child: Image.asset('assets/images/right.png',
                          width: 70, height: 70),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 2),

              // ✅ Bottom Button
              GestureDetector(
                onTapDown: (_) {
                  _moveDown();
                },
                onTapUp: (_) {
                  _moveStop();
                },
                onTapCancel: () {
                  _moveStop();
                },
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(20),
                  ),
                  child: Image.asset('assets/images/down.png',
                      width: 70, height: 70),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
