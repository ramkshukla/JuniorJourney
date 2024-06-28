import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/services.dart';
import 'package:junior_journey/screen/multiplication.dart';
import 'package:junior_journey/screen/next_and_back_bnt.dart';

class Devision extends StatelessWidget {
  const Devision({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: RabbitCountScreen(),
      ),
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
  final GlobalKey columnKey = GlobalKey();

  int mangoes = 4;
  int _currentIndex = 0;
  late AnimationController _controller;
  late Animation<double> animation;
  late FlutterTts flutterTts;
  bool isSpeaking = false;
  late List<String> texts1;
  List<String> texts3 = [
    "Division is a way of sharing or grouping things equally. Imagine you have a bunch of mangoes and you want to share them with your friends. If you have 4 mangoes and 2 friends, you can give each friend 2 mangoes. So, 4 divided by 2 equals 2. That's division!."
    // "Instead of adding like this, you can use multiplication.",
    // "So, 3 (rabbits in each group) times 3 (number of groups) equals 9. So, you have 9 rabbits in total! "
  ];
  List<String> texts4 = [
    " If you have a six mangoes and you want to share them with your three friends. You can give each friend 2 mangoes. So, 6 divided by 3 equals 2 "
  ];
  List<String> texts5 = [
    "If you have a eight mangoes and you want to share them with your 2 friends. You can give each friend 4 mangoes. So, 8 divided by 2 equals 4 "
  ];
  List<String> texts6 = [
    "If you have a 10 mangoes and you want to share them with your 2 friends. You can give each friend 5 mangoes. So, 10 divided by 2 equals 5 "
  ];
  late String showText;
  List<String> showTexts = [
    "4 ÷ 2 = 2",
    "6 ÷ 3 = 2 ",
    "8 ÷ 2 = 4",
    "10 ÷ 2 = 5"
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

  @override
  void dispose() {
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
              for (int i = 1; i <= mangoes / 2; i++)
                Image.asset('assets/images1/aa1.png', width: 90, height: 90),
            ],
          ),
        ),
        const SizedBox(height: 5),

        // Second Row of Images
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 1; i <= mangoes / 2; i++)
              Image.asset('assets/images1/aa1.png', width: 90, height: 90)
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
        mangoes = mangoes + 2;
        if (mangoes == 6) {
          texts1 = texts4;
          showText = showTexts[1];
          stop();

          speakTexts();
        } else if (mangoes == 8) {
          texts1 = texts5;
          showText = showTexts[2];
          stop();
          speakTexts();
        } else if (mangoes == 10) {
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
        mangoes = mangoes - 2;
        if (mangoes == 4) {
          texts1 = texts3;
          showText = showTexts[0];
          stop();
          speakTexts();
        } else if (mangoes == 6) {
          texts1 = texts4;
          showText = showTexts[1];
          stop();
          speakTexts();
        } else if (mangoes == 8) {
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
}
