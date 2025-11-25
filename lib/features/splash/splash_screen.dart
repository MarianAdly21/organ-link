import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/features/login/screen/login_screen.dart';
import 'package:organ_link/features/splash/widgets/wave_dots.dart';
import 'package:organ_link/preferences/preferences_manager.dart';
import 'package:organ_link/res/app_asset_paths.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';

enum Type { patient, donor, ministry, hospital }

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
          padding: const EdgeInsets.only(left: 88, right: 88, top: 140),
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
    if (type == Type.donor.name || type == Type.patient.name) {
    } else if (type == Type.ministry.name) {
    } else if (type == Type.hospital.name) {
    } else if (type == null) {
      _navigatorToLoginScreen();
    }
  }

  void _navigatorToLoginScreen() async {
    await Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }
}
