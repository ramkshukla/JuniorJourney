import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:junior_journey/screen/poems.dart';

class PoemsMain extends StatefulWidget {
  const PoemsMain({super.key});

  @override
  PoemsMainState createState() => PoemsMainState();
}

class PoemsMainState extends State<PoemsMain> {
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
    super.dispose();
  }

  final List<String> items = [
    'Twinkle, twinkle, little star',
    'Rain, rain, go away',
    'The Silly Squirrel',
    'Rainbow Magic',
    'Funny Frog',
    'Buzzy Bee'
  ];
  final List<String> images = [
    'poem_one_logo',
    'poem_two_logo',
    'poem_three_logo',
    'poem_four_logo',
    'poem_five_logo',
    'poem_six_logo'
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
              margin: const EdgeInsets.all(40),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    // Handle tap event for each card
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Poems(index: index + 1)),
                    );
                  },
                  child: Card(
                    elevation: 4.0,
                    child: Container(
                      width: 220.0,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            child: Image.asset(
                              'assets/images2/${images[index]}.png', // Assuming images are named as 1.jpg, 2.jpg, etc.
                              height: 180,
                              // Adjust height as needed
                            ),
                          ),
                          Text(
                            items[index],
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                          )
                        ],
                      ),
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
