import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/widgets/base_stateful_screen_widget.dart';
import 'package:organ_link/features/hospital_flow/notification_screen/model/notification_ui_model.dart';
import 'package:organ_link/features/hospital_flow/notification_screen/widget/notification_filter_bar.dart';
import 'package:organ_link/features/hospital_flow/widget/container_with_background.dart';
import 'package:organ_link/features/hospital_flow/widget/hospital_base_body_scaffold.dart';
import 'package:organ_link/features/widgets/container_with_shadow.dart';
import 'package:organ_link/features/widgets/custom_divider_widget.dart';
import 'package:organ_link/features/widgets/custom_over_view_container.dart';
import 'package:organ_link/res/app_asset_paths.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';

class HospitalNotificationScreen extends BaseStatefulScreenWidget {
  const HospitalNotificationScreen({super.key});
  static const routeName = "/hospital-notification-screen";

  @override
  BaseScreenState<BaseStatefulScreenWidget> baseScreenCreateState() =>
      _HospitalNotificationScreenState();
}

class _HospitalNotificationScreenState
    extends BaseScreenState<HospitalNotificationScreen> {
  List<NotificationUiModel> notificationList = [
    NotificationUiModel(
      title: "نتيجة مطابقة جديدة",
      subTitleitle:
          "تم العثور على متبرع متطابق للمريض أحمد محمد العلي بنسبة توافق جيدة",
      isUrgent: true,
    ),
  ];
  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: HospitalBaseBodyScaffold(
        titleOfScreen: context.translate(LocalizationKeys.notificationScreen),
        backTap: () {
          Navigator.pop(context);
        },
        padding: EdgeInsets.symmetric(vertical: 24.h),
        body: Column(
          children: [
            _headerWidget(),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper widget ////////////////////////
  ///////////////////////////////////////////////////////////

  Widget _headerWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                context.translate(LocalizationKeys.allAlerts),
                style: context.textTheme.bodyMedium,
              ),
              Text(
                context.translate(LocalizationKeys.organTransplantTracking),
                style: context.textTheme.labelMedium,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 24.h),
          child: Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomOverViewContainer(
                  backgroundColor: Color(0xffFFF2DC),
                  width: 100.w,
                  text: context.translate(LocalizationKeys.urgent),
                  count: "10",
                ),
                CustomOverViewContainer(
                  backgroundColor: Color(0xffDEFFDF),
                  width: 100.w,
                  text: context.translate(LocalizationKeys.unread),
                  count: "5",
                ),
                CustomOverViewContainer(
                  backgroundColor: Color(0xffE6F4FF),
                  width: 100.w,
                  text: context.translate(LocalizationKeys.totalNotification),
                  count: "1",
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NotificationFilterBar(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Text(
                      context.translate(LocalizationKeys.notificationList),
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: AppColors.blackText,
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: notificationList.length,
                      (context, index) {
                        return _notificationItem(
                          title: notificationList[index].title,
                          subTitle: notificationList[index].subTitleitle,
                          isUrgent: notificationList[index].isUrgent,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _notificationItem({
    required String title,
    required String subTitle,
    required bool isUrgent,
  }) {
    return ContainerWithShadow(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      contentPadding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      subTitle,
                      style: TextStyle(
                        color: AppColors.grayText,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      overflow: TextOverflow.visible,
                    ),
                  ],
                ),
              ),
              if (isUrgent) ...[
                const SizedBox(width: 34),
                ContainerWithBackground(
                  backgroundColor: Color(0xffFFDADE),
                  text: "عاجل",
                  textColor: Color(0xffAD0000),
                ),
              ],
            ],
          ),

          CustomDividerWidget(),
          Row(
            children: [
              Text(
                "منذ 5 دقائق",
                style: TextStyle(
                  color: AppColors.grayText,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {},
                child: SvgPicture.asset(AppAssetPaths.deleteIcon),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () {},
                child: SvgPicture.asset(AppAssetPaths.doneIcon),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
