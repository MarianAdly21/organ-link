import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/widgets/base_stateful_screen_widget.dart';
import 'package:organ_link/features/hospital_flow/widget/app_base_body_scaffold.dart';
import 'package:organ_link/features/ministry_flow/widgets/custom_ministry_form_widget.dart';
import 'package:organ_link/features/widgets/app_buttons/app_button_with_gradient_colors.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';

class AddNewUserScreen extends BaseStatefulScreenWidget {
  const AddNewUserScreen({super.key});
  static const routeName = "/add-new-user-screen";
  @override
  BaseScreenState<BaseStatefulScreenWidget> baseScreenCreateState() =>
      _AddNewUserScreenState();
}

class _AddNewUserScreenState extends BaseScreenState<AddNewUserScreen> {
  late String _fullName;
  late String _phoneNumber;
  late String _email;
  late String _position;
  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: AppBaseBodyScaffold(
        titleOfScreen: "إضافة مستخدم",
        backTap: () {
          Navigator.pop(context);
        },
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Column(children: [_formSection()]);
  }

  Widget _formSection() {
    return Column(
      children: [
        CustomMinistryFormWidget(
          fullNameTitle: LocalizationKeys.fullName,
          fullNameHint: context.translate(LocalizationKeys.enterFullName),
          phoneTitle: LocalizationKeys.phoneNumber,
          phoneHint: context.translate(LocalizationKeys.enterPhoneNumber),
          emailTitle: LocalizationKeys.email,
          emailHint: context.translate(LocalizationKeys.enterEmail),
          positionTitle: LocalizationKeys.position,
          positionHint: context.translate(LocalizationKeys.whatIsYourPosition),
          onChangedFullName: (value) {
            _fullName = value;
          },
          onChangedPhone: (value) {
            _phoneNumber = value;
          },
          onChangedEmail: (value) {
            _email = value;
          },
          onChangedPosition: (value) {
            _position = value;
          },
        ),

        Padding(
          padding: EdgeInsets.only(top: 16.h),
          child: Row(
            children: [
              Expanded(
                child: AppButtonWithGradientColors(
                  onTap: () {},
                  text: context.translate(LocalizationKeys.addNewUser),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: AppButtonWithGradientColors(
                  onTap: () {},
                  text: context.translate(LocalizationKeys.cancel),
                  textColor: AppColors.blackText,
                  border: BoxBorder.all(color: AppColors.backButtonBorder),
                  colors: [
                    AppColors.followUpInvestigation,
                    AppColors.followUpInvestigation,
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
