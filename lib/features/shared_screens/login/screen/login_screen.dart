import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/widgets/base_stateful_screen_widget.dart';
import 'package:organ_link/features/widgets/app_buttons/app_button_with_gradient_colors.dart';
import 'package:organ_link/features/widgets/text_field/app_text_form_filed_widget.dart';
import 'package:organ_link/res/app_asset_paths.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';
import 'package:organ_link/utils/validations/app_validate.dart';

class LoginScreen extends BaseStatefulScreenWidget {
  const LoginScreen({super.key});
  static const routName = "/login-screen";

  @override
  BaseScreenState<BaseStatefulScreenWidget> baseScreenCreateState() =>
      _LoginScreenState();
}

class _LoginScreenState extends BaseScreenState<LoginScreen> with AppValidate {
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String _idNumber;
  late String _password;
  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: buildLoginWidget(context),
    );
  }

  ///////////////////////////////////////////////////////////
  //////////////////// Widget methods ///////////////////////
  ///////////////////////////////////////////////////////////

  Widget buildLoginWidget(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 64),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(AppAssetPaths.logo, width: 96.w, height: 96.h),
              SizedBox(height: 37.h),
              Text(
                textAlign: TextAlign.center,
                context.translate(LocalizationKeys.login),
                style: context.textTheme.bodyLarge!.copyWith(
                  color: AppColors.blackText,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                textAlign: TextAlign.center,
                context.translate(LocalizationKeys.useYourIdentificationNumber),
                style: context.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.grayText,
                ),
              ),
              SizedBox(height: 48.h),
              _loginFormWidget(),
              SizedBox(height: 48.h),
              _loginButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginButton() {
    return Flexible(
      child: AppButtonWithGradientColors(
        onTap: () {},
        text: context.translate(LocalizationKeys.login),
      ),
    );
  }

  Widget _loginFormWidget() {
    return Form(
      key: loginFormKey,
      autovalidateMode: autovalidateMode,
      child: Column(
        children: [
          AppTextFormField(
            title: context.translate(LocalizationKeys.identificationNumber),
            onSaved: _idNumberSaved,
            validator: (value) => textValidator(context, value),
            //textInputAction: TextInputAction.next,
          ),
          SizedBox(height: 8.h),
          AppTextFormField(
            title: context.translate(LocalizationKeys.password),
            onSaved: _passwordSaved,
            validator: (value) => textValidator(context, value),
          ),
        ],
      ),
    );
  }
  ///////////////////////////////////////////////////////////
  //////////////////// Helper methods ///////////////////////
  ///////////////////////////////////////////////////////////

  void _idNumberSaved(String? value) {
    _idNumber = value!;
  }

  void _passwordSaved(String? value) {
    _password = value!;
  }
}
