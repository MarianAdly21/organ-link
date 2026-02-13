import 'package:organ_link/features/hospital_flow/hospital_dashboard/screen/hospital_dashboard_screen.dart';
import 'package:organ_link/features/ministry_flow/ministry_home/screen/ministry_home_screen.dart';
import 'package:organ_link/features/user_flow/home/screen/home_user_screen.dart';

enum UserType { patient, donor, ministry, hospital }

extension UserTypeNavigation on UserType {
  String get homeRoute {
    switch (this) {
      case UserType.patient:
      case UserType.donor:
        return HomeUserScreen.routeName;

      case UserType.ministry:
        return MinistryHomeScreen.routeName;

      case UserType.hospital:
        return HospitalDashboardScreen.routeName;
    }
  }
}

extension UserTypeParser on String {
  UserType toUserType() {
    switch (toLowerCase()) {
      case "patient":
      case "مريض":
        return UserType.patient;

      case "donor":
      case "متبرع":
        return UserType.donor;

      case "ministry":
      case "وزارة":
        return UserType.ministry;

      case "hospital":
      case "حكومي":
      case "خاص":
      case "government":
      case "private":
        return UserType.hospital;

      default:
        return UserType.patient; 
    }
  }
}
