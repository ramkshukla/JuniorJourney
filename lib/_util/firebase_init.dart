import 'package:firebase_analytics/firebase_analytics.dart';

class FirebaseInit {
  final FirebaseAnalytics firebaseAnalytics = FirebaseAnalytics.instance;
  FirebaseInit() {
    firebaseAnalytics.setAnalyticsCollectionEnabled(true);
  }
}
