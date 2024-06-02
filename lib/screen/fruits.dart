import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/services.dart';
import 'package:junior_journey/screen/alphabet_main.dart';

class FruitSlider extends StatefulWidget {
  @override
  _FruitSliderState createState() => _FruitSliderState();
}

class _FruitSliderState extends State<FruitSlider> {
  FlutterTts flutterTts = FlutterTts();
  PageController _pageController = PageController();
  int currentIndex = 0;
  List<String> vegetables = [
    'Apple',
    'Banana',
    'Orange',
    'Grape',
    'Pineapple',
    'Mango',
    'Strawberry',
    'Watermelon',
    'Kiwi',
    'Blueberry'
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
            image: DecorationImage(
              image: AssetImage(
                  'assets/images2/fruits_bg.jpg'), // Background image path
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

                        // Handle back button tap
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Image.asset(
                          'assets/images/back_btn.png',
                          height: 50,
                          width: 120,
                        ),
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
                      child: Column(
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
