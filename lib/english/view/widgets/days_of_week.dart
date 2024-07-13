import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/services.dart';

class DaysOfWeek extends StatefulWidget {
  const DaysOfWeek({super.key});

  @override
  DaysOfWeekState createState() => DaysOfWeekState();
}

class DaysOfWeekState extends State<DaysOfWeek> {
  FlutterTts flutterTts = FlutterTts();
  List<String> daysOfWeek = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Days of the week',
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

  Future<void> pauseFluttertts() async {
    await flutterTts.pause();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background image

        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/dayofweek.jpg'),
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
      ],
    );
  }

  @override
  void dispose() {
    pauseFluttertts();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    super.dispose();
  }
}
