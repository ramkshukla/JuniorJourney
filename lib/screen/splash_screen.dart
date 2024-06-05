import 'dart:async';
import 'package:flutter/material.dart';
import 'package:junior_journey/config/constant.dart';
import 'package:junior_journey/screen/onboarding_page.dart';

// void main() {
//   runApp(const SplashScreen());
// }

// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Junior Journey',
//       theme: ThemeData(primarySwatch: Colors.green),
//       home: const MyHomePage(),

//     );
//   }
// }

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    "My Home Page Init called".logIt;
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Onboarding1Page(),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Image.asset(
        'assets/images/jj_logo_img.png',
        width: 200, // Optional: specify the width
        height: 200, // Optional: specify the height
        // Optional: specify how the image should be fitted within the dimensions
      ),
    );
  }
}
