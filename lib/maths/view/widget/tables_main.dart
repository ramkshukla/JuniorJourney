import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:junior_journey/screen/tables.dart';

class TablesMain extends StatelessWidget {
  final String language;
  const TablesMain({required this.language, super.key});
  @override
  Widget build(BuildContext context) {
    return TablesMainScreen(
      language: language,
    );
  }
}

class TablesMainScreen extends StatefulWidget {
  final String language;
  const TablesMainScreen({super.key, required this.language});

  @override
  State<TablesMainScreen> createState() => _TablesMainScreenState();
}

class _TablesMainScreenState extends State<TablesMainScreen> {
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
        itemCount: 19, // Total numbers from 1 to 100
        itemBuilder: (BuildContext context, int index) {
          int number = index + 2;
          return GestureDetector(
            onTap: () {
              // _speakNumber(number);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MultiplicationTable(
                          index: number.toString(),
                          language: widget.language,
                        )),
              );
            },
            child: _buildNumberImage(number),
          );
        },
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
}
