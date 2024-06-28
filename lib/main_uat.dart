import 'dart:io';
import 'dart:ui';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stack_overflow/_util/app_config.dart';
import 'package:stack_overflow/_util/env_config.dart';
import 'package:stack_overflow/_util/locator.dart';
import 'package:stack_overflow/main.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  EnvConfig uatConfiguration = uat;
  await Hive.initFlutter();
  await Hive.openBox("myBox");
  AppConfig appConfig = AppConfig(
    child: MyApp(),
    envConfig: uatConfiguration,
  );

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
    await FirebaseAppCheck.instance.activate(
      webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
      androidProvider: AndroidProvider.playIntegrity,
      appleProvider: AppleProvider.appAttest,
    );
  } else if (Platform.isIOS) {
    await Firebase.initializeApp();
    FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
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
