import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/widgets/base_stateful_screen_widget.dart';
import 'package:organ_link/features/hospital_flow/widget/app_base_body_scaffold.dart';
import 'package:organ_link/features/hospital_flow/widget/app_search_custom_widget.dart';
import 'package:organ_link/features/hospital_flow/widget/container_with_background.dart';
import 'package:organ_link/features/ministry_flow/hospitals/models/hospital_ui_model.dart';
import 'package:organ_link/features/widgets/app_buttons/app_button_with_gradient_colors.dart';
import 'package:organ_link/features/widgets/container_with_black_shadow.dart';
import 'package:organ_link/features/widgets/container_with_shadow.dart';
import 'package:organ_link/res/app_colors.dart';

class HospitalsScreen extends BaseStatefulScreenWidget {
  const HospitalsScreen({super.key});
  static const routeName = "/hospitals-screen";

  @override
  BaseScreenState<BaseStatefulScreenWidget> baseScreenCreateState() =>
      _HospitalsScreenState();
}

class _HospitalsScreenState extends BaseScreenState<HospitalsScreen> {
  final List<HospitalUiModel> demoData = [
    HospitalUiModel(
      hospitalName: "مستشفى القاهرة التخصصي",
      hospitalState: "نشط",
      city: "القاهرة",
      patientsCount: 775,
      donorsCount: 168,
      operationsCount: 1934,
      organNeeds: [
        OrganNeedModel(organName: "كلي", count: 5),
        OrganNeedModel(organName: "كبد", count: 5),
        OrganNeedModel(organName: "رئة", count: 5),
        OrganNeedModel(organName: "كلي", count: 5),
      ],
    ),
    HospitalUiModel(
      hospitalName: "مستشفى القاهرة التخصصي",
      hospitalState: "نشط",
      city: "القاهرة",
      patientsCount: 775,
      donorsCount: 168,
      operationsCount: 1934,
      organNeeds: [
        OrganNeedModel(organName: "كلي", count: 5),
        OrganNeedModel(organName: "كبد", count: 5),
        OrganNeedModel(organName: "رئة", count: 5),
        OrganNeedModel(organName: "كلي", count: 5),
      ],
    ),
  ];
  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: AppBaseBodyScaffold(
        titleOfScreen: "المستشفيات",
        backTap: () {
          Navigator.pop(context);
        },
        body: Column(children: [_searchSection(), _buildHospitalList()]),
      ),
    );
  }

  Widget _buildHospitalList() {
    return Expanded(
      child: ListView.builder(
        itemCount: demoData.length,
        itemBuilder: (context, index) {
          return ContainerWithShadow(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            contentPadding: EdgeInsets.symmetric(
              vertical: 16.h,
              horizontal: 16.w,
            ),
            child: Column(
              children: [
                _nameAndCityHospitalAndStatusRow(
                  hospitalName: demoData[index].hospitalName,
                  hospitalState: demoData[index].hospitalState,
                  city: demoData[index].city,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _conutContainer(
                        padding: EdgeInsetsDirectional.only(end: 16),
                        title: "العمليات",
                        count: demoData[index].operationsCount.toString(),
                      ),
                      _conutContainer(
                        padding: EdgeInsetsDirectional.only(end: 16),
                        title: "المتبرعون",
                        count: demoData[index].donorsCount.toString(),
                      ),
                      _conutContainer(
                        title: "المرضى",
                        count: demoData[index].patientsCount.toString(),
                      ),
                    ],
                  ),
                ),
                _needsSection(organNeedModelList: demoData[index].organNeeds),
                AppButtonWithGradientColors(text: "التفاصيل", onTap: () {}),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _needsSection({required List<OrganNeedModel> organNeedModelList}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "الاحتياجات",
            style: context.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          _organNeedCountRow(
            organNeedModel1: organNeedModelList[0],
            color1: Color(0xff8DBAFF),
            organNeedModel2: organNeedModelList[1],
            color2: Color(0xff89FFB9),
          ),
          _organNeedCountRow(
            organNeedModel1: organNeedModelList[2],
            color1: Color(0xff89FFB9),
            organNeedModel2: organNeedModelList[3],
            color2: Color(0xffFF7A7D),
          ),
        ],
      ),
    );
  }

  Widget _organNeedCountRow({
    required OrganNeedModel organNeedModel1,
    required OrganNeedModel organNeedModel2,
    required Color color1,
    required Color color2,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          _organNeedCount(
            organNameAndConut:
                " ${organNeedModel1.organName}: ${organNeedModel1.count}",
            backgroundColor: color1,
          ),
          SizedBox(width: 16),
          _organNeedCount(
            organNameAndConut:
                " ${organNeedModel2.organName}: ${organNeedModel2.count}",
            backgroundColor: color2,
          ),
        ],
      ),
    );
  }

  Widget _organNeedCount({
    required String organNameAndConut,
    required Color backgroundColor,
  }) {
    return Expanded(
      child: ContainerWithBackground(
        contentPadding: EdgeInsets.symmetric(vertical: 8.h),
        isCentered: true,
        backgroundColor: backgroundColor,
        text: organNameAndConut,
        textStyle: context.textTheme.titleMedium!.copyWith(
          fontSize: 14,
          color: AppColors.blackText,
        ),
      ),
    );
  }

  Widget _conutContainer({
    required String title,
    required String count,
    EdgeInsetsGeometry? padding,
  }) {
    return Expanded(
      child: ContainerWithBlackShadow(
        padding: padding,
        body: Column(
          children: [
            Text(
              title,
              style: context.textTheme.labelMedium!.copyWith(
                color: Color(0xff575757),
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              overflow: TextOverflow.visible,
              maxLines: 1,
              count,
              style: context.textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  Widget _nameAndCityHospitalAndStatusRow({
    required String hospitalName,
    required String city,
    required String hospitalState,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              hospitalName,
              style: context.textTheme.bodyMedium!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.blackText,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Text(
                city,
                style: context.textTheme.labelMedium!.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        ContainerWithBackground(
          backgroundColor: AppColors.readyTextBG,
          text: hospitalState,
        ),
      ],
    );
  }

  Widget _searchSection() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          context.translate("قائمة المستشفيات المشاركة"),
          style: context.textTheme.bodyLarge!.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8),
        Text(
          context.translate("6 مستشفى مسجل في النظام"),

          /// 6 is changed when get hospital list
          style: context.textTheme.labelMedium!.copyWith(
            color: AppColors.grayText,
          ),
        ),
        SizedBox(height: 16.h),
        AppSearchCustomWidget(
          hintText: "البحث عن مستشفى...",
          onChanged: (value) {},
        ),
      ],
    );
  }
}
