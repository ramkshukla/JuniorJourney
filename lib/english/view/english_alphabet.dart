import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:junior_journey/english/view/widgets/alphabet_one.dart';
import 'package:junior_journey/english/view/widgets/alphabet_two.dart';
import 'package:junior_journey/english/view/widgets/consonents.dart';
import 'package:junior_journey/english/view/widgets/days_of_week.dart';
import 'package:junior_journey/english/view/widgets/months_of_year.dart';
import 'package:junior_journey/english/view/widgets/vegetables.dart';
import 'package:junior_journey/english/view/widgets/animals.dart';
import 'package:junior_journey/english/view/widgets/flowers.dart';
import 'package:junior_journey/english/view/widgets/fruits.dart';
import 'package:junior_journey/english/view/widgets/poems_main.dart';

class EnglishAlphabet extends StatelessWidget {
  const EnglishAlphabet({super.key});

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
            'assets/images/green_background.jpg',
          ),
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
                    MaterialPageRoute(
                      builder: (context) => const AlphabetTwo(),
                    ),
                  );
                } else if (index == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AlphabetOne(),
                    ),
                  );
                } else if (index == 2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Consonents(),
                    ),
                  );
                } else if (index == 3) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DaysOfWeek(),
                    ),
                  );
                } else if (index == 4) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MonthOfYear(),
                    ),
                  );
                } else if (index == 5) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const VegetableSlider(),
                    ),
                  );
                } else if (index == 6) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AnimaleSlider(),
                    ),
                  );
                } else if (index == 7) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FruitSlider(),
                    ),
                  );
                } else if (index == 8) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FlowersSlider(),
                    ),
                  );
                } else if (index == 9) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PoemsMain(),
                    ),
                  );
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    child: Material(
                      elevation: 10,
                      child: Image.asset(
                        'assets/images/${images[index]}.png',
                        height: 210,
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
