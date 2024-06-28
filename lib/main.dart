import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:stack_overflow/module/brewary/view/home_view.dart';
import 'package:http/http.dart' as http;
import 'package:stack_overflow/module/core/controller/app_controller_bloc.dart';
import 'package:stack_overflow/module/core/controller/app_controller_event.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription<InternetStatus>? listener;
  Box box = Hive.box("myBox");
  @override
  void initState() {
    super.initState();

    // internetConnection();
    // connected = InternetConnectivity().internetConnectionListener();
  }

  // internetConnection() {
  //   final listener =
  //       InternetConnection().onStatusChange.listen((InternetStatus status) {
  //     switch (status) {
  //       case InternetStatus.connected:
  //         // The internet is now connected
  //         setState(() {
  //           connected = true;
  //         });
  //         break;
  //       case InternetStatus.disconnected:
  //         // The internet is now disconnected
  //         setState(() {
  //           connected = false;
  //         });
  //         break;
  //     }
  //   });
  // }

  @override
  void dispose() {
    super.dispose();
    // listener!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stack Overflow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<MyAppBloc>(
            create: (BuildContext context) =>
                MyAppBloc()..add(CheckConnectivity()),
          ),
        ],
        child: const MyHome(),
      ),
    );
  }

  Future<void> syncData({List<String>? localData}) async {
    print("Synced Successfuully");
    final url =
        Uri.parse('http://consumerapp.netcarrots.in/API/QRCodeSubmitAPI');
    final response = await http.post(url, body: {
      "MobileNo": "9999888800",
      "CustomerMobileNo": "9999999999",
      "Image": "",
      'QRCode': localData!.join(','),
    });
    if (response.statusCode == 200) {
      print('Data synced successfully!');
    } else {
      print('Error syncing data: ${response.reasonPhrase}');
    }
  }
}
