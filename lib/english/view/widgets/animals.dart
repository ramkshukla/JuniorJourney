import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/services.dart';
import 'package:junior_journey/english/view/english_alphabet.dart';

class AnimaleSlider extends StatefulWidget {
  const AnimaleSlider({super.key});

  @override
  VegetableSliderState createState() => VegetableSliderState();
}

class VegetableSliderState extends State<AnimaleSlider> {
  FlutterTts flutterTts = FlutterTts();
  final PageController _pageController = PageController();
  int currentIndex = 0;
  List<String> vegetables = [
    "Cow",
    "Cat",
    'Dog',
    'Horse',
    'Monkey',
    'Lion',
    'Buffalo',
    'Gorilla',
    'Sheep',
    'Snake',
    'Scorpion',
    'Jackal',
    'Kangaroo',
    'Fox',
    'Deer',
    'Crocodile'
  ];

  @override
  void initState() {
    super.initState();
    _speak();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  Future _speak() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(vegetables[currentIndex]);
  }

  void _nextVegetable() {
    if (currentIndex < vegetables.length - 1) {
      setState(() {
        currentIndex++;
      });
      _speak();
    }
  }

  Future<void> pauseFluttertts() async {
    await flutterTts.pause();
  }

  void _previousVegetable() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
      _speak();
    }
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
                'assets/images2/forest_bg.jpg'), // Background image path
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
                            builder: (context) => const EnglishAlphabet()),
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
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: vegetables.length,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                    _speak();
                  });
                },
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Image.asset(
                        'assets/images2/${vegetables[currentIndex]}.png',
                        height: 200,
                      ),
                      Text(
                        vegetables[currentIndex],
                        style: const TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'RobotoMono',
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: _previousVegetable,
                  child: const Icon(Icons.arrow_back),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        vegetables.length,
                        (index) => GestureDetector(
                          onTap: () {
                            setState(() {
                              currentIndex = index;
                              _pageController.animateToPage(
                                index,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                              _speak();
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: currentIndex == index
                                  ? Colors.blue
                                  : Colors.grey.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              "${index + 1}",
                              style: TextStyle(
                                color: currentIndex == index
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _nextVegetable,
                  child: const Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
