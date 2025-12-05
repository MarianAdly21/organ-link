import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/features/hospital_flow/widget/hospital_app_bar.dart';

class HospitalBaseBodyScaffold extends StatelessWidget {
  const HospitalBaseBodyScaffold({
    super.key,
    required this.body,
    required this.titleOfScreen,
    required this.backTap,
  });
  final Widget body;
  final String titleOfScreen;
  final void Function() backTap;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          HospitalAppBar(
            title: context.translate(titleOfScreen),
            backTap: backTap,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 38.h, horizontal: 16.w),
              child: body,
            ),
          ),
        ],
      ),
    );
  }
}
