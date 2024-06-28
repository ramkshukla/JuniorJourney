// Dart imports:
import 'dart:async';

// Package imports:
import 'package:connectivity_plus/connectivity_plus.dart';

// Project imports:
import 'package:stack_overflow/_util/enum.dart';
import 'connectivity_service.dart';

class ConnectivityServiceImpl implements ConnectivityService {
  final _connectivityResultController = StreamController<ConnectivityStatus>();
  final _connectivity = Connectivity();

  late StreamSubscription<ConnectivityResult> _subscription;
  ConnectivityResult? _lastResult;
  bool _serviceStopped = false;

  @override
  Stream<ConnectivityStatus> get connectivity$ =>
      _connectivityResultController.stream;

  @override
  bool get serviceStopped => _serviceStopped;

  ConnectivityServiceImpl() {
    _subscription = _connectivity.onConnectivityChanged.listen(
            _emitConnectivity as void Function(List<ConnectivityResult> event)?)
        as StreamSubscription<ConnectivityResult>;
  }

  @override
  Future<bool> get isConnected async {
    final result = await _connectivity.checkConnectivity();

    switch (result) {
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
        return true;
      case ConnectivityResult.none:
      default:
        return false;
    }
  }

  @override
  Future<void> start() async {
    _serviceStopped = false;

    await _resumeSignal();
    _subscription.resume();
  }

  @override
  void stop() {
    _serviceStopped = true;

    _subscription.pause(_resumeSignal());
  }

  void _emitConnectivity(ConnectivityResult event) {
    if (event == _lastResult) return;
    _connectivityResultController.add(_convertResult(event));
    _lastResult = event;
  }

  Future<void> emitLastConnectivity(
      {Duration sleepTime = Duration.zero}) async {
    final result = await _connectivity.checkConnectivity();
    if (sleepTime != Duration.zero) {
      await Future.delayed(sleepTime);
    }
    _connectivityResultController.add(_convertResult(result.first));
  }

  ConnectivityStatus _convertResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        return ConnectivityStatus.Cellular;
      case ConnectivityResult.wifi:
        return ConnectivityStatus.WiFi;
      case ConnectivityResult.none:
        return ConnectivityStatus.Offline;
      default:
        return ConnectivityStatus.Offline;
    }
  }

  Future<void> _resumeSignal() async => true;
}
