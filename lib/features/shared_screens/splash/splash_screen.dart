import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/features/hospital_flow/hospital_dashboard/screen/hospital_dashboard_screen.dart';
import 'package:organ_link/features/ministry_flow/ministry_home/screen/ministry_home_screen.dart';
import 'package:organ_link/features/shared_screens/enum/user_type.dart';
import 'package:organ_link/features/shared_screens/login/screen/login_screen.dart';
import 'package:organ_link/features/shared_screens/splash/widgets/wave_dots.dart';
import 'package:organ_link/features/user_flow/home/screen/home_user_screen.dart';
import 'package:organ_link/preferences/preferences_manager.dart';
import 'package:organ_link/res/app_asset_paths.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String routeName = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var preferencesManager = GetIt.I<PreferencesManager>();
  Timer? time;
  @override
  void initState() {
    super.initState();
    _startTime();
  }

  @override
  void dispose() {
    time?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 88.w, right: 88.w, top: 140.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(150),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadowForLogo.withAlpha(40),
                      blurRadius: 40.r,
                      spreadRadius: 20.r,
                    ),
                  ],
                ),
                child: SvgPicture.asset(AppAssetPaths.logo),
              ),
              SizedBox(height: 38.h),
              Text(
                textAlign: TextAlign.center,
                "OrganLink",
                style: context.textTheme.bodyLarge!.copyWith(fontSize: 24),
              ),
              SizedBox(height: 24.h),
              Text(
                textAlign: TextAlign.center,
                context.translate(
                  LocalizationKeys.organDonationManagementSystem,
                ),
                style: context.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.grayText,
                ),
              ),
              SizedBox(height: 53.h),
              Center(child: WaveDots()),
            ],
          ),
        ),
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper methods ////////////////////////
  ///////////////////////////////////////////////////////////
  Future<Timer> _startTime() async {
    final duration = const Duration(seconds: 3);
    return Timer(duration, _navigationPage);
  }

  Future<void> _navigationPage() async {
    final String? type = await preferencesManager.getType();
    // if(type !=null){
    // final userType = UserType.values.byName(type);
    // }
    if (type == UserType.user.name) {
      _navToHomeUserScreen();
    } else if (type == UserType.ministry.name) {
      _navToMinistryHomeScreen();
    } else if (type == UserType.hospital.name) {
      _navToHospitalHomeScreen();
    } else if (type == null) {
      _navigatorToLoginScreen();
    }
  }

  void _navToHospitalHomeScreen() {
    Navigator.of(context).pushNamed(HospitalDashboardScreen.routeName);
  }

  void _navToMinistryHomeScreen() {
    Navigator.of(context).pushReplacementNamed(MinistryHomeScreen.routeName);
  }

  void _navToHomeUserScreen() {
    Navigator.of(context).pushReplacementNamed(HomeUserScreen.routeName);
  }

  void _navigatorToLoginScreen() {
    Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
  }
}
