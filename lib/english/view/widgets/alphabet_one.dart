import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:junior_journey/english/view/english_alphabet.dart';

class AlphabetOne extends StatefulWidget {
  const AlphabetOne({super.key});

  @override
  AlphabetOneState createState() => AlphabetOneState();
}

class AlphabetOneState extends State<AlphabetOne> {
  final FlutterTts flutterTts = FlutterTts();

  List<bool> isAlphabetColored = List.generate(26, (index) => false);

  @override
  void dispose() {
    pauseFluttertts();
    super.dispose();
  }

  Future<void> pauseFluttertts() async {
    await flutterTts.pause();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/green_background.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 10,
              left: -15,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EnglishAlphabet(),
                    ),
                  );
                },
                child: Image.asset(
                  'assets/images/back_btn.png',
                  height: 50,
                  width: 120,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 20, top: 10),
              child: Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                      ),
                      itemCount: 26,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            _speakAlphabet(
                              String.fromCharCode(index + 65),
                            );
                          },
                          child: CustomPaint(
                            painter: AlphabetPainter(
                              alphabet: String.fromCharCode(
                                  index + 65), // A-Z alphabets
                              isColored: isAlphabetColored[index],
                            ),
                            child: Center(
                              child: Image.asset(
                                'assets/images/${String.fromCharCode(index + 65)}.png', // Load alphabet image hint
                                width: 140,
                                height: 140,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  // Method to pronounce the alphabet letter
  Future<void> _speakAlphabet(String letter) async {
    await flutterTts.speak(letter);
  }
}

class AlphabetPainter extends CustomPainter {
  final String alphabet;
  final bool isColored;

  AlphabetPainter({required this.alphabet, required this.isColored});

  @override
  void paint(Canvas canvas, Size size) {
    Paint()
      ..color = isColored ? Colors.blue : Colors.white
      ..style = PaintingStyle.fill;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
