import 'package:flutter/material.dart';
import 'package:organ_link/features/hospital_flow/hospital_dashboard/screen/hospital_dashboard_screen.dart';
import 'package:organ_link/features/hospital_flow/matching/screen/matching_screen.dart';
import 'package:organ_link/features/hospital_flow/matching_details/screen/matching_details_screen.dart';
import 'package:organ_link/features/hospital_flow/patient_details/screen/patient_details_screen.dart';
import 'package:organ_link/features/hospital_flow/surgeries/screen/surgeries_screen.dart';
import 'package:organ_link/features/hospital_flow/view_patient/screen/view_patient_screen.dart';
import 'package:organ_link/features/shared_screens/login/screen/login_screen.dart';
import 'package:organ_link/features/shared_screens/splash/splash_screen.dart';
import 'package:organ_link/features/user_flow/case_follow_up/screen/case_follow_up_screen.dart';
import 'package:organ_link/features/user_flow/home/screen/home_user_screen.dart';
import 'package:organ_link/features/user_flow/hospital_information/screen/hospital_information_screen.dart';
import 'package:organ_link/features/user_flow/medical_details/screens/medical_details_screen.dart';
import 'package:organ_link/features/user_flow/notification/screens/notification_screen.dart';
import 'package:organ_link/features/user_flow/settings/screen/settings_screen.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> mainNavigatorKey =
      GlobalKey<NavigatorState>();

  static final routes = {
    SplashScreen.routeName: (ctx) => const SplashScreen(),
    LoginScreen.routName: (ctx) => const LoginScreen(),
    HomeUserScreen.routeName: (ctx) => const HomeUserScreen(),
    MedicalDetailsScreen.routeName: (ctx) => const MedicalDetailsScreen(),
    CaseFollowUpScreen.routeName: (ctx) => const CaseFollowUpScreen(),
    HospitalInformationScreen.routeName: (ctx) =>
        const HospitalInformationScreen(),
    SettingsScreen.routeName: (ctx) => const SettingsScreen(),
    NotificationScreen.routeName: (ctx) => const NotificationScreen(),
    HospitalDashboardScreen.routeName: (ctx) => const HospitalDashboardScreen(),
    ViewPatientScreen.routeName: (ctx) => const ViewPatientScreen(),
    PatientDetailsScreen.routeName: (ctx) => const PatientDetailsScreen(),
    MatchingScreen.routeName: (ctx) => const MatchingScreen(),
    MatchingDetailsScreen.routeName:(ctx)=> const MatchingDetailsScreen(),
    SurgeriesScreen.routeName:(ctx)=> const SurgeriesScreen(),
  };
}
