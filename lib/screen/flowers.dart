import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/services.dart';
import 'package:junior_journey/screen/alphabet_main.dart';

class FlowersSlider extends StatefulWidget {
  const FlowersSlider({super.key});

  @override
  _FruitSliderState createState() => _FruitSliderState();
}

class _FruitSliderState extends State<FlowersSlider> {
  FlutterTts flutterTts = FlutterTts();
  final PageController _pageController = PageController();
  int currentIndex = 0;
  List<String> flowers = [
    'Rose',
    'Sunflower',
    'Lily',
    'Daisy',
    'Orchid',
    'Jasmine',
    'Lotus',
    'Gulmohar',
    'Marigold',
    'Hibiscus'
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
    await flutterTts.speak(flowers[currentIndex]);
  }

  void _nextVegetable() {
    if (currentIndex < flowers.length - 1) {
      setState(() {
        currentIndex++;
      });
      _speak();
    }
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
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/images2/flowers_bg.jpg'), // Background image path
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
                              builder: (context) => const AlphabetMain()),
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
                  itemCount: flowers.length,
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                      _speak();
                    });
                  },
                  itemBuilder: (context, index) {
                    return Container(
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images2/${flowers[currentIndex]}.png',
                            height: 200,
                          ),
                          Text(
                            flowers[currentIndex],
                            style: const TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'RobotoMono',
                            ),
                          )
                        ],
                      ),
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
                          flowers.length,
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
      ),
    );
  }
}
