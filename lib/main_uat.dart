import 'dart:io';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:stack_overflow/_util/app_config.dart';
import 'package:stack_overflow/_util/env_config.dart';
import 'package:stack_overflow/main.dart';

Future<void> main() async {
  EnvConfig uatConfiguration = uat;
  AppConfig appConfig = AppConfig(child: MyApp(), envConfig: uatConfiguration);
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      name: "Brewary Spot ${uatConfiguration.flavor}",
      options: FirebaseOptions(
        apiKey: 'AIzaSyBSOT8xLKd3NaXyx1V99SHElvEbZ8mk-Is',
        appId: '1:732522482538:android:6ed309f46767b20ab8b313',
        messagingSenderId: '732522482538',
        projectId: 'pushnotification-35175',
      ),
    );
  } else if (Platform.isIOS) {
    await Firebase.initializeApp();
  }

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  runApp(appConfig);
}
