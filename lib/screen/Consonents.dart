import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/services.dart';
import 'package:junior_journey/screen/alphabet_main.dart';

class Consonents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FlutterTts flutterTts = FlutterTts();
  List<String> letters = [
    'zero',
    'K',
    'ka',
    'KH',
    'kha',
    'G',
    'ga',
    'GH',
    'gha',
    'NG',
    'anga',
    'CH',
    'cha',
    'CHH',
    'chha',
    'J',
    'ja',
    'JH',
    'jha',
    'YN',
    'nia',
    'T',
    'taa',
    'TH',
    'thaa',
    'D',
    'da',
    'DH',
    'dhaa',
    'N',
    'ana',
    'T',
    'ta',
    'TH',
    'tha',
    'D',
    'daa',
    'DH',
    'dha',
    'N',
    'na',
    'P',
    'pa',
    'PH',
    'pha',
    'B',
    'ba',
    'BH',
    'bha',
    'M',
    'ma',
    'Y',
    'ya',
    'R',
    'ra',
    'L',
    'la',
    'V',
    'vaa',
    'SH',
    'sha',
    'SH',
    'shaa',
    'S',
    'sa',
    'H',
    'ha',
    'KSH',
    'ksha',
    'TR',
    'traa',
    'GY',
    'gya'
  ];

  int currentIndex = 1;
  double height = 200; // Initial height
  double width = 150; // Initial width
  Future<void> speak(String text) async {
    await flutterTts.setLanguage('hi-IN');
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
  }

  @override
  void initState() {
    super.initState();
    speak('${letters[currentIndex]}');
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/green_board.jpg'), // Background image path
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Stack(
            children: [
              Positioned(
                top: 5, // Adjust the top position as needed
                left: 2, // Adjust the left position as needed
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AlphabetMain()),
                    );

                    // Handle back button tap
                  },
                  child: Image.asset(
                    'assets/images/back_btn.png',
                    height: 50,
                    width: 100,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  currentIndex % 2 != 0
                      ? buildAlphabetImage(letters[currentIndex])
                      : _buildDigitImage(letters[currentIndex], 'images1'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 70, top: 50),
                        child: ElevatedButton(
                          onPressed: onBackPressed,
                          child: Text('Back'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 70, top: 50),
                        child: ElevatedButton(
                          onPressed: onNextPressed,
                          child: Text('Next'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAlphabetImage(String letter) {
    // Split the number into individual digits
    List<String> digits = letter.split('');

    // Create a row to display the digits as images
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < digits.length; i++)
          if (i == 0) // Special case for digit 0 following digit 1
            _buildDigitImage(digits[i], 'images')
          else if (i == 1)
            //_buildDigitImage(digits[i]),
            Transform.translate(
                offset: Offset(-20.0, -0.0),
                child: _buildDigitImage(digits[i], 'images'))
          else if (i == 2)
            Transform.translate(
                offset: Offset(-40.0, -0.0),
                child: _buildDigitImage(digits[i], 'images'))
      ],
    );
  }

  Widget _buildDigitImage(String digit, String folder) {
    // Replace 'number_$digit.png' with the actual filename of your digit images
    return Image.asset(
      'assets/${folder}/${digit}.png',
      height: 150, // Adjust height as needed
      width: 150, // Adjust width as needed
    );
  }

  void onNextPressed() {
    setState(() {
      if (currentIndex < letters.length - 1) {
        currentIndex++;
        // speak('से ${objects[currentIndex]}');
        if (currentIndex % 2 == 0) {
          updateSize(height + 50, width + 50);
          speak('${letters[currentIndex - 1]}  से ${letters[currentIndex]}');
        } else {
          height = 200;
          width = 150;
          speak('${letters[currentIndex]}');
        }
      } else {
        currentIndex = 1;
      }
    });
  }

  void onBackPressed() {
    setState(() {
      if (currentIndex > 1) {
        if (currentIndex % 2 == 0) {
          currentIndex = currentIndex - 1;
        } else {
          currentIndex = currentIndex - 2;
        }
      }
    });
  }

  void updateSize(double newHeight, double newWidth) {
    setState(() {
      height = newHeight;
      width = newWidth;
    });
  }
}
