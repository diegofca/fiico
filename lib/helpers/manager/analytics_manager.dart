import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_smartlook/flutter_smartlook.dart';

class AnalyticsManager {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  void setUserID(String? userID) {
    _analytics.setUserId(id: userID);
    Smartlook.setUserIdentifier(userID!);
  }

  void screenView(String screenName) {
    _analytics.logEvent(name: '${screenName}ScreenView', parameters: {
      'screenName': screenName,
    });
    Smartlook.trackNavigationEvent(
      screenName,
      SmartlookNavigationEventType.enter,
    );
  }

  void backView() {
    _analytics.logScreenView(screenName: 'back');
    Smartlook.trackNavigationEvent('back', SmartlookNavigationEventType.exit);
  }
}
