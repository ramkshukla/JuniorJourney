import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:junior_journey/screen/HindiMain.dart';
import 'package:junior_journey/screen/alphabet_main.dart';
import 'package:junior_journey/screen/maths_main.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AlphabetMainScreen(),
    );
  }
}

class AlphabetMainScreen extends StatefulWidget {
  const AlphabetMainScreen({super.key});

  @override
  AlphabetMainScreenState createState() => AlphabetMainScreenState();
}

class AlphabetMainScreenState extends State<AlphabetMainScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  final List<String> images = ['english', 'hindi', 'maths'];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/green_background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 210,
            margin: const EdgeInsets.only(top: 50, bottom: 50, left: 30),
            child: GestureDetector(
              onTap: () {
                // Handle tap event for each card
                if (index == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AlphabetMain()),
                  );
                } else if (index == 2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MathsMain()),
                  );
                } else if (index == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HindiMain()),
                  );
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        child: Image.asset(
                          'assets/images/${images[index]}.png', // Assuming images are named as 1.jpg, 2.jpg, etc.
                          height: 220, // Adjust height as needed
                        ),
                      ),
                    ),
                  ),
                ],
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
