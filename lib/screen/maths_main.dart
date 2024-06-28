import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:junior_journey/screen/addition_subtraction.dart';
import 'package:junior_journey/screen/division.dart';
import 'package:junior_journey/screen/multiplication.dart';
import 'package:junior_journey/screen/number_display.dart';
import 'package:junior_journey/screen/tables_main.dart';

class MathsMain extends StatelessWidget {
  const MathsMain({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: MathsMainScreen(),
      ),
    );
  }
}

class MathsMainScreen extends StatefulWidget {
  const MathsMainScreen({super.key});

  @override
  _MathsMainScreenState createState() => _MathsMainScreenState();
}

class _MathsMainScreenState extends State<MathsMainScreen> {
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

  // final List<String> items = ['Numbers', 'Tables'];
  final List<String> images = [
    'numbers_logo',
    'tables_logo',
    'addition',
    'subtraction',
    'multiplication',
    'division'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
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
              margin: const EdgeInsets.only(top: 50, bottom: 50, left: 30),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    // Handle tap event for each card
                    if (index == 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const NumberDisplay(language: "en")),
                      );
                    } else if (index == 1) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TablesMain(
                                  language: 'en',
                                )),
                      );
                    } else if (index == 2) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const AdditionAndSubtraction(operator: "Add")),
                      );
                    } else if (index == 3) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const AdditionAndSubtraction(operator: "Sub")),
                      );
                    } else if (index == 4) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Multiplication()),
                      );
                    } else if (index == 5) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Devision()),
                      );
                    }
                  },
                  child: Container(
                    width: 230.0,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            'assets/images/${images[index]}.png', // Assuming images are named as 1.jpg, 2.jpg, etc.
                            height: 200, // Adjust height as needed
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
