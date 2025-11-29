import 'package:flutter/material.dart';
import 'package:organ_link/features/login/screen/login_screen.dart';
import 'package:organ_link/features/splash/splash_screen.dart';
import 'package:organ_link/features/user_flow/home/screen/home_user_screen.dart';
import 'package:organ_link/features/user_flow/medical_details/screens/medical_details_screen.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> mainNavigatorKey =
      GlobalKey<NavigatorState>();

  static final routes = {
    SplashScreen.routeName: (ctx) => const SplashScreen(),
   LoginScreen.routName:(ctx)=>const LoginScreen(), 
   HomeUserScreen.routeName:(ctx)=> const HomeUserScreen(),
  MedicalDetailsScreen.routeName:(ctx)=> MedicalDetailsScreen(),
    };
}
