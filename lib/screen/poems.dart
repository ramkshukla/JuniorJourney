import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/services.dart';
import 'package:junior_journey/screen/poems_main.dart';

class Poems extends StatelessWidget {
  final int index;
  Poems({required this.index});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TtsPage(index: index),
    );
  }
}

class TtsPage extends StatefulWidget {
  final int index;
  TtsPage({required this.index});
  @override
  _TtsPageState createState() => _TtsPageState(index: index);
}

class _TtsPageState extends State<TtsPage> {
  final int index;
  _TtsPageState({required this.index});
  late String background;
  late String poem;
  bool text_visibility = true;
  final List<String> poems = [
    "Twinkle, twinkle, little star.\n How I wonder what you are.\n Up above the world so high.\n Like a diamond in the sky.\n Twinkle, twinkle, little star.\n How I wonder what you are.\n",
    "Rain, rain, go away,\n Come again another day.\n Little Alex wants to play,\n rain, rain, go away.\n",
    "A squirrel named Billy \n Loved to dance on the hilly.\n  He'd twirl and spin, oh so silly,\n  Chasing his tail, willy-nilly!",
    "After the rain, oh so quick,\n A rainbow appears, colorful and thick.\n Red, orange, yellow, green, and blue, \n A magical bridge for me and you!",
    "In the pond, a frog named Fred,\n Hopped around on a lily pad.\n His croak was loud, his leap was high,\n Making everyone laugh as he passed by.",
    "Buzz, buzz, little bee,\n Collecting nectar from flower to tree.\n With striped wings and a fuzzy coat,\n You work so hard, never missing a note."
  ];

  final FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    setState(() {
      if (index == 1) {
        poem = poems[0];
        background = 'poem_one_bg';
        text_visibility = true;
      } else if (index == 2) {
        poem = poems[1];
        background = 'poem_two_bg';
        text_visibility = true;
      } else if (index == 3) {
        poem = poems[2];
        background = 'poem_three_bg';
        text_visibility = false;
      } else if (index == 4) {
        poem = poems[3];
        background = 'poem_four_bg';
        text_visibility = false;
      } else if (index == 5) {
        poem = poems[4];
        background = 'poem_five_bg';
        text_visibility = false;
      } else if (index == 6) {
        poem = poems[5];
        background = 'poem_six_bg';
        text_visibility = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images2/${background}.jpg'), // Background image path
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
                        MaterialPageRoute(builder: (context) => PoemsMain()),
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
            Align(
              alignment: Alignment.bottomRight,
              child: Column(
                children: [
                  Visibility(
                    visible: text_visibility,
                    child: Text(
                      poem,
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20, right: 50),
                  child: ElevatedButton(
                    onPressed: _speak,
                    child: Text('Speak'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> initTts() async {
    await flutterTts.setLanguage('en-IN');
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.4);
  }

  Future<void> _speak() async {
    await flutterTts.speak(poem);
  }
}
