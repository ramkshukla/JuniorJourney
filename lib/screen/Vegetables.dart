import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/services.dart';
import 'package:junior_journey/screen/alphabet_main.dart';

class VegetableSlider extends StatefulWidget {
  const VegetableSlider({super.key});

  @override
  _VegetableSliderState createState() => _VegetableSliderState();
}

class _VegetableSliderState extends State<VegetableSlider> {
  FlutterTts flutterTts = FlutterTts();
  PageController _pageController = PageController();
  int currentIndex = 0;
  List<String> vegetables = [
    "Carrot",
    "Onion",
    'Capsicum',
    'Cauliflower',
    'Chill Pepper',
    'Ladyfinger',
    'Bottle Gourd',
    'Ginger',
    'Green Peas',
    'Eggplant',
    'Pumpkin'
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
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.9),
            image: DecorationImage(
              image: AssetImage(
                  'assets/images2/vege_bg.jpg'), // Background image path
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
                              builder: (context) => AlphabetMain()),
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
                    return Container(
                      child: Builder(builder: (context) {
                        return Column(
                          children: [
                            Image.asset(
                              'assets/images2/${vegetables[currentIndex]}.png',
                              height: 200,
                            ),
                            Text(
                              '${vegetables[currentIndex]}',
                              style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'RobotoMono',
                              ),
                            )
                          ],
                        );
                      }),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: _previousVegetable,
                    child: Icon(Icons.arrow_back),
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
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                );
                                _speak();
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.all(8),
                              padding: EdgeInsets.symmetric(
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
                    child: Icon(Icons.arrow_forward),
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
