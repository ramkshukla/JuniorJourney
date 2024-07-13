import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:junior_journey/hindi/view/widget/hindi_varnamala.dart';
import 'package:junior_journey/hindi/view/widget/hindi_vowel.dart';
import 'package:junior_journey/maths/view/widget/number_display.dart';
import 'package:junior_journey/maths/view/widget/tables_main.dart';
import 'package:junior_journey/hindi/view/widget/hindi_poems_main.dart';

class HindiMain extends StatefulWidget {
  const HindiMain({super.key});

  @override
  HindiMainState createState() => HindiMainState();
}

class HindiMainState extends State<HindiMain> {
  @override
  void initState() {
    super.initState();
    // Start the automatic progression

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  dispose() {
    super.dispose();
  }

  // final List<String> items = ['Consonant', 'Vowel'];
  final List<String> images = [
    'kakha_bg',
    'aaa_bg',
    'numbers_logo',
    'tables_logo',
    'poems_logo'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/green_background.jpg'), // Background image path
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: images.length,
          itemBuilder: (BuildContext context, int index) {
            return Center(
              child: Container(
                margin: const EdgeInsets.only(top: 50, bottom: 50, left: 20),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      // Handle tap event for each card
                      if (index == 0) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HindiVarnamala()),
                        );
                      } else if (index == 1) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HindiVowel()),
                        );
                      } else if (index == 2) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NumberDisplay(
                                    language: "hi",
                                  )),
                        );
                      } else if (index == 3) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TablesMain(
                                    language: 'hi',
                                  )),
                        );
                      } else if (index == 4) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HindiPoemsMain()),
                        );
                      }
                    },
                    child: Container(
                      width: 250.0,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            clipBehavior: Clip.hardEdge,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            child: Material(
                              elevation: 10,
                              shadowColor: Colors.amber,
                              child: Image.asset(
                                'assets/images/${images[index]}.png', // Assuming images are named as 1.jpg, 2.jpg, etc.
                                height: 200, // Adjust height as needed
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void onBackPress() {
    SystemNavigator.pop();
  }
}
