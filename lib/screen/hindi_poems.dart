import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/services.dart';
import 'package:junior_journey/screen/hindi_poems_main.dart';

class HindiPoems extends StatelessWidget {
  final int index;
  HindiPoems({required this.index});
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
  final List<String> poems = [
    "चले सैर को मोटूराम,देखा एक लटकता आम । झटपट चढ़ने लगे पेड़ पर, लगा ततैया, गिरे धड़ाम ।।",
    "सोने की चिड़िया, सोने के पर,चिड़िया उड़ गई, फर्र-फर्र-फर्र । मोती का दाना लाई चिड़िया,मेरी गोद में आई चिड़िया । हम दोनों मिलकर गाएँगें, नील गगन में उड़ जाएँगे।",
    "एक कौआ था । उसे बहुत प्यास लगी थी। उसने देखा कि वहाँ एक घड़ा है। उस घड़े में थोड़ा सा पानी है। ज़मीन पर आस-पास कंकड़ पड़े थे। कौए को तरकीब सूझी। उसने एक कंकड़ उठाकर घड़े में डाला। इसी तरह वह कंकड़ उठाकर घड़े में डालता गया। पानी ऊपर आ गया। कौए ने पानी पीया और वह उड़ गया।",
    "मटक-मटककर पूँछ हिलाती, आसमान में उड़ी पतंग। खुली हवा में लहराती,उड़-उड़कर चली पतंग | इसको काटे, उसको काटे पेंच लड़ाती चली पतंग। मचल-मचल कर इठलाती,पूँछ हिलाती चली पतंग।",
    "सभी फलों में न्यारा सेब, लाल-लाल सा प्यारा सेब | एक सेब जो हर दिन खाता, डॉक्टर को वह दूर भगाता । मम्मी मुझको सेब दिला दो,या फिर एप्पल जूस पिला दो ।।",
    "देखो एक डाकिया आया, थैला एक हाथ में लाया । चिट्ठी कई हाथ में पकड़े, पहने है वह खाकी कपड़े । बाँट रहा घर घर में चिट्ठी, मुझे भी दो लाकर चिट्ठी ॥"
  ];

  final FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    setState(() {
      if (index == 1) {
        poem = poems[0];
        background = 'poem_one_bg1';
      } else if (index == 2) {
        poem = poems[1];
        background = 'poem_two_bg1';
      } else if (index == 3) {
        poem = poems[2];
        background = 'poem_three_bg1';
      } else if (index == 4) {
        poem = poems[3];
        background = 'poem_four_bg1';
      } else if (index == 5) {
        poem = poems[4];
        background = 'poem_five_bg1';
      } else if (index == 6) {
        poem = poems[5];
        background = 'poem_six_bg1';
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
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
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
                              builder: (context) => HindiPoemsMain()),
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
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: 20), // Adjust the padding as needed
                    child: ElevatedlabelLarge(
                      onPressed: _speak,
                      child: Text('Speak'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> initTts() async {
    await flutterTts.setLanguage('hi-IN');
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.4);
  }

  Future<void> _speak() async {
    await flutterTts.speak(poem);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    super.dispose();
  }
}
