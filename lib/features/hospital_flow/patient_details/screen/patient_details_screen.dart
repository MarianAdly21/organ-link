import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/widgets/base_stateful_screen_widget.dart';
import 'package:organ_link/features/hospital_flow/patient_details/widget/gradient_text.dart';
import 'package:organ_link/features/hospital_flow/widget/container_with_background.dart';
import 'package:organ_link/features/hospital_flow/widget/app_base_body_scaffold.dart';
import 'package:organ_link/features/hospital_flow/widget/status_row_widget.dart';
import 'package:organ_link/features/widgets/app_buttons/app_buttons.dart';
import 'package:organ_link/features/widgets/container_with_shadow.dart';
import 'package:organ_link/features/widgets/custom_divider_widget.dart';
import 'package:organ_link/features/widgets/data_row_with_divider.dart';
import 'package:organ_link/features/widgets/data_section.dart';
import 'package:organ_link/res/app_asset_paths.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';
import 'package:timelines_plus/timelines_plus.dart';

class PatientDetailsScreen extends BaseStatefulScreenWidget {
  const PatientDetailsScreen({super.key});
  static const routeName = "/patient-details-screen";
  @override
  BaseScreenState<BaseStatefulScreenWidget> baseScreenCreateState() =>
      _PatientDetailsScreenState();
}

class _PatientDetailsScreenState extends BaseScreenState<PatientDetailsScreen> {
  List demo = ["السكري من النوع الثاني", "ارتفاع ضغط الدم", "فشل كلوي مزمن"];

  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: AppBaseBodyScaffold(
        titleOfScreen: context.translate(LocalizationKeys.patientDetails),
        backTap: () {},
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _headerInfoWidget(),
          DataSection(
            title: context.translate(LocalizationKeys.personalInformation),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: AppColors.blackText,
            ),
            body: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomDividerWidget(verticalPadding: 8),
                SizedBox(height: 8.h),
                DataRowWithDivider(
                  divider: true,
                  title: context.translate(LocalizationKeys.fullName),
                  subTitle: "أحمد محمد العلي",
                ),
                DataRowWithDivider(
                  divider: true,
                  title: context.translate(LocalizationKeys.age),
                  subTitle: "45 سنة",
                ),
                DataRowWithDivider(
                  divider: true,
                  title: context.translate(LocalizationKeys.type),
                  subTitle: "ذكر",
                ),
                DataRowWithDivider(
                  divider: true,
                  title: context.translate(LocalizationKeys.bloodType),
                  subTitle: "A+",
                ),
                DataRowWithDivider(
                  divider: true,
                  title: context.translate(LocalizationKeys.phoneNumber),
                  subTitle: "0125579000",
                ),
                DataRowWithDivider(
                  divider: true,
                  title: context.translate(LocalizationKeys.email),
                  subTitle: "ahmed@example.com",
                ),
                DataRowWithDivider(
                  title: context.translate(LocalizationKeys.city),
                  subTitle: "العاشر من رمضان",
                ),
              ],
            ),
          ),
          DataSection(
            paddingAroundContainer: EdgeInsets.zero,
            title: context.translate(LocalizationKeys.medicalInformation),
            body: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      context.translate(LocalizationKeys.medicalInformation),
                    ),

                    ///this text changes based on the type of user
                    ContainerWithBackground(
                      backgroundColor: AppColors.readyTextBG,
                      text: "الكلي",
                      textColor: AppColors.readyText,
                    ),
                  ],
                ),
                CustomDividerWidget(verticalPadding: 24.h),
                _infoSection(
                  title: context.translate(LocalizationKeys.medicalHistory),
                  list: demo,
                ),
                _infoSection(
                  title: context.translate(LocalizationKeys.allergies),
                  list: demo,
                ),
                _infoSection(
                  title: context.translate(LocalizationKeys.currentMedications),
                  list: demo,
                  divider: false,
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          _vitalSigns(),
          DataSection(
            title: context.translate(LocalizationKeys.reportAndInvestigations),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ///هيكرر ع اساس التحاليل المرفوعه
                ContainerWithShadow(
                  // height: 75.h,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 16.h,
                    horizontal: 17.w,
                  ),
                  padding: EdgeInsets.zero,
                  background: AppColors.reportContainerBG,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "تحليل الدم الكامل",
                            style: context.textTheme.bodyMedium!.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 13.h),
                          Text(
                            "2025-03-20",
                            style: context.textTheme.labelMedium,
                          ),
                        ],
                      ),
                      ContainerWithBackground(
                        backgroundColor: AppColors.readyTextBG,
                        text: "تحاليل",
                      ),
                    ],
                  ),
                ),
                ContainerWithShadow(
                  // height: 75.h,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 16.h,
                    horizontal: 17.w,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  background: AppColors.reportContainerBG,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "تحليل الدم الكامل",
                            style: context.textTheme.bodyMedium!.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 13.h),
                          Text(
                            "2025-03-20",
                            style: context.textTheme.labelMedium,
                          ),
                        ],
                      ),
                      ContainerWithBackground(
                        backgroundColor: AppColors.readyTextBG,
                        text: "تحاليل",
                      ),
                    ],
                  ),
                ),
                _addReportBtn(),
              ],
            ),
          ),
          DataSection(
            paddingAroundContainer: EdgeInsets.only(bottom: 24.h),
            title: context.translate(LocalizationKeys.caseRecord),
            body: Column(
              children: [CustomDividerWidget(), _myTimeLineColumn()],
            ),
          ),
        ],
      ),
    );
  }

  Widget _myTimeLineColumn() {
    return Column(
      children: [
        _timeLineItem(
          isDone: false,
          text: "تم تجهيز المريض للمطابقة",
          doneDate: "من 10:30 - 2025-02-05",
          isLast: true,
        ),

        _timeLineItem(
          isDone: true,
          text: "رفع التحاليل الشاملة",
          doneDate: "من 10:30 - 2025-02-05",
          isLast: true,
          isFirst: true,
        ),
        _timeLineItem(
          isDone: true,
          text: "تسجيل المريض",
          doneDate: "من 10:30 - 2025-02-05",
          isFirst: true,
        ),
      ],
    );
  }

  Widget _timeLineItem({
    required String doneDate,
    required String text,
    required bool isDone,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return TimelineTile(
      nodeAlign: TimelineNodeAlign.start,
      contents: SizedBox(
        height: 90.h,
        child: Padding(
          padding: const EdgeInsetsDirectional.only(start: 28),
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  text,
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  doneDate,
                  style: context.textTheme.labelMedium!.copyWith(
                    color: AppColors.personalInfoText,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      node: TimelineNode(
        indicator: DotIndicator(
          color: AppColors.timelineNode,
          size: 24,
          child: isDone ? Icon(Icons.done, color: AppColors.mainColor) : null,
        ),
        startConnector: isFirst
            ? SolidLineConnector(
                color: isDone ? AppColors.mainColor : AppColors.lineConnector,
              )
            : null,
        endConnector: isLast
            ? SolidLineConnector(
                color: isDone ? AppColors.mainColor : AppColors.lineConnector,
              )
            : null,
      ),
    );
  }

  Widget _addReportBtn() {
    return DottedBorder(
      childOnTop: false,
      options: RoundedRectDottedBorderOptions(
        radius: Radius.circular(16),
        dashPattern: [6, 6],
        gradient: LinearGradient(
          colors: [AppColors.mainColor, AppColors.seconderColor],
        ),
      ),
      child: AppElevatedButton(
        onPressed: () {},
        color: Colors.white,
        label: Center(
          child: GradientText(
            text: context.translate(LocalizationKeys.addNewReport),
          ),
        ),
      ),
    );
  }

  Widget _vitalSigns() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          context.translate(LocalizationKeys.vitalSigns),
          style: TextStyle(
            color: AppColors.textColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 16.h),
        Column(
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _vitalSignCard(
                  context,
                  icon: AppAssetPaths.dropOfBloodIcon,
                  vitalName: context.translate(
                    LocalizationKeys.respiratoryRate,
                  ),
                  reading: "12 - 20 / دقيقة",
                ),
                SizedBox(width: 16.w),
                _vitalSignCard(
                  context,
                  icon: AppAssetPaths.injectionIcon,
                  vitalName: context.translate(LocalizationKeys.bloodPressure),
                  reading: "120/80",
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: _vitalSignCard(
                context,
                icon: AppAssetPaths.temperatureIcon,
                vitalName: context.translate(LocalizationKeys.temperature),
                reading: "37.0 C",
              ),
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _vitalSignCard(
                  context,
                  icon: AppAssetPaths.scaleWeightIcon,
                  vitalName: context.translate(LocalizationKeys.heartRate),
                  reading: "60 - 80 / دقيقة",
                ),
                SizedBox(width: 16.w),
                _vitalSignCard(
                  context,
                  icon: AppAssetPaths.fitToHeightIcon,
                  vitalName: context.translate(
                    LocalizationKeys.oxygenSaturation,
                  ),
                  reading: "95 - 100 %",
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _vitalSignCard(
    BuildContext context, {
    required String vitalName,
    required String reading,
    required String icon,
  }) {
    return Container(
      height: 122.h,
      width: 163.w,
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            blurStyle: BlurStyle.outer,
            blurRadius: 8,
            color: Colors.black.withValues(alpha: 0.15),
          ),
        ],
        color: AppColors.homeCardBG.withValues(alpha: 0.45),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(child: SvgPicture.asset(icon)),
          SizedBox(height: 8.h),
          Expanded(
            child: Text(
              reading,
              style: context.textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w600,

                fontSize: 16,
              ),
            ),
          ),
          SizedBox(height: 4.h),
          Expanded(
            child: Text(
              vitalName,
              style: context.textTheme.labelMedium!.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoSection({
    required String title,
    required List list,
    bool divider = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppColors.textColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: List.generate(list.length, (index) {
            return _dotWithText(text: list[index]);
          }),
        ),
        divider
            ? CustomDividerWidget(endIndent: 24.w, indent: 24.w)
            : SizedBox.shrink(),
      ],
    );
  }

  Widget _dotWithText({required String text}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8.w,
            height: 8.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.personalInfoText,
            ),
          ),
          SizedBox(width: 16),
          Text(
            text,
            style: context.textTheme.labelMedium!.copyWith(
              color: AppColors.personalInfoText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _headerInfoWidget() {
    return ContainerWithShadow(
      padding: EdgeInsets.zero,
      // height: 118.h,
      contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      child: Column(
        children: [
          Text(
            "أحمد محمد العلي",
            style: context.textTheme.bodyMedium!.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.h, bottom: 16.h),
            child: Text(
              "${context.translate(LocalizationKeys.fileNumber)} 12345",
              style: context.textTheme.labelMedium!.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          StatusRowWidget(priority: "أولوية عالية", status: "جاهز"),
        ],
      ),
    );
  }
}
