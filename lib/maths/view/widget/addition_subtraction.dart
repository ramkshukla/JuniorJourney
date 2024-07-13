import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/services.dart';
import 'package:junior_journey/maths/view/maths_main.dart';
import 'package:junior_journey/data/next_and_back_bnt.dart';

class AdditionAndSubtraction extends StatelessWidget {
  final String operator;
  const AdditionAndSubtraction({required this.operator, super.key});

  @override
  Widget build(BuildContext context) {
    return MyHomePage(
      operator: operator,
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String operator;
  const MyHomePage({required this.operator, super.key});
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  // final String operator;
  FlutterTts flutterTts = FlutterTts();
  final GlobalKey _key = GlobalKey();
  late List<int> firstNumber;
  late List<int> secondNumber;
  late int num;
  late String operatorSymbal;
  Map<int, String> myMap = {
    1: 'one',
    2: 'two',
    3: 'three',
    4: 'four',
    5: 'five',
    6: 'six',
    7: 'seven',
    8: 'eight',
    9: 'nine',
    0: 'zero'
  };
  // int firstNumber = 3;
  // int secondNumber = 4;
  int index = 0;
  int total = 0;

  late String operatorName;
  late bool visilityValue;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    setState(() {
      if (widget.operator == 'Add') {
        firstNumber = [1, 2, 4, 3, 4, 1, 5, 3];
        secondNumber = [2, 3, 3, 2, 2, 3, 2, 5];
        total = firstNumber[index] + secondNumber[index];
        operatorName = "plus";
        operatorSymbal = '+';
        visilityValue = true;
        num = firstNumber[index];
      } else if (widget.operator == "Sub") {
        firstNumber = [2, 3, 5, 3, 4, 6, 5, 7];
        secondNumber = [1, 1, 2, 2, 2, 3, 2, 3];
        operatorName = "minus";
        total = firstNumber[index] - secondNumber[index];
        visilityValue = false;
        num = total;
        operatorSymbal = '-';
      }
    });
    super.initState();
    speak();
  }

  Future<void> speak() async {
    await flutterTts.speak(
        '${firstNumber[index]} rabbit $operatorName ${secondNumber[index]} rabbit is equal to $total rabbit');
  }

  Future<void> pauseFluttertts() async {
    await flutterTts.pause();
  }

  @override
  void dispose() {
    pauseFluttertts();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/green_board.jpg'), // Background image path
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                alignment: Alignment.topLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MathsMain()),
                        );

                        // Handle back labelLarge tap
                      },
                      child: Image.asset(
                        'assets/images/back_btn.png',
                        height: 45,
                        width: 100,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Container(
                width: 450,
                height: 400,
                margin: const EdgeInsets.only(top: 30, left: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 35),
                              child: Image.asset(
                                  'assets/images/${myMap[firstNumber[index]]}.png',
                                  height: 45,
                                  width: 45)),
                          const SizedBox(width: 10),
                          for (int i = 1; i <= firstNumber[index]; i++)
                            Image.asset('assets/images1/kha1.png',
                                height: 50, width: 50),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      key: _key,
                      children: [
                        Text(
                          operatorSymbal,
                          style: const TextStyle(
                              fontSize: 50,
                              color: Color.fromRGBO(164, 5, 5, 1),
                              fontWeight: FontWeight.bold),
                        ),

                        const SizedBox(width: 10),
                        Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Image.asset(
                                'assets/images/${myMap[secondNumber[index]]}.png',
                                height: 45,
                                width: 45)),
                        const SizedBox(width: 10),
                        for (int i = 1; i <= secondNumber[index]; i++)
                          Image.asset('assets/images1/kha1.png',
                              height: 50, width: 50),
                        const SizedBox(width: 10),
                        //
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 70),
                      child: Divider(
                        height: 20,
                        color: Colors.grey,
                        thickness: 1,
                        indent: 10,
                        endIndent: 10,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 35),
                          child: Column(
                            children: [
                              Image.asset('assets/images/${myMap[total]}.png',
                                  height: 50, width: 50)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (int i = 1; i <= num; i++)
                                    Image.asset('assets/images1/kha1.png',
                                        height: 50, width: 50),
                                ],
                              ),
                              Visibility(
                                visible: visilityValue,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    for (int i = 1;
                                        i <= secondNumber[index];
                                        i++)
                                      Image.asset('assets/images1/kha1.png',
                                          height: 50, width: 50),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 70),
                      child: Divider(
                        height: 10,
                        color: Colors.grey,
                        thickness: 1,
                        indent: 10,
                        endIndent: 10,
                      ),
                    ),
                    //code for next and back labelLarge
                    NextAndBackBtn(
                        nextFunction: nextFunction, backFunction: backFunction)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void nextFunction() {
    setState(() {
      if (index != 7) {
        index++;

        if (widget.operator == "Add") {
          total = firstNumber[index] + secondNumber[index];
          num = firstNumber[index];
        } else {
          total = firstNumber[index] - secondNumber[index];
          num = total;
        }

        speak();
      }
    });
  }

  void backFunction() {
    setState(() {
      if (index != 0) {
        index--;
        if (widget.operator == "Add") {
          total = firstNumber[index] + secondNumber[index];
          num = firstNumber[index];
        } else {
          total = firstNumber[index] - secondNumber[index];
          num = total;
        }

        speak();
      }
    });
  }
}
