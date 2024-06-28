import 'package:stack_overflow/_util/connectivity/stoppable_service.dart';
import 'package:stack_overflow/_util/enum.dart';

abstract class ConnectivityService extends StoppableService {
  Stream<ConnectivityStatus> get connectivity$;

  Future<bool> get isConnected;
}
