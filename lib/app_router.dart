import 'package:flutter/material.dart';
import 'package:organ_link/features/hospital_flow/hospital_dashboard/screen/hospital_dashboard_screen.dart';
import 'package:organ_link/features/hospital_flow/hospital_setting/screen/hospital_setting.dart';
import 'package:organ_link/features/hospital_flow/matching/screen/matching_screen.dart';
import 'package:organ_link/features/hospital_flow/matching_details/screen/matching_details_screen.dart';
import 'package:organ_link/features/hospital_flow/notification_screen/screen/hospital_notification_screen.dart';
import 'package:organ_link/features/hospital_flow/patient_details/screen/patient_details_screen.dart';
import 'package:organ_link/features/hospital_flow/surgeries/screen/surgeries_screen.dart';
import 'package:organ_link/features/hospital_flow/surgery_details/screen/surgery_details_screen.dart';
import 'package:organ_link/features/hospital_flow/view_patient/screen/view_patient_screen.dart';
import 'package:organ_link/features/ministry_flow/add_users/screen/add_new_user_screen.dart';
import 'package:organ_link/features/ministry_flow/hospital_detailes/screen/hospital_details_screen.dart';
import 'package:organ_link/features/ministry_flow/hospitals/screen/hospitals_screen.dart';
import 'package:organ_link/features/ministry_flow/ministry_home/screen/ministry_home_screen.dart';
import 'package:organ_link/features/ministry_flow/ministry_notification/screen/ministry_notification_screen.dart';
import 'package:organ_link/features/ministry_flow/ministry_notification_details/screens/ministry_notification_details_screen.dart';
import 'package:organ_link/features/ministry_flow/ministry_setting/screens/ministry_settings_screen.dart';
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
    MatchingDetailsScreen.routeName: (ctx) => const MatchingDetailsScreen(),
    SurgeriesScreen.routeName: (ctx) => const SurgeriesScreen(),
    SurgeryDetailsScreen.routeName: (ctx) => const SurgeryDetailsScreen(),
    HospitalNotificationScreen.routeName: (ctx) =>
        const HospitalNotificationScreen(),
    HospitalSetting.routeName: (ctx) => const HospitalSetting(),
    MinistryHomeScreen.routeName: (ctx) => const MinistryHomeScreen(),
    HospitalsScreen.routeName: (ctx) => const HospitalsScreen(),
    HospitalDetailsScreen.routeName: (ctx) => const HospitalDetailsScreen(),
    MinistryNotificationScreen.routeName: (ctx) =>
        const MinistryNotificationScreen(),
    MinistryNotificationDetailsScreen.routeName: (ctx) =>
        const MinistryNotificationDetailsScreen(),
    MinistrySettingsScreen.routeName: (ctx) => const MinistrySettingsScreen(),
    AddNewUserScreen.routeName: (ctx) => const AddNewUserScreen(),
  };
}
