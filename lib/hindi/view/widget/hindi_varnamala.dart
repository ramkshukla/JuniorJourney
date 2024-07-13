import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/services.dart';
import 'package:junior_journey/hindi/view/hindi_main.dart';

class HindiVarnamala extends StatefulWidget {
  const HindiVarnamala({super.key});

  @override
  HindiVarnamalaState createState() => HindiVarnamalaState();
}

class HindiVarnamalaState extends State<HindiVarnamala> {
  FlutterTts flutterTts = FlutterTts();
  List<String> letters = [
    'zero',
    'ka',
    'ka1',
    'kha',
    'kha1',
    'ga',
    'ga1',
    'gha',
    'gha1',
    'anga',
    'pd1',
    'cha',
    'cha1',
    'chha',
    'chha1',
    'ja',
    'ja1',
    'jha',
    'jha1',
    'nia',
    'pd1',
    'taa',
    'taa1',
    'thaa',
    'thaa1',
    'da',
    'da1',
    'dhaa',
    'dhaa1',
    'ana',
    'pd1',
    'ta',
    'ta1',
    'tha',
    'tha1',
    'daa',
    'daa1',
    'dha',
    'dha1',
    'na',
    'na1',
    'pa',
    'pa1',
    'pha',
    'pha1',
    'ba',
    'ba1',
    'bha',
    'bha1',
    'ma',
    'ma1',
    'ya',
    'ya1',
    'ra',
    'ra1',
    'la',
    'la1',
    'vaa',
    'va1',
    'sha',
    'sha1',
    'shaa',
    'shaa1',
    'sa',
    'sa1',
    'ha',
    'ha1',
    'ksha',
    'ksha1',
    'traa',
    'tra1',
    'gya',
    'gya1'
  ];
  List<String> objects = [
    'zero',
    'कबूतर',
    'खरगोश',
    'गमला',
    'घड़ी',
    'कुछ नहीं',
    'चम्मच',
    'छाता',
    'जहाज',
    'झंडा',
    'कुछ नहीं',
    'टमाटर',
    'ठहरो',
    'डमरू',
    'ढक्कन',
    'कुछ नहीं',
    'तरबूज',
    'थरमस',
    'दवात',
    'धनुष',
    'नल',
    'पतंग',
    'फल',
    'बकरी',
    'भालू',
    'मछली',
    'यज्ञ',
    'रथ',
    'लड़का',
    'वकील',
    'शलजम',
    'षट्कोण',
    'सपेरा',
    'हाथी',
    'क्षत्रिय',
    'त्रिशूल',
    'ज्ञानी'
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
    speak(letters[currentIndex]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

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
      body: Container(
        decoration: const BoxDecoration(
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
                        MaterialPageRoute(
                            builder: (context) => const HindiMain()),
                      );

                      // Handle back labelLarge tap
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
                        padding: const EdgeInsets.only(right: 70),
                        child: ElevatedButton(
                          onPressed: onBackPressed,
                          child: const Text('Back'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 70),
                        child: ElevatedButton(
                          onPressed: onNextPressed,
                          child: const Text('Next'),
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
              '${letters[currentIndex - 1]}  से ${objects[currentIndex ~/ 2]}');
        } else {
          height = 200;
          width = 150;
          speak(letters[currentIndex]);
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
