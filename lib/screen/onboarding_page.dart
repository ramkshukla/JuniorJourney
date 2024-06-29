import 'package:junior_journey/main_one.dart';
import 'package:junior_journey/screen/overboard.dart';
import 'package:junior_journey/model/page_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Onboarding1Page extends StatefulWidget {
  const Onboarding1Page({super.key});

  @override
  _Onboarding1PageState createState() => _Onboarding1PageState();
}

class _Onboarding1PageState extends State<Onboarding1Page> {
  final _pageList = [
    PageModel(
        color: const Color.fromARGB(255, 230, 233, 238),
        imageAssetPath: 'assets/images/slide_img3.png',
        title: 'Dream Big with Career Choices!',
        body:
            '"Dream Big with Career Choices!" invites kids to explore diverse professions and envision their future paths through exciting learning adventures, inspiring them to aim high and pursue their passions.',
        doAnimateImage: true),
    PageModel(
        color: const Color.fromARGB(255, 230, 233, 238),
        // imageFromUrl: GLOBAL_URL + '/onboarding/cart.png',
        imageAssetPath: 'assets/images/slide_img1.png',
        title: 'Discover the Joy of Reading!',
        body:
            '"Discover the Joy of Reading!" encourages children to embark on exciting literary journeys, fostering a love for books and imagination while unlocking endless worlds and knowledge through the magic of storytelling.',
        doAnimateImage: true),
    PageModel(
        color: const Color.fromARGB(255, 230, 233, 238),
        imageAssetPath: 'assets/images/slide_img2.png',
        title: 'Grow Plants and Learn Nature!',
        body:
            '"Grow Plants and Learn Nature!" encourages kids to cultivate green thumbs while discovering the wonders of the natural world through hands-on gardening experiences.',
        doAnimateImage: true),
    PageModel(
        color: const Color.fromARGB(255, 230, 233, 238),
        imageAssetPath: 'assets/images/slide_img4.png',
        title: 'Fun with Numbers and Math!',
        body:
            '"Fun with Numbers and Math!" makes learning arithmetic enjoyable and engaging for children, turning numerical concepts into exciting adventures through interactive activities and games.',
        doAnimateImage: true),
  ];

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
      value:
          const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
      child: OverBoard(
        pages: _pageList,
        showBullets: true,
        finishCallback: () {
          // Fluttertoast.showToast(
          //     msg: 'Click finish', toastLength: Toast.LENGTH_SHORT);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        },
      ),
    ));
  }
}
