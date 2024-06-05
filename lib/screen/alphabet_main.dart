import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:junior_journey/screen/alphabet_one.dart';
import 'package:junior_journey/screen/AlphabetTwo.dart';
import 'package:junior_journey/screen/Consonents.dart';
import 'package:junior_journey/screen/DaysOfWeek.dart';
import 'package:junior_journey/screen/MonthsOfYear.dart';
import 'package:junior_journey/screen/Vegetables.dart';
import 'package:junior_journey/screen/animals.dart';
import 'package:junior_journey/screen/flowers.dart';
import 'package:junior_journey/screen/fruits.dart';
import 'package:junior_journey/screen/poems_main.dart';

class AlphabetMain extends StatelessWidget {
  const AlphabetMain({super.key});

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
  _AlphabetMainScreenState createState() => _AlphabetMainScreenState();
}

class _AlphabetMainScreenState extends State<AlphabetMainScreen> {
  @override
  void initState() {
    super.initState();
    // Start the automatic progression

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  // final List<String> items = ['Albhabet', 'Albhabet', 'Consonant'];
  final List<String> images = [
    'abc_auto_bg',
    'abc_bg',
    'k_kh_bg',
    'days',
    'months',
    'vegetables_logo',
    'animals_logo',
    'fruits_logo',
    'flower_logo',
    'poems_logo'
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
          return Container(
            margin: const EdgeInsets.all(35),
            child: GestureDetector(
              onTap: () {
                // Handle tap event for each card
                if (index == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AlphabetTwo()),
                  );
                } else if (index == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AlphabetOne()),
                  );
                } else if (index == 2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Consonents()),
                  );
                } else if (index == 3) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DaysOfWeek()),
                  );
                } else if (index == 4) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MonthOfYear()),
                  );
                } else if (index == 5) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VegetableSlider()),
                  );
                } else if (index == 6) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AnimaleSlider()),
                  );
                } else if (index == 7) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FruitSlider()),
                  );
                } else if (index == 8) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FlowersSlider()),
                  );
                } else if (index == 9) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PoemsMain()),
                  );
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    child: Material(
                      elevation: 10,
                      child: Image.asset(
                        'assets/images/${images[index]}.png', // Assuming images are named as 1.jpg, 2.jpg, etc.
                        height: 210, // Adjust height as needed
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
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }
}
