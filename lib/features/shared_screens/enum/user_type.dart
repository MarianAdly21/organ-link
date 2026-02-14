import 'package:organ_link/features/hospital_flow/hospital_dashboard/screen/hospital_dashboard_screen.dart';
import 'package:organ_link/features/ministry_flow/ministry_home/screen/ministry_home_screen.dart';
import 'package:organ_link/features/user_flow/home/screen/home_user_screen.dart';

enum UserType { user, ministry, hospital }

extension UserTypeNavigation on UserType {
  String get homeRoute {
    switch (this) {
      case UserType.user:
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
      case "user":
        return UserType.user;
      case "ministry":
        return UserType.ministry;
      case "hospital":
        return UserType.hospital;
      default:
        return UserType.user;
    }
  }
}
