import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organ_link/features/user_flow/home/widget/custom_app_bar_widget.dart';

class BaseBodyScaffold extends StatelessWidget {
  const BaseBodyScaffold({
    super.key,
    required this.title,
    required this.onBackTap,
    required this.body,
  });
  final String title;
  final void Function() onBackTap;
  final Widget body;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 48.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomAppBarWidget(title: title, onTap: onBackTap),
            Expanded(child: SingleChildScrollView(child: body)),
          ],
        ),
      ),
    );
  }
}
