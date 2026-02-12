import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/widgets/base_stateful_screen_widget.dart';
import 'package:organ_link/features/hospital_flow/widget/container_with_background.dart';
import 'package:organ_link/features/hospital_flow/widget/app_base_body_scaffold.dart';
import 'package:organ_link/features/hospital_flow/widget/app_search_custom_widget.dart';
import 'package:organ_link/features/hospital_flow/widget/status_row_widget.dart';
import 'package:organ_link/features/ministry_flow/widgets/title_and_subtitle_custom_widget.dart';
import 'package:organ_link/features/widgets/app_buttons/app_button_with_gradient_colors.dart';
import 'package:organ_link/features/widgets/container_with_shadow.dart';
import 'package:organ_link/features/widgets/text_field/custom_drop_down_form_filed_widget.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';

class ViewPatientScreen extends BaseStatefulScreenWidget {
  const ViewPatientScreen({super.key});
  static const routeName = "/view-patient-screen";

  @override
  BaseScreenState<BaseStatefulScreenWidget> baseScreenCreateState() =>
      _ViewPatientScreenState();
}

class _ViewPatientScreenState extends BaseScreenState<ViewPatientScreen> {
  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: _buildBody(),
    );
  }
  ///////////////////////////////////////////////////////////
  /////////////////// Helper widget ////////////////////////
  ///////////////////////////////////////////////////////////

  Widget _buildBody() {
    return AppBaseBodyScaffold(
      titleOfScreen: LocalizationKeys.patientTitle,
      backTap: () {
        Navigator.pop(context);
      },
      body: Column(
        children: [
          _searchSection(),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Text(
                    "${context.translate(LocalizationKeys.patients)} (6)",

                    /// conut==> 6 from back and text patients changes based on pateint or donor
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.blackText,
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(childCount: 5, (
                    context,
                    index,
                  ) {
                    return _cardItem();
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardItem() {
    return ContainerWithShadow(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 2),
      contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _nameAndId(name: "أحمد محمد العلي", id: "100p"),
          _infoRow(age: '12', bloodType: 'A+', organ: 'كلي'),
          StatusRowWidget(priority: "أولوية عالية", status: "جاهز"),
          SizedBox(height: 16.h),
          AppButtonWithGradientColors(
            text: context.translate(LocalizationKeys.details),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _infoRow({
    required String age,
    required String bloodType,
    required String organ,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h, bottom: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _infoRowText(
            text:
                "${context.translate(LocalizationKeys.age)}: $age ${context.translate(LocalizationKeys.year)}",
          ),
          _infoRowText(
            text:
                "${context.translate(LocalizationKeys.bloodType)}: $bloodType",
          ),
          _infoRowText(
            text: "${context.translate(LocalizationKeys.organ)}: $organ",
          ),
        ],
      ),
    );
  }

  Widget _infoRowText({required String text}) {
    return Text(
      text,
      style: context.textTheme.labelMedium!.copyWith(color: AppColors.grayText),
    );
  }

  Widget _nameAndId({required String name, required String id}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          name,
          style: context.bodyMedium!.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(width: 16.w),
        ContainerWithBackground(
          backgroundColor: AppColors.idContainerBG,
          text: id,
        ),
      ],
    );
  }

  Widget _searchSection() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TitleAndSubtitleCustomWidget(
          title: context.translate(LocalizationKeys.patientList),
          subTitle: context.translate(
            LocalizationKeys.transplantPatientsManagement,
          ),
        ),
        SizedBox(height: 16.h),
        AppSearchCustomWidget(
          hintText: LocalizationKeys.searchByNameOrMRN,
          onChanged: (value) {},
        ),
        _searchByOrganOrCaseSection(),
      ],
    );
  }

  Widget _searchByOrganOrCaseSection() {
    return Padding(
      padding: EdgeInsets.only(top: 16.h, bottom: 24.h),
      child: Row(
        children: [
          _shadowContainer(
            child: CustomDropDownFormFiledWidget(
              hintText: context.translate(LocalizationKeys.allOrgans),
              itemTextStyle: context.textTheme.labelMedium!.copyWith(
                color: AppColors.blackText,
              ),
              items: [
                CustomDropDownItem(value: "كلي يمنى", key: "كلي"),
                CustomDropDownItem(value: "كلي يسرى", key: "كلي"),
                CustomDropDownItem(value: "كبد", key: "كبد"),
              ],
            ),
          ),
          SizedBox(width: 16.w),
          _shadowContainer(
            child: CustomDropDownFormFiledWidget(
              hintText: context.translate(LocalizationKeys.allCases),
              itemTextStyle: context.textTheme.labelMedium!.copyWith(
                color: AppColors.blackText,
              ),
              items: [
                CustomDropDownItem(value: "قيد المراجعه", key: ""),
                CustomDropDownItem(value: "جاهز", key: ""),
                CustomDropDownItem(value: "تمت المطابقة", key: ""),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _shadowContainer({required Widget child}) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
