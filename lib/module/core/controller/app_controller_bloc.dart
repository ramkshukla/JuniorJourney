import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:stack_overflow/_util/enum.dart';
import 'package:stack_overflow/module/core/controller/app_controller_event.dart';
import 'package:stack_overflow/module/core/controller/app_controller_state.dart';

class MyAppBloc extends Bloc<MyAppEvent, MyAppState> {
  MyAppBloc() : super(MyAppState(status: ConnectivityStatus.WiFi)) {
    // final Connectivity connectivity = Connectivity();

    on<CheckConnectivity>(
      (event, emit) async {
        InternetConnection()
            .onStatusChange
            .listen((InternetStatus internetStatus) {
          if (internetStatus == InternetStatus.connected) {
            print("Connected");
          } else if (internetStatus == InternetStatus.disconnected) {
            print("Disconnected");
          }
        });
      },
    );
  }
}
