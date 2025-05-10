import 'package:doxa/pages/link_pages/scripture_drill.dart';
import 'package:doxa/logic/bluetooth_service.dart';
import 'package:doxa/logic/connection_indicator.dart';
import 'package:doxa/pages/link_pages/gyroscope.dart';
import 'package:doxa/pages/link_pages/motion_screen.dart';
import 'package:doxa/pages/link_pages/voicechat.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final PageController _pageController = PageController(initialPage: 1000);

  // Widgets for infinite swipe
  final List<Widget> _pages = [
    SwipeItem(
      //Scripture Drill   ----- v1 null
      image: 'assets/animation/script.gif',
      label: "Scripture Drill",
      subtext: "Wanna Learn some Bible Verses?",
      onTap: (BuildContext context) {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const ScriptureDrill()));
      },
    ),
    SwipeItem(
      //MotionScreen //////////////////////////////////////////////////////////////
      image: 'assets/animation/motion-mode3.gif',
      label: "Motion Screen",
      subtext: "Whoo.. the fun stuff, Let's Explore and Move around!",
      onTap: (BuildContext context) {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => MotionScreen()));
      },
    ),
    SwipeItem(
      //Bible Quiz  ------ V1 Null
      image: 'assets/animation/voicechat4.gif',
      label: "Bible Quiz",
      subtext: "I have some really fun and interesting quiz for you!",
      onTap: (BuildContext context) {
        // Navigator.push(context, MaterialPageRoute(builder: (_) => BibleQuiz()));
      },
    ),
    SwipeItem(
      //gyroscope screen  //////////////////////////////////////////////////////////
      image: 'assets/animation/gyroscope2.gif',
      label: "Gyroscope Mode",
      subtext: "Tilt your device and make me move! Cool, right?",
      onTap: (BuildContext context) {
        Navigator.push(context, MaterialPageRoute(builder: (_) => Gyroscope()));
      },
    ),
    SwipeItem(
      //voiceChat ///////////////////////////////////////////////////////////////////
      image: 'assets/animation/voicechat3.gif',
      label: "Voice Chat",
      subtext: "Let's Chat!! Tell me what's on your mind!",
      onTap: (BuildContext context) {
        Navigator.push(context, MaterialPageRoute(builder: (_) => Voicechat()));
      },
    ),
    SwipeItem(
      //Camera Mode  ----- V1 Null
      image: 'assets/animation/camera.gif',
      label: "Camera Mode",
      subtext: "Learn new things about the objects around you!",
      onTap: (BuildContext context) {
        // Navigator.push(context, MaterialPageRoute(builder: (_) => const haltscreen()));
      },
    ),
  ];

  int _currentIndex(int index) {
    final length = _pages.length;
    return ((index % length) + length) % length;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool exitApp = await _showExitDialog(context);
        if (exitApp) {
          BluetoothService().disconnect(); //disconnect BT
          SystemNavigator.pop(); // Closes app properly on Android
        }
        return false; // Prevents default back action
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: ConnectionIndicator(),
          automaticallyImplyLeading: false,
        ),
        backgroundColor: Colors.white,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView.builder(
              controller: _pageController,
              itemBuilder: (context, index) {
                final actualIndex = _currentIndex(index);
                return _pages[actualIndex];
              },
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: SmoothPageIndicator(
                controller: _pageController,
                count: _pages.length,
                effect: const ExpandingDotsEffect(
                    dotHeight: 10, dotWidth: 10, activeDotColor: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SwipeItem extends StatelessWidget {
  final String image;
  final String label;
  final String subtext;
  final Function(BuildContext) onTap;

  const SwipeItem({
    super.key,
    required this.image,
    required this.label,
    required this.onTap,
    required this.subtext,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(context),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              height: 230,
              width: 230,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(
              label,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  subtext,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.5,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future<bool> _showExitDialog(BuildContext context) async {
  return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Exit App'),
          content: Text('Are you sure you want to exit?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false), // Stay in app
              child: Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true), // Exit app
              child: Text('Yes'),
            ),
          ],
        ),
      ) ??
      false; // Return false if the dialog is dismissed
}
