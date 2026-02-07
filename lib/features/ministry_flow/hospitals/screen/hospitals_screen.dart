import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/widgets/base_stateful_screen_widget.dart';
import 'package:organ_link/features/hospital_flow/widget/app_base_body_scaffold.dart';
import 'package:organ_link/features/hospital_flow/widget/app_search_custom_widget.dart';
import 'package:organ_link/features/hospital_flow/widget/container_with_background.dart';
import 'package:organ_link/features/ministry_flow/hospital_detailes/screen/hospital_details_screen.dart';
import 'package:organ_link/features/ministry_flow/hospitals/models/hospital_ui_model.dart';
import 'package:organ_link/features/ministry_flow/widgets/conut_container.dart';
import 'package:organ_link/features/ministry_flow/widgets/info_tile_with_status_custom_widget.dart';
import 'package:organ_link/features/ministry_flow/widgets/title_and_subtitle_custom_widget.dart';
import 'package:organ_link/features/widgets/app_buttons/app_button_with_gradient_colors.dart';
import 'package:organ_link/features/widgets/container_with_shadow.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';

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
        titleOfScreen: context.translate(LocalizationKeys.hospitals),
        backTap: () {
          Navigator.pop(context);
        },
        body: Column(children: [_searchSection(), _buildHospitalList()]),
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper widget ////////////////////////
  ///////////////////////////////////////////////////////////
  Widget _searchSection() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TitleAndSubtitleCustomWidget(
          title: context.translate(LocalizationKeys.participatingHospitalsList),
          subTitle:
              "${context.translate(LocalizationKeys.hospitalRegisteredInSystem)} 6 ",
        ),
        SizedBox(height: 16.h),
        AppSearchCustomWidget(
          hintText: context.translate(LocalizationKeys.searchforHospital),
          onChanged: (value) {},
        ),
      ],
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
                InfoTileWithStatusCustomWidget(
                  title: demoData[index].hospitalName,
                  status: demoData[index].hospitalState,
                  subtitle: demoData[index].city,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ConutContainer(
                        padding: EdgeInsetsDirectional.only(end: 16),
                        title: context.translate(LocalizationKeys.surgeries),
                        count: demoData[index].operationsCount.toString(),
                      ),
                      ConutContainer(
                        padding: EdgeInsetsDirectional.only(end: 16),
                        title: context.translate(LocalizationKeys.donors),
                        count: demoData[index].donorsCount.toString(),
                      ),
                      ConutContainer(
                        title: context.translate(LocalizationKeys.patients),
                        count: demoData[index].patientsCount.toString(),
                      ),
                    ],
                  ),
                ),
                _needsSection(organNeedModelList: demoData[index].organNeeds),
                AppButtonWithGradientColors(
                  text: context.translate(LocalizationKeys.details),
                  onTap: () {
                    Navigator.of(
                      context,
                    ).pushNamed(HospitalDetailsScreen.routeName);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _needsSection({required List<OrganNeedModel> organNeedModelList}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.translate(LocalizationKeys.needs),
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
      padding: EdgeInsets.symmetric(vertical: 8.h),
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

  // Widget _conutContainer({
  //   required String title,
  //   required String count,
  //   EdgeInsetsGeometry? padding,
  // }) {
  //   return Expanded(
  //     child: ContainerWithBlackShadow(
  //       padding: padding,
  //       body: Column(
  //         children: [
  //           Text(
  //             title,
  //             style: context.textTheme.labelMedium!.copyWith(
  //               color: Color(0xff575757),
  //               fontSize: 13,
  //               fontWeight: FontWeight.w400,
  //             ),
  //           ),
  //           Text(
  //             overflow: TextOverflow.visible,
  //             maxLines: 1,
  //             count,
  //             style: context.textTheme.bodyLarge,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _nameAndCityHospitalAndStatusRow({
  //   required String hospitalName,
  //   required String city,
  //   required String hospitalState,
  // }) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       Column(
  //         mainAxisSize: MainAxisSize.min,
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             hospitalName,
  //             style: context.textTheme.bodyMedium!.copyWith(
  //               fontSize: 16,
  //               fontWeight: FontWeight.w600,
  //               color: AppColors.blackText,
  //             ),
  //           ),
  //           Padding(
  //             padding: EdgeInsets.only(top: 8.h),
  //             child: Text(
  //               city,
  //               style: context.textTheme.labelMedium!.copyWith(
  //                 fontSize: 13,
  //                 fontWeight: FontWeight.w400,
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //       ContainerWithBackground(
  //         backgroundColor: AppColors.readyTextBG,
  //         text: hospitalState,
  //       ),
  //     ],
  //   );
  // }
}
