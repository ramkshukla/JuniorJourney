import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:junior_journey/screen/HindiVarnamala.dart';
import 'package:junior_journey/screen/HindiVowel.dart';
import 'package:junior_journey/screen/number_display.dart';
import 'package:junior_journey/screen/tables_main.dart';
import 'package:junior_journey/screen/hindi_poems_main.dart';

class HindiMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: HindiMainScreen(),
      ),
    );
  }
}

class HindiMainScreen extends StatefulWidget {
  @override
  _MathsMainScreenState createState() => _MathsMainScreenState();
}

class _MathsMainScreenState extends State<HindiMainScreen> {
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
    return Container(
      decoration: BoxDecoration(
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
              margin: EdgeInsets.only(top: 50, bottom: 50, left: 20),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    // Handle tap event for each card
                    if (index == 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HindiVarnamala()),
                      );
                    } else if (index == 1) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HindiVowel()),
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
                            builder: (context) => TablesMain(
                                  language: 'hi',
                                )),
                      );
                    } else if (index == 4) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HindiPoemsMain()),
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
                          borderRadius: BorderRadius.all(Radius.circular(20)),
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
    );
  }

  void onBackPress() {
    SystemNavigator.pop();
  }
}
