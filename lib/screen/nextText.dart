import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

void main() {
  runApp(MaterialApp(
    home: YourWidget(),
  ));
}

class YourWidget extends StatefulWidget {
  @override
  _YourWidgetState createState() => _YourWidgetState();
}

class _YourWidgetState extends State<YourWidget> {
  int _currentIndex = 0;
  List<String> texts = [
    "First text",
    "Second text",
    "Third text",
  ];

  Key _textKey = UniqueKey();

  void _nextText() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % texts.length;
      _textKey = UniqueKey(); // Change the key to rebuild WidgetShowText
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animated Text Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WidgetShowText(
              key: _textKey, // Pass the key to WidgetShowText
              showText: texts[_currentIndex],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _nextText,
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

class WidgetShowText extends StatelessWidget {
  final String showText;

  const WidgetShowText({Key? key, required this.showText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400.0,
      child: DefaultTextStyle(
        style: const TextStyle(
          color: Colors.black,
          fontSize: 30.0,
          fontFamily: 'Agne',
        ),
        child: Center(
          child: AnimatedTextKit(
            totalRepeatCount: 1,
            animatedTexts: [
              TypewriterAnimatedText(
                showText,
                speed: Duration(milliseconds: 80),
              ),
            ],
            onTap: () {
              print("Tap Event");
            },
          ),
        ),
      ),
    );
  }
}
