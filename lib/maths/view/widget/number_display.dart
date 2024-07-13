import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

// ignore: must_be_immutable
class NumberDisplay extends StatefulWidget {
  final String language;
  const NumberDisplay({super.key, required this.language});

  @override
  State<NumberDisplay> createState() => _NumberDisplayState();
}

class _NumberDisplayState extends State<NumberDisplay> {
  bool setLanguage = false;

  final List<String> numbers = [
    'zero',
    'one',
    'two',
    'three',
    'four',
    'five',
    'six',
    'seven',
    'eight',
    'nine'
  ];

  final FlutterTts flutterTts = FlutterTts();

  Future<void> pauseFluttertts() async {
    await flutterTts.pause();
  }

  @override
  void dispose() {
    pauseFluttertts();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5, // 10 columns
        ),
        itemCount: 100, // Total numbers from 1 to 100
        itemBuilder: (BuildContext context, int index) {
          int number = index + 1;
          return GestureDetector(
            onTap: () {
              _speakNumber(number);
            },
            child: _buildNumberImage(number, index),
          );
        },
      ),
    );
  }

  Widget _buildNumberImage(int number, int index) {
    // Split the number into individual digits
    List<int> digits = number.toString().split('').map(int.parse).toList();

    // Create a row to display the digits as images
    return Container(
      color: Colors.blueGrey,
      margin: const EdgeInsets.all(3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i < digits.length; i++)
            if (i == 0)
              _buildDigitImage(digits[i])
            else if (i == 1)
              //_buildDigitImage(digits[i]),
              Transform.translate(
                  offset: const Offset(-30.0, -0.0),
                  child: _buildDigitImage(digits[i]))
            else if (i == 2)
              Transform.translate(
                  offset: const Offset(-60.0, -0.0),
                  child: _buildDigitImage(digits[i]))
        ],
      ),
    );
  }

  Widget _buildDigitImage(int digit) {
    // Replace 'number_$digit.png' with the actual filename of your digit images
    return Image.asset(
      'assets/images/${numbers[digit]}.png',
      height: 70, // Adjust height as needed
      width: 70, // Adjust width as needed
    );
  }

  void _speakNumber(int number) async {
    if (setLanguage == false) {
      if (widget.language == "en") {
        await flutterTts.setLanguage('en-IN');
        await flutterTts.setSpeechRate(0.5);
        await flutterTts.setPitch(1.0);
        setLanguage = true;
      } else {
        await flutterTts.setLanguage('hi-IN');
        await flutterTts.setSpeechRate(0.5);
        await flutterTts.setPitch(1.0);
        setLanguage = true;
      }
    }

    await flutterTts.speak(number.toString());
  }
}
