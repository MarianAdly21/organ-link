import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/widgets/base_stateful_screen_widget.dart';
import 'package:organ_link/apis/_base/dio_api_manager.dart';
import 'package:organ_link/apis/managers/auth_api_manager.dart';
import 'package:organ_link/apis/models/auth/login/login_successful_response.dart';
import 'package:organ_link/features/shared_screens/enum/user_type.dart';
import 'package:organ_link/features/shared_screens/login/bloc/login_bloc.dart';
import 'package:organ_link/features/shared_screens/login/bloc/login_repository.dart';
import 'package:organ_link/features/widgets/app_buttons/app_button_with_gradient_colors.dart';
import 'package:organ_link/features/widgets/text_field/app_text_form_filed_widget.dart';
import 'package:organ_link/preferences/preferences_manager.dart';
import 'package:organ_link/res/app_asset_paths.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/feedback/feedback_message.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';
import 'package:organ_link/utils/validations/app_validate.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = "/login-screen";
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        LoginRepository(
          preferencesManager: GetIt.I<PreferencesManager>(),
          authApiManager: AuthApiManager(GetIt.I<DioApiManager>()),
        ),
      ),
      child: LoginScreenWithBloc(),
    );
  }
}

class LoginScreenWithBloc extends BaseStatefulScreenWidget {
  const LoginScreenWithBloc({super.key});
  @override
  BaseScreenState<BaseStatefulScreenWidget> baseScreenCreateState() =>
      _LoginScreenWithBlocState();
}

class _LoginScreenWithBlocState extends BaseScreenState<LoginScreenWithBloc>
    with AppValidate {
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String _idNumber;
  late String _password;
  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginLoadingState) {
            showLoading();
          } else {
            hideLoading();
          }
          if (state is LoginNotValidateState) {
            autovalidateMode = AutovalidateMode.always;
          } else if (state is LoginValidateState) {
            _loginEvent();
          } else if (state is LoginSuccessfullyState) {
            _saveUserInfoEvent(state.loginSuccessfulResponse);
          } else if (state is UserInfoSavedState) {
            _navToHomeScreenEvent();
          } else if (state is NavToHomeScreenState) {
            _navigateBasedOnUserType(state, context);
          } else if (state is LoginErrorState) {
            state.codeError == 1016
                ? showFeedbackMessage(
                    context: context,
                    feedbackStyle: FeedbackStyle.snackBar,
                    context.translate(LocalizationKeys.plzCheckInternet),
                  )
                : showFeedbackMessage(
                    context: context,
                    feedbackStyle: FeedbackStyle.snackBar,
                    state.errorMessage,
                  );
          }
        },
        child: buildLoginWidget(context),
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  //////////////////// Widget methods ///////////////////////
  ///////////////////////////////////////////////////////////

  Widget buildLoginWidget(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 64.h),
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
        onTap: () {
          _validateLoginEvent();
        },
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
  LoginBloc get currentBloc => context.read<LoginBloc>();

  void _idNumberSaved(String? value) {
    _idNumber = value!;
  }

  void _passwordSaved(String? value) {
    _password = value!;
  }

  void _saveUserInfoEvent(LoginSuccessfulResponse loginSuccessfulResponse) {
    currentBloc.add(
      SaveUserInfoEvent(loginSuccessfulResponse: loginSuccessfulResponse),
    );
    log("######### ${loginSuccessfulResponse.token}");
    log("######### ${loginSuccessfulResponse.id}");
    log("######### ${loginSuccessfulResponse.type}");
  }

  void _navToHomeScreenEvent() {
    currentBloc.add(NavToHomeScreenEvent());
  }

  void _loginEvent() {
    currentBloc.add(
      LoginWithIdNumberAndPasswordEvent(
        password: _password,
        identificationNumber: _idNumber,
      ),
    );
  }

  void _validateLoginEvent() {
    currentBloc.add(
      ValidateIdNumberAndPasswordEvent(loginFormKey: loginFormKey),
    );
  }

  // void _navigateBasedOnUserType(
  //   NavToHomeScreenState state,
  //   BuildContext context,
  // ) {
  //   final String type = state.type;
  //   if (type == UserType.donor.name || type == UserType.patient.name) {
  //     Navigator.of(
  //       context,
  //     ).pushNamedAndRemoveUntil(HomeUserScreen.routeName, ((route) => false));
  //   } else if (type == UserType.ministry.name) {
  //     Navigator.of(context).pushNamedAndRemoveUntil(
  //       MinistryHomeScreen.routeName,
  //       ((route) => false),
  //     );
  //   } else if (type == UserType.hospital.name) {
  //     Navigator.of(context).pushNamedAndRemoveUntil(
  //       HospitalDashboardScreen.routeName,
  //       ((route) => false),
  //     );
  //   }
  // }

  void _navigateBasedOnUserType(
    NavToHomeScreenState state,
    BuildContext context,
  ) {
    final userType = state.type.toUserType();

    Navigator.of(
      context,
    ).pushNamedAndRemoveUntil(userType.homeRoute, (route) => false);
  }
}
