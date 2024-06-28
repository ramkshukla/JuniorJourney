import 'package:get_it/get_it.dart';
import 'package:stack_overflow/_util/connectivity/connectivity_service.dart';
import 'package:stack_overflow/_util/connectivity/connectivity_service_impl.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  // locator.registerLazySingleton(() => AnalyticsService());

  locator.registerLazySingleton<ConnectivityService>(
    () => ConnectivityServiceImpl(),
  );
}
