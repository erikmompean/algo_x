import 'package:flutter/material.dart';

class AppNavigator {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Future<void> push(String route) async {
    navigatorKey.currentState!.pushNamed(route);
  }

  static void back() {
    navigatorKey.currentState!.pop();
  }
}
