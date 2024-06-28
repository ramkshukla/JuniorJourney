import 'dart:io';

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stack_overflow/_util/app_config.dart';
import 'package:stack_overflow/_util/app_constant.dart';
import 'package:stack_overflow/_util/env_config.dart';
import 'package:stack_overflow/module/brewary/view/home_view.dart';

Future<void> main() async {
  EnvConfig prodConfig = production;
  AppConfig appConfig = AppConfig(child: MyApp(), envConfig: prodConfig);

  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      name: "Brewary Spot ${prodConfig.flavor}",
      options: FirebaseOptions(
        apiKey: 'AIzaSyBSOT8xLKd3NaXyx1V99SHElvEbZ8mk-Is',
        appId: '1:732522482538:android:6ed309f46767b20ab8b313',
        messagingSenderId: '732522482538',
        projectId: 'pushnotification-35175',
      ),
    );
    await FirebaseAppCheck.instance.activate(
      // You can also use a `ReCaptchaEnterpriseProvider` provider instance as an
      // argument for `webProvider`
      webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
      // Default provider for Android is the Play Integrity provider. You can use the "AndroidProvider" enum to choose
      // your preferred provider. Choose from:
      // 1. Debug provider
      // 2. Safety Net provider
      // 3. Play Integrity provider
      androidProvider: AndroidProvider.debug,
      // Default provider for iOS/macOS is the Device Check provider. You can use the "AppleProvider" enum to choose
      // your preferred provider. Choose from:
      // 1. Debug provider
      // 2. Device Check provider
      // 3. App Attest provider
      // 4. App Attest provider with fallback to Device Check provider (App Attest provider is only available on iOS 14.0+, macOS 14.0+)
      appleProvider: AppleProvider.appAttest,
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
      home: const MyHome(),
    );
  }
}
