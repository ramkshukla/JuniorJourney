import 'package:stack_overflow/_util/enum.dart';

class MyAppState {
  final ConnectivityStatus status;
  MyAppState({required this.status});

  MyAppState copyWith({ConnectivityStatus? status}) {
    return MyAppState(
      status: status ?? this.status,
    );
  }
}
