import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/services.dart';
import 'package:junior_journey/screen/HindiMain.dart';

class HindiVowel extends StatelessWidget {
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
    'chhota aa',
    'a1',
    'bada aa',
    'aa1',
    'chhoti ee',
    'i1',
    'badi ee',
    'ee1',
    'chhota uuu',
    'u1',
    'bada uuu',
    'oo1',
    'ri',
    'ri1',
    'ye',
    'e1',
    'ai',
    'ai1',
    'o',
    'o1',
    'au',
    'au1',
    'an',
    'an1',
    'ah',
    'pd1'
  ];
  List<String> objects = [
    'zero',
    'अनार',
    'आम',
    'इमली',
    'ईख ',
    'उल्लू',
    'ऊन',
    'ऋषि',
    'एड़ी',
    'ऐनक',
    'ओखली',
    'औरत',
    'अंगूर',
    'कुछ नहीं'
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
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HindiMain()),
                      );

                      // Handle back button tap
                    },
                    child: Image.asset(
                      'assets/images/back_btn.png',
                      height: 50,
                      width: 100,
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images1/${letters[currentIndex]}.png',
                    height: height,
                    width: width,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 70),
                        child: ElevatedButton(
                          onPressed: onBackPressed,
                          child: Text('Back'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 70),
                        child: ElevatedButton(
                          onPressed: onNextPressed,
                          child: Text('Next'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onNextPressed() {
    setState(() {
      if (currentIndex < letters.length - 1) {
        currentIndex++;
        // speak('से ${objects[currentIndex]}');
        if (currentIndex % 2 == 0) {
          updateSize(height + 50, width + 50);
          speak(
              '${letters[currentIndex - 1]}  से ${objects[(currentIndex / 2).toInt()]}');
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
