import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:junior_journey/screen/hindi_poems.dart';

class HindiPoemsMain extends StatelessWidget {
  const HindiPoemsMain({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: PoemsMainScreen(),
      ),
    );
  }
}

class PoemsMainScreen extends StatefulWidget {
  const PoemsMainScreen({super.key});

  @override
  _PoemsMainScreenState createState() => _PoemsMainScreenState();
}

class _PoemsMainScreenState extends State<PoemsMainScreen> {
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

  final List<String> items = [
    'मोटूराम',
    'सोने की चिड़िया',
    'प्यासा कौआ',
    'उड़ी पतंग',
    'सेब',
    'डाकिया आया'
  ];
  final List<String> images = [
    'poem_one_logo1',
    'poem_two_logo1',
    'poem_three_logo1',
    'poem_four_logo1',
    'poem_five_logo1',
    'poem_six_logo1'
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
              margin: const EdgeInsets.all(35),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    // Handle tap event for each card
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HindiPoems(index: index + 1)),
                    );
                  },
                  child: Card(
                    elevation: 4.0,
                    child: Container(
                      width: 230.0,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images2/${images[index]}.jpg', // Assuming images are named as 1.jpg, 2.jpg, etc.
                            height: 200, // Adjust height as needed
                          ),
                          Text(
                            items[index],
                            style: const TextStyle(color: Colors.grey, fontSize: 18),
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
