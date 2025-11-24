import 'package:flutter/material.dart';
import 'package:organ_link/features/splash/splash_screen.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> mainNavigatorKey =
      GlobalKey<NavigatorState>();

  static final routes = {SplashScreen.routeName: (ctx) => const SplashScreen()};
}
