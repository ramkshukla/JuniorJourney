import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:junior_journey/screen/alphabet_main.dart';

class AlphabetOne extends StatelessWidget {
  const AlphabetOne({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DrawingPage(),
    );
  }
}

class DrawingPage extends StatefulWidget {
  const DrawingPage({super.key});

  @override
  _DrawingPageState createState() => _DrawingPageState();
}

class _DrawingPageState extends State<DrawingPage> {
  final FlutterTts flutterTts = FlutterTts(); // TTS plugin instance
  List<bool> isAlphabetColored =
      List.generate(26, (index) => false); // Track colored alphabets

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/green_background.jpg'), // Background image path
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            //   Back labelLarge
            Positioned(
              top: 10, // Adjust the top position as needed
              left: -15, // Adjust the left position as needed
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AlphabetMain()),
                  );

                  // Handle back labelLarge tap
                },
                child: Container(
                  child: Image.asset(
                    'assets/images/back_btn.png',
                    height: 50,
                    width: 120,
                  ),
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
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
