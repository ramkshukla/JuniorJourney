import 'package:flutter/material.dart';
import 'package:stack_overflow/_util/env_config.dart';
import 'package:stack_overflow/_util/firebase_init.dart';
import 'package:stack_overflow/module/brewary/view/brewary_view.dart';
import 'package:stack_overflow/module/brewary/view/orient_view.dart';
import 'package:stack_overflow/module/home/view/home_view.dart';
import 'package:stack_overflow/module/home/view/method_channel.dart';
import 'package:stack_overflow/module/phone_auth/view/phone_auth_view.dart';
import 'package:stack_overflow/module/todo/view/todo_view.dart';
import 'package:stack_overflow/module/video_player/view/video_player.dart';

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "${uat.appTitle}",
            style: TextStyle(fontSize: 16),
          ),
          centerTitle: true),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                FirebaseInit().firebaseAnalytics.logEvent(
                  name: "page_tracked",
                  parameters: {"page_names": "BrewaryPage "},
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
                FirebaseInit().firebaseAnalytics.logEvent(
                  name: "page_tracked",
                  parameters: {"page_names": "Orient View "},
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
                FirebaseInit().firebaseAnalytics.logEvent(
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
