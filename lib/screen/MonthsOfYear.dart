import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/services.dart';

class MonthOfYear extends StatelessWidget {
  const MonthOfYear({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: MonthOfYearScreen(),
      ),
    );
  }
}

class MonthOfYearScreen extends StatefulWidget {
  const MonthOfYearScreen({super.key});

  @override
  _DaysOfWeekState createState() => _DaysOfWeekState();
}

class _DaysOfWeekState extends State<MonthOfYearScreen> {
  String background = 'nameOfMonths';
  FlutterTts flutterTts = FlutterTts();
  List<String> daysOfWeek = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'Months of the year'
  ];
  int currentIndex = 7;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // Start speaking the first day name on initialization
    speakDayName(daysOfWeek[currentIndex]);
  }

  Future<void> speakDayName(String dayName) async {
    await flutterTts.setSpeechRate(0.5); // Adjust speech rate if needed
    await flutterTts.setLanguage('en-US');
    await flutterTts.speak(dayName);
    if (currentIndex == 7) {
      currentIndex = 0;
    }
  }

  void moveToNextDay() {
    if (currentIndex < daysOfWeek.length - 1) {
      setState(() {
        currentIndex++;
      });
      speakDayName(daysOfWeek[currentIndex]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background image
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/$background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Dividing the image into 7 equal parts and adding GestureDetector for each part
        Column(
          children: List.generate(
            7,
            (index) => Expanded(
              child: GestureDetector(
                onTap: () {
                  // Perform click operation based on the segment clicked
                  // For example, speak the day name
                  speakDayName(daysOfWeek[index]);
                },
                child: Container(
                  color: Colors.transparent,
                  // Height and width as per your requirement to divide equally
                  // Adjust these values according to your image size and layout
                ),
              ),
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  // Perform click operation for the first image
                  setState(() {
                    background = 'nameOfMonths';
                    daysOfWeek = [
                      'January',
                      'February',
                      'March',
                      'April',
                      'May',
                      'June',
                      'July',
                      'Months of the year'
                    ];
                  });
                },
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Image.asset(
                      'assets/images/back.png', // Your first image asset path
                      width: 70, // Adjust width as needed
                      height: 70, // Adjust height as needed
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  // Perform click operation for the second image
                  setState(() {
                    background = 'nameOfMonths1';
                    daysOfWeek = [
                      'August',
                      'September',
                      'October',
                      'November',
                      'December',
                      '',
                      ''
                    ];
                  });
                },
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Image.asset(
                      'assets/images/next.png', // Your second image asset path
                      width: 70, // Adjust width as needed
                      height: 70, // Adjust height as needed
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
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
