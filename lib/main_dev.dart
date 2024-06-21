import 'package:flutter/material.dart';
import 'package:stack_overflow/_util/app_config.dart';
import 'package:stack_overflow/_util/app_constant.dart';
import 'package:stack_overflow/_util/env_config.dart';
import 'package:stack_overflow/module/brewary/view/home_view.dart';

void main() {
  EnvConfig devConfig = development;
  AppConfig appConfig = AppConfig(child: MyApp(), envConfig: devConfig);

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
