import 'package:flutter/material.dart';

class NavigationService {
  late GlobalKey<NavigatorState> navigationKey;

  static NavigationService instance = NavigationService();

  NavigationService() {
    navigationKey = GlobalKey<NavigatorState>();
  }

  Future<dynamic> navigateToReplacement(String rn) {
    return navigationKey.currentState!.pushReplacementNamed(rn);
  }

  Future<dynamic> navigateAndSetRoot(String rn) {
    return navigationKey.currentState!.pushReplacementNamed(rn);
  }

  Future<dynamic> navigateTo(String rn, {dynamic args}) {
    return navigationKey.currentState!.pushNamed(rn, arguments: args);
  }

  Future<dynamic> navigateToRoute(MaterialPageRoute rn) {
    return navigationKey.currentState!.push(rn);
  }

  void goBack({dynamic result}) {
    navigationKey.currentState!.pop(result);
  }
}
