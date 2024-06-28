import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/services.dart';
import 'package:junior_journey/screen/tables_main.dart';

class Tables extends StatelessWidget {
  final String index;
  final String language;
  const Tables({required this.index, required this.language, super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiplicationTable(
        index: index,
        language: language,
      ),
    );
  }
}

class MultiplicationTable extends StatefulWidget {
  final String index;
  final String language;
  const MultiplicationTable(
      {super.key, required this.index, required this.language});
  @override
  MultiplicationTableState createState() =>
      MultiplicationTableState(index: index, language: language);
}

class MultiplicationTableState extends State<MultiplicationTable> {
  final String index;
  final String language;
  MultiplicationTableState({required this.index, required this.language});
  final FlutterTts flutterTts = FlutterTts();
  int currentNumber = 1;
  bool setLanguage = false;
  late List<String> tabIndex;

  @override
  void initState() {
    super.initState();
    // Speak the first multiplication result when the widget is initialized
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    setState(() {
      if (language == "en") {
        tabIndex = [
          'zero',
          'onza',
          'twuza',
          'threeza',
          'fourza',
          'fivza',
          'sixza',
          'sevenza',
          'eightza',
          'ninza',
          'tenza'
        ];
      } else {
        tabIndex = [
          'शून्य',
          'एक्कम',
          'डुनी',
          'तियाई',
          'चौके',
          'पंजे',
          'छक्के',
          'सत्ते',
          'अट्ठे',
          'नवा',
          'दाहम'
        ];
      }
    });
    _speakNumber((int.parse(index) * currentNumber), index);
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
                            builder: (context) =>
                                TablesMain(language: language)),
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
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$index x $currentNumber = ${int.parse(index) * currentNumber}',
                    style: const TextStyle(
                        fontSize: 80,
                        color: Colors.greenAccent,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent,
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontStyle: FontStyle.normal),
                    ),
                    onPressed: () {
                      setState(() {
                        if (currentNumber < 10) {
                          currentNumber++;
                        } else {
                          currentNumber = 1;
                        }
                      });
                      _speakNumber((int.parse(index) * currentNumber), index);
                    },
                    child: const Text('Next'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _speakNumber(int total, String index) async {
    if (setLanguage == false) {
      if (language == "en") {
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

    if (currentNumber < 11) {
      await flutterTts.speak('$index ${tabIndex[currentNumber]} $total');
    } else {
      currentNumber = 1;
      _speakNumber((int.parse(index) * currentNumber), index);
    }
  }
}