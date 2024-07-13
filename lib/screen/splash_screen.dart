import 'dart:async';

import 'package:flutter/material.dart';
import 'package:junior_journey/config/assets_constant.dart';
import 'package:junior_journey/screen/onboarding_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  late Timer timer;
  @override
  void initState() {
    timer = Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const OnboardingPage(),
        ),
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          AssetsConstant.juniorJourneyLogo,
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
