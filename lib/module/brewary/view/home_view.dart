import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stack_overflow/_util/extensions.dart';
import 'package:stack_overflow/module/brewary/view/brewary_view.dart';
import 'package:stack_overflow/module/brewary/view/orient_view.dart';
import 'package:stack_overflow/module/home/view/home_view.dart';
import 'package:stack_overflow/module/home/view/method_channel.dart';
import 'package:stack_overflow/module/phone_auth/view/phone_auth_view.dart';
import 'package:stack_overflow/module/todo/view/todo_view.dart';
import 'package:stack_overflow/module/video_player/view/video_player.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final FirebaseAnalytics firebaseAnalytics = FirebaseAnalytics.instance;

  @override
  void initState() {
    firebaseAnalytics.setAnalyticsCollectionEnabled(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(),
      bottomSheet: Container(height: 100),
      drawerDragStartBehavior: DragStartBehavior.down,
      drawerEnableOpenDragGesture: true,
      drawerEdgeDragWidth: 200,
      drawerScrimColor: Colors.grey,
      onDrawerChanged: (value) {
        "Values : Called".logIt;
      },
      appBar: AppBar(
        title: Text("Brewery Spot", style: TextStyle(fontSize: 16)),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                FirebaseAnalytics.instance.logEvent(
                  name: "page_tracked",
                  parameters: {
                    "page_names": "BrewaryPage",
                  },
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BrewaryUI(),
                  ),
                );
              },
              child: const Text("Brewary View"),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                FirebaseAnalytics.instance.logEvent(
                  name: "page_tracked",
                  parameters: {"page_names": "Orient View"},
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrientView(),
                  ),
                );
              },
              child: const Text("Orient View"),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                FirebaseAnalytics.instance.logEvent(
                  name: "page_tracked",
                  parameters: {"page_names": "Video Player"},
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CustomVideoPlayer(),
                  ),
                );
              },
              child: const Text("Video Player"),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Home(),
                  ),
                );
              },
              child: const Text("Home"),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MethodChannelUI(),
                  ),
                );
              },
              child: const Text("Method Channel"),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PhoneAuthView(),
                  ),
                );
              },
              child: Text("Login"),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Todo()),
                  );
                },
                child: Text("Firestore Tutorial")),
            ElevatedButton(
                onPressed: () {
                  Exception();
                },
                child: Text("Error"))
          ],
        ),
      ),
    );
  }
}
