import 'dart:math';
import 'package:doxa/component/typewriter_text.dart';
import 'package:doxa/logic/bluetooth_service.dart';
import 'package:doxa/logic/connection_indicator.dart';
import 'package:doxa/logic/splash_screen_to.dart';
import 'package:doxa/pages/cmenu_screen.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';
import 'package:string_similarity/string_similarity.dart';

class Voicechat extends StatelessWidget {
  Voicechat({super.key});

  // List of image assets
  final List<String> imageAssets = [
    'assets/images/voicechat.png',
    'assets/images/voicechat1.png',
    'assets/images/voicechat5.jpg',
    'assets/images/voicechat6.jpg',
  ];

  // Function to get a random image
  String getRandomImage() {
    final random = Random();
    return imageAssets[random.nextInt(imageAssets.length)];
  }

  void _openSpeechDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SpeechDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final random = Random();
    String randomImage = imageAssets[random.nextInt(imageAssets.length)];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Text(
          "Let's Chat!",
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
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 90,
            ),
            GestureDetector(
              child: Image.asset(
                randomImage,
                width: 300.0,
                height: 300.0,
                fit: BoxFit.cover,
              ),
              onTap: () => _openSpeechDialog(context),
            ),
            const SizedBox(
              height: 50,
            ),
            const TypewriterTextCustom(
                textchoice: "Tap to Speak!..",
                fontsizee: 28,
                bold: true,
                millisecspd: 150)
          ],
        ),
      ),
    );
  }
}

class SpeechDialog extends StatefulWidget {
  const SpeechDialog({super.key});

  @override
  _SpeechDialogState createState() => _SpeechDialogState();
}

class _SpeechDialogState extends State<SpeechDialog> {
  String result = "";
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _recognizedText = "Press the button and start speaking";

  void analyzeText(String input) {
    input = input.toLowerCase(); // Convert to lowercase for case insensitivity
    String mode = "No Match Found";
    String command = ""; // Default Bluetooth command

    List<String> greetings = [
      "hey",
      "hello",
      "hi",
      "how are you",
      "good morning",
      "good afternoon",
      "good evening",
      "good night",
      "how are you doing?",
      "hey, goodday, how are you doing",
      "hello, how are you doing",
    ];

    List<String> questions = [
      "I have a question",
      "I have a questions a few for you",
      "few questions for you",
      "I have a question for you, i would like you to answer",
      "I have a few questions for you, i would like you to answer",
    ];

    List<String> leadership = [
      "leader",
      "leadership qualities",
      "qualities of a good leader"
    ];
    List<String> nameIntro = [
      "my name is",
      "i am",
      "i'm",
      "i am called",
      "i'm called",
      "i am known as",
      "i'm known as",
      "you can call me",
      "you can refer to me as"
    ];
    List<String> faithGuide = [
      "become useful in the house of God",
      "use my gifts",
      "become useful in the house of God",
      "put myself out there and become useful in the house of God"
    ];
    List<String> careerAdvice = [
      "what skills should I focus on to make money",
      "what skills should i learn",
      "in 21st century what skills should i learn"
          "should i learn",
      "skill should i learn"
    ];
    List<String> agreement = [
      "yes",
      "yeah",
      "sure",
      "ok",
      "okay",
      "fine",
      "yh i totally agree",
      "thats so true",
      "i agree",
      "yh i totally agree with that"
    ];

    List<String> farwell = [
      "goodbye",
      "bye",
      "thank you so much for your time",
      "goodbye, thank you so much",
      "bye, thank you for your time",
      "thank you for your time",
      "thank you so much",
      "thank you",
      "goodbye, thank you for your time"
    ];

    // Function to check similarity
    bool containsSimilar(List<String> keywords, String text) {
      return keywords
          .any((word) => text.contains(word) || text.similarityTo(word) > 0.6);
    }

    if (containsSimilar(greetings, input)) {
      mode = "Greeting Mode";
      command = "a"; //greeting protocol
    }

    if (containsSimilar(questions, input)) {
      mode = "Questions Mode";
      command = "c"; //Questions protocol
    }

    if (containsSimilar(leadership, input)) {
      mode = "Leadership Mode";
      command = "d"; //Leadership protocol
    }

    if (containsSimilar(nameIntro, input)) {
      mode = "NameInt Mode";
      command = "b"; //Name intro protocol
    }
    if (containsSimilar(faithGuide, input)) {
      mode = "Faith Guide";
      command = "e"; //Faith Guide protocol
    }

    if (containsSimilar(careerAdvice, input)) {
      mode = "Career Advice";
      command = "f"; //Career advice protocol
    }
    if (containsSimilar(agreement, input)) {
      mode = "Agreement";
      command = "m"; //Agreement protocol
    }
    if (containsSimilar(farwell, input)) {
      mode = "Farwell Mode";
      command = "n"; //Farwell protocol
    }
    setState(() {
      result = mode;
    });
    // Print result
    print("Mode: $mode");

    // Send command to Bluetooth
    if (command.isNotEmpty) {
      // Send command to Bluetooth
      BluetoothService().sendCommand(command);
    } else {
      // Send default command
      print("Reply: I'm sorry, I didn't get that");
      BluetoothService().sendCommand("o"); //i'm sorry i didn't get that
    }
  }

  void _startListening() async {
    var status = await Permission.microphone.request();

    if (status.isGranted) {
      bool available = await _speech.initialize(
        onStatus: (status) => print('Status: $status'),
        onError: (error) => print('Error: $error'),
      );

      if (available) {
        setState(() {
          _isListening = true;
          _recognizedText = "Listening...";
        });

        _speech.listen(
          onResult: (result) {
            setState(() {
              _recognizedText = result.recognizedWords;
            });

            ///// text check matches  // Passing Text to Algorithm
            if (_recognizedText.toLowerCase() == "hello world") {
              print("Reply: Hi there! How can I help?");
            }
            //if recognized text is not empty, analyize it;
            if (_recognizedText.isNotEmpty) {
              analyzeText(_recognizedText);
            }
            // analyzeText(_recognizedText);
          },
        );
      }
    } else if (status.isPermanentlyDenied) {
      _showPermissionDialog();
    } else {
      print("Microphone permission denied.");
    }
  }

  void _stopListening() {
    _speech.stop();
    setState(() => _isListening = false);
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Microphone Permission Needed"),
        content: Text(
            "This app requires microphone access to record speech. Please enable it in settings."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              openAppSettings();
              Navigator.pop(context);
            },
            child: Text("Go to Settings"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Let's ChaT",
        style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _recognizedText,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.5),
          ),
          SizedBox(height: 20),
          FloatingActionButton(
            onPressed: _isListening ? _stopListening : _startListening,
            child: Icon(
              _isListening ? Icons.mic_off : Icons.mic,
              color: Colors.deepPurpleAccent,
            ),
          ),
          SizedBox(height: 20),
          Text("Protocol: $result", style: TextStyle(fontSize: 18)),
          SizedBox(height: 10),
          IconButton(
              onPressed: () {
                BluetoothService().sendCommand("GREET_CMD");
              }, //stop sound, send; " i'm sorry i didn't get that"
              icon: Icon(Icons.close, color: Colors.red, size: 30)),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Close", style: TextStyle(color: Colors.deepPurple)),
        ),
      ],
    );
  }
}
