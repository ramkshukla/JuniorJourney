import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:stack_overflow/_util/app_constant.dart';

class InternetConnectivityService {
  static final InternetConnectivityService _instance =
      InternetConnectivityService._internal();
  InternetConnectivityService._internal();

  factory InternetConnectivityService() {
    return _instance;
  }

  bool lastValue = true;
  final Connectivity _connectivity = Connectivity();
  final StreamController<bool> _connectionChangeController =
      StreamController.broadcast();

  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  Future<void> init() async {
    await for (final dataConnectionStatus
        in _connectivity.onConnectivityChanged) {
      isConnected = dataConnectionStatus == ConnectivityResult.mobile ||
          dataConnectionStatus == ConnectivityResult.wifi;

      _connectionChangeController.add(isConnected);
    }
  }
  // InternetConnectivityService.init() {
  //   _connectivitySubscription =
  //       _connectivity.onConnectivityChanged.listen((dataConnectionStatus) {
  //     isConnected = dataConnectionStatus == ConnectivityResult.mobile ||
  //         dataConnectionStatus == ConnectivityResult.wifi;

  //     _connectionChangeController.add(isConnected);
  //   }) as StreamSubscription<ConnectivityResult>;
  // }

  Stream<bool> get connectivityStatus => _connectionChangeController.stream;

  void dispose() {
    _connectivitySubscription.cancel();
  }
}
