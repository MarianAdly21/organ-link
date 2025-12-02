import 'package:flutter/material.dart';
import 'package:organ_link/_core/widgets/base_stateful_screen_widget.dart';
import 'package:organ_link/features/user_flow/notification/widget/notification_item.dart';
import 'package:organ_link/features/user_flow/widget/base_body_scaffold.dart';
import 'package:organ_link/res/app_colors.dart';

class NotificationScreen extends BaseStatefulScreenWidget {
  const NotificationScreen({super.key});

  @override
  BaseScreenState<BaseStatefulScreenWidget> baseScreenCreateState() =>
      _NotificationScreenState();
}

class _NotificationScreenState extends BaseScreenState<NotificationScreen> {
  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: BaseBodyScaffold(
        title: "Notification",
        onBackTap: () {},
        body: Column(
          children: [
            NotificationItem(
              color: AppColors.notificationItemBG,
              title: "تحديث من المستشفي ",
              content: "تم إجراء الفحوصات المطلوبة بنجاح. في انتظار النتائج.",
            ),
            NotificationItem(
              color: AppColors.notificationImportantItemBG,
              title: "تحديث من المستشفي ",
              content: "تم إجراء الفحوصات المطلوبة بنجاح. في انتظار النتائج.",
            ),
          ],
        ),
      ),
    );
  }
}
