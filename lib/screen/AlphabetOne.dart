import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:junior_journey/screen/alphabet_main.dart';

class AlphabetOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DrawingPage(),
    );
  }
}

class DrawingPage extends StatefulWidget {
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
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/green_background.jpg'), // Background image path
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            //   Back button
            Positioned(
              top: 10, // Adjust the top position as needed
              left: -15, // Adjust the left position as needed
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AlphabetMain()),
                  );

                  // Handle back button tap
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
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 20, top: 10),
              child: Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                      ),
                      itemCount: 26,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            _speakAlphabet(
                              String.fromCharCode(index + 65),
                            ); // Pronounce letter name
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
    Paint paint = Paint()
      ..color = isColored
          ? Colors.blue
          : Colors.white // Color alphabet based on state
      ..style = PaintingStyle.fill;

    // Draw alphabet shape here using canvas.drawPath or other methods
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
