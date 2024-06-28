import 'dart:io';

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stack_overflow/_util/app_config.dart';
import 'package:stack_overflow/_util/app_constant.dart';
import 'package:stack_overflow/_util/env_config.dart';
import 'package:stack_overflow/_util/extensions.dart';
import 'package:stack_overflow/module/brewary/view/home_view.dart';

Future<void> main() async {
  EnvConfig devConfig = development;
  AppConfig appConfig = AppConfig(child: MyApp(), envConfig: devConfig);
  "App Environment : ${appConfig.envConfig.flavor.name}".logIt;
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: 'AIzaSyBSOT8xLKd3NaXyx1V99SHElvEbZ8mk-Is',
        appId: '1:732522482538:android:6ed309f46767b20ab8b313',
        messagingSenderId: '732522482538',
        projectId: 'pushnotification-35175',
      ),
    );
    await FirebaseAppCheck.instance.activate(
      webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
      androidProvider: AndroidProvider.debug,
      appleProvider: AppleProvider.debug,
    );
  } else if (Platform.isIOS) {
    await Firebase.initializeApp();
  }

  runApp(appConfig);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    baseUrl = AppConfig.of(context)!.envConfig.baseUrl;
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHome()
        // home: Home(),
        );
  }
}
