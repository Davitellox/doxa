import 'package:flutter/material.dart';
import 'package:string_similarity/string_similarity.dart';

class TextAnalyzerPage extends StatefulWidget {
  const TextAnalyzerPage({super.key});

  @override
  _TextAnalyzerPageState createState() => _TextAnalyzerPageState();
}

class _TextAnalyzerPageState extends State<TextAnalyzerPage> {
  final TextEditingController _controller = TextEditingController();
  String result = "";

  void analyzeText(String input) {
    input = input.toLowerCase(); // Convert to lowercase for case insensitivity

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
      "thank you", "goodbye, thank you for your time"
    ];

    // Function to check similarity
    bool containsSimilar(List<String> keywords, String text) {
      return keywords
          .any((word) => text.contains(word) || text.similarityTo(word) > 0.6);
    }

    if (containsSimilar(greetings, input)) {
      setState(() {
        result = "Greeting Mode";
      });
      return;
    }

    if (containsSimilar(leadership, input)) {
      setState(() {
        result = "Leadership Qualities";
      });
      return;
    }

    if (containsSimilar(nameIntro, input)) {
      setState(() {
        result = "Name Introduction";
      });
      return;
    }
    if (containsSimilar(faithGuide, input)) {
      setState(() {
        result = "Faith Guide";
      });
      return;
    }

    if (containsSimilar(careerAdvice, input)) {
      setState(() {
        result = "Career Advice";
      });
      return;
    }
    if (containsSimilar(agreement, input)) {
      setState(() {
        result = "Agreement";
      });
      return;
    }
    if (containsSimilar(farwell, input)) {
      setState(() {
        result = "Farwell";
      });
      return;
    }
    setState(() {
      result = "No Match Found";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Text Analyzer")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: "Enter text",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => analyzeText(_controller.text),
              child: Text("Analyze"),
            ),
            SizedBox(height: 20),
            Text("Result: $result", style: TextStyle(fontSize: 18)),    //yyy
          ],
        ),
      ),
    );
  }
}
