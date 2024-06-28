import 'package:firebase_analytics/firebase_analytics.dart';

class FirebaseAppInit {
  FirebaseAnalytics firebaseAnalytics = FirebaseAnalytics.instance;
  FirebaseAppInit() {
    firebaseAnalytics.setAnalyticsCollectionEnabled(true);
  }
}
