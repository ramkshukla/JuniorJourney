// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:junior_journey/config/constant.dart';
// import 'package:junior_journey/screen/onboarding_page.dart';

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});

//   @override
//   MyHomePageState createState() => MyHomePageState();
// }

// class MyHomePageState extends State<MyHomePage> {
//   @override
//   void initState() {
//     "My Home Page Init called".logIt;
//     super.initState();
//     Timer(
//       const Duration(seconds: 3),
//       () => Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => const,
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: Text("Jounior Journey "),
//       ),
//     );
//   }
// }

//  Image.asset(
//   AssetsConstant.juniorJourneyLogo,
//   width: 200,
//   height: 200,
// ),