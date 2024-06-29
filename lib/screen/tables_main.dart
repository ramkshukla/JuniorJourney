import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:junior_journey/screen/tables.dart';

class TablesMain extends StatelessWidget {
  final String language;
  const TablesMain({required this.language, super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TablesMainScreen(
        language: language,
      ),
    );
  }
}

class TablesMainScreen extends StatelessWidget {
  final String language;
  TablesMainScreen({super.key, required this.language});
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5, // 10 columns
          ),
          itemCount: 19, // Total numbers from 1 to 100
          itemBuilder: (BuildContext context, int index) {
            int number = index + 2;
            return Container(
              child: GestureDetector(
                onTap: () {
                  // _speakNumber(number);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Tables(
                              index: number.toString(),
                              language: language,
                            )),
                  );
                },
                child: _buildNumberImage(number),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildNumberImage(int number) {
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
            if (i == 0) // Special case for digit 0 following digit 1
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
    await flutterTts.speak(number.toString());
  }
}
