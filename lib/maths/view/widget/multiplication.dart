import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/services.dart';
import 'package:junior_journey/data/next_and_back_bnt.dart';

class Multiplication extends StatelessWidget {
  const Multiplication({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: RabbitCountScreen(),
    );
  }
}

class RabbitCountScreen extends StatefulWidget {
  const RabbitCountScreen({super.key});

  @override
  RabbitCountScreenState createState() => RabbitCountScreenState();
}

class RabbitCountScreenState extends State<RabbitCountScreen>
    with TickerProviderStateMixin {
  final GlobalKey _columnKey = GlobalKey();
  bool _isVisibleFourth = false;
  bool _isVisibleFive = false;
  bool _isVisibleSix = false;
  int group = 3;
  int _currentIndex = 0;
  late AnimationController _controller;
  late Animation<double> animation;
  late FlutterTts flutterTts;
  bool isSpeaking = false;
  List<String> texts = [
    "Multiplication is like adding numbers, but it's a special kind of adding. It helps us when we have groups of things. Imagine you have 4 groups of rabbits, just like before. And in each group, there are 3 rabbits. Now, if you want to know how many rabbits there are in total without counting one by one, you can use multiplication!",
    "Here's how it works: You know that there are 3 rabbits in each group, and you have 4 groups in total. So, you can think of it as adding 3 four times.So, 3 (rabbits in one group) + 3 (rabbits in the second group) + 3 (rabbits in the third group) + 3 (rabbits in the fourth group) equal to 12 rabbits.",
    "Instead of adding like this, you can use multiplication. Multiplication helps us add groups of numbers quickly! So, 3 (rabbits in each group) times 4 (number of groups) equals 12. So, you have 12 rabbits in total! That's how multiplication works. It helps us when we have groups of things that are the same, so we don't have to count them one by one."
  ];
  late List<String> texts1;
  List<String> texts3 = [
    "3 (rabbits in one group) + 3 (rabbits in the second group) + 3 (rabbits in the third group)   equal to 9.",
    "Instead of adding like this, you can use multiplication.",
    "So, 3 (rabbits in each group) times 3 (number of groups) equals 9. So, you have 9 rabbits in total! "
  ];
  List<String> texts4 = [
    "3 (rabbits in each group) times 4 (number of groups) equals 12. So, you have 12 rabbits in total! "
  ];
  List<String> texts5 = [
    "3 (rabbits in each group) times 5 (number of groups) equals 15. So, you have 15 rabbits in total! "
  ];
  List<String> texts6 = [
    "3 (rabbits in each group) times 6 (number of groups) equals 18. So, you have 18 rabbits in total! "
  ];
  late String showText;
  List<String> showTexts = [
    "3 + 3 + 3 = 9\n 3 x 3 = 9 ",
    "3 + 3 + 3 + 3 = 12\n 3 x 4 = 12 ",
    "3 + 3 + 3 + 3 + 3 = 15\n 3 x 5 = 15 ",
    "3 + 3 + 3 + 3 + 3 + 3  = 18\n 3 x 6 = 18 "
  ];
  Key _textKey = UniqueKey();
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    super.initState();
    texts1 = texts3;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 0),
    );

    animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    flutterTts = FlutterTts();
    flutterTts.setLanguage('en-IN');
    flutterTts.setSpeechRate(0.5);
    flutterTts.setPitch(1.0);

    _controller.addListener(() {
      if (_controller.value == 1) {
        speakTexts();
      }
    });

    _controller.forward();
  }

  Future<void> speakTexts() async {
    for (String text in texts1) {
      await speakText(text);
      await Future.delayed(const Duration(seconds: 2));
    }
  }

  Future<void> speakText(String text) async {
    setState(() {
      isSpeaking = true;
    });
    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.speak(text);
  }

  Future<void> stop() async {
    if (isSpeaking) {
      await flutterTts.stop();
    }
  }

  Future<void> initTts() async {
    flutterTts.setCompletionHandler(() {
      setState(() {
        isSpeaking = false;
      });
    });
    flutterTts.setCancelHandler(() {
      setState(() {
        isSpeaking = false;
      });
    });
  }

  Future<void> pauseFluttertts() async {
    await flutterTts.pause();
  }

  @override
  void dispose() {
    pauseFluttertts();
    _controller.dispose();
    stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              'assets/images/green_board.jpg'), // Background image path
          fit: BoxFit.cover,
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        // First Row of Images
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Column(
                  children: [
                    Image.asset('assets/images/three_rabbits_group.png',
                        width: 90, height: 90),
                  ],
                ),
              ),
              Visibility(
                key: _columnKey,
                visible: _isVisibleFourth,
                child: Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Column(
                    children: [
                      Image.asset('assets/images/three_rabbits_group.png',
                          width: 90, height: 90),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: _isVisibleSix,
                child: Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Column(
                    children: [
                      Image.asset('assets/images/three_rabbits_group.png',
                          width: 90, height: 90),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),

        // Second Row of Images
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Image.asset('assets/images/three_rabbits_group.png',
                      width: 90, height: 90),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Image.asset('assets/images/three_rabbits_group.png',
                      width: 90, height: 90),
                ],
              ),
            ),
            Visibility(
              visible: _isVisibleFive,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    Image.asset('assets/images/three_rabbits_group.png',
                        width: 90, height: 90),
                  ],
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 5),

        // Third Row with Typewriter Animated Text
        WidgetShowText(
          key: _textKey, // Pass the key to WidgetShowText
          showText: showTexts[_currentIndex],
        ),
        //code for next and back labelLarge
        NextAndBackBtn(nextFunction: nextFunction, backFunction: backFunction)
      ]),
    );
  }

  void nextFunction() {
    setState(() {
      if (_currentIndex < showTexts.length - 1) {
        group = group + 1;
        if (group == 4) {
          _isVisibleFourth = true;
          texts1 = texts4;
          showText = showTexts[1];
          stop();

          speakTexts();
        } else if (group == 5) {
          _isVisibleFive = true;
          texts1 = texts5;
          showText = showTexts[2];
          stop();
          speakTexts();
        } else if (group == 6) {
          _isVisibleSix = true;
          texts1 = texts6;
          showText = showTexts[3];
          stop();
          speakTexts();
        }
        _currentIndex = (_currentIndex + 1) % showText.length;
        _textKey = UniqueKey(); // Change the key to rebuild WidgetShowText
      }
    });
  }

  void backFunction() {
    setState(() {
      if (_currentIndex > 0) {
        group = group - 1;
        if (group == 3) {
          _isVisibleFourth = false;
          texts1 = texts3;
          showText = showTexts[0];
          stop();
          speakTexts();
        } else if (group == 4) {
          _isVisibleFive = false;
          texts1 = texts4;
          showText = showTexts[1];
          stop();
          speakTexts();
        } else if (group == 5) {
          _isVisibleSix = false;
          texts1 = texts5;
          showText = showTexts[2];
          stop();
          speakTexts();
        }
        _currentIndex = (_currentIndex - 1) % showTexts.length;
        _textKey = UniqueKey(); // Change the key to rebuild WidgetShowText
      }
    });
  }

  // void _nextText() {
  //   setState(() {
  //     _currentIndex = (_currentIndex + 1) % showTexts.length;
  //   });
  // }
}

class WidgetShowText extends StatelessWidget {
  final String showText;

  const WidgetShowText({Key? key, required this.showText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400.0,
      child: DefaultTextStyle(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 30.0,
          fontFamily: 'Agne',
        ),
        child: Center(
          child: AnimatedTextKit(
            totalRepeatCount: 1,
            animatedTexts: [
              TypewriterAnimatedText(
                showText,
                speed: const Duration(milliseconds: 80),
              ),
            ],
            onTap: () {},
          ),
        ),
      ),
    );
  }
}
