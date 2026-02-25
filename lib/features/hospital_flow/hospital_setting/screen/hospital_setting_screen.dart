import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/widgets/base_dialog_widget.dart';
import 'package:organ_link/_core/widgets/base_stateful_screen_widget.dart';
import 'package:organ_link/apis/_base/dio_api_manager.dart';
import 'package:organ_link/apis/managers/hospital_manager/hospital_api_manager.dart';
import 'package:organ_link/features/hospital_flow/hospital_setting/bloc/hospital_setting_bloc.dart';
import 'package:organ_link/features/hospital_flow/hospital_setting/bloc/hospital_setting_repository.dart';
import 'package:organ_link/features/hospital_flow/hospital_setting/model/hospital_information_setting_ui_model.dart';
import 'package:organ_link/features/hospital_flow/widget/container_with_background.dart';
import 'package:organ_link/features/hospital_flow/widget/app_base_body_scaffold.dart';
import 'package:organ_link/features/ministry_flow/widgets/title_and_subtitle_custom_widget.dart';
import 'package:organ_link/features/shared_screens/log_out_confirmation/log_out_confirmationDialog_screen.dart';
import 'package:organ_link/features/widgets/app_buttons/app_button_with_gradient_colors.dart';
import 'package:organ_link/features/widgets/container_with_shadow.dart';
import 'package:organ_link/features/widgets/custom_divider_widget.dart';
import 'package:organ_link/features/widgets/data_row_with_divider.dart';
import 'package:organ_link/features/widgets/data_section.dart';
import 'package:organ_link/features/widgets/internet_error_widget.dart';
import 'package:organ_link/features/widgets/log_out_Widget.dart';
import 'package:organ_link/features/widgets/text_field/app_text_form_filed_widget.dart';
import 'package:organ_link/preferences/preferences_manager.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/empty/empty_widgets.dart';
import 'package:organ_link/utils/feedback/feedback_message.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';
import 'package:organ_link/utils/locale/locale_cubit.dart';

class HospitalSettingScreen extends StatelessWidget {
  const HospitalSettingScreen({super.key});
  static const routeName = "/hospital-setting";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HospitalSettingBloc(
        HospitalSettingRepository(
          hospitalApiManager: HospitalApiManager(
            dioApiManager: GetIt.I<DioApiManager>(),
          ),
          preferencesManager: GetIt.I<PreferencesManager>(),
        ),
      ),
      child: HospitalSettingScreenWithBloc(),
    );
  }
}

class HospitalSettingScreenWithBloc extends BaseStatefulScreenWidget {
  const HospitalSettingScreenWithBloc({super.key});
  @override
  BaseScreenState<BaseStatefulScreenWidget> baseScreenCreateState() =>
      _HospitalSettingScreenWithBlocState();
}

class _HospitalSettingScreenWithBlocState
    extends BaseScreenState<HospitalSettingScreenWithBloc> {
  late HospitalInformationSettingUiModel hospitalInformationSettingUiModel;
  @override
  void initState() {
    _currentBloc.add(GetHospitalSettingDataEvent());
    super.initState();
  }

  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: AppBaseBodyScaffold(
        titleOfScreen: context.translate(LocalizationKeys.settings),
        backTap: () {
          Navigator.pop(context);
        },
        body: BlocConsumer<HospitalSettingBloc, HospitalSettingState>(
          listener: (context, state) {
            if (state is HospitalSettingLoadingState) {
              showLoading();
            } else {
              hideLoading();
            }
            if (state is HospitalSettingLoadedSuccessfullyState) {
              hospitalInformationSettingUiModel =
                  state.hospitalInformationSettingUiModel;
            } else if (state is HospitalSettingErrorState &&
                state.codeError != 1015) {
              showFeedbackMessage(state.errorMessage);
            }
          },
          buildWhen: (previous, current) =>
              current is HospitalSettingLoadedSuccessfullyState ||
              current is HospitalSettingErrorState,
          builder: (context, state) {
            return _buildBody(
              context,
              state,
              appLocale: context.appLocale.currentLocaleCode(),
            );
          },
        ),
      ),
    );
  }
  ///////////////////////////////////////////////////////////
  /////////////////// Helper widget ////////////////////////
  ///////////////////////////////////////////////////////////

  Widget _buildBody(
    BuildContext context,
    HospitalSettingState state, {
    required String appLocale,
  }) {
    if (state is HospitalSettingLoadedSuccessfullyState) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TitleAndSubtitleCustomWidget(
              title: context.translate(LocalizationKeys.settingsInformation),
              subTitle: context.translate(
                LocalizationKeys.manageHospitalAccountInfo,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _hospitalInfoSection(),
                  _systemInformation(),
                  DataSection(
                    title: context.translate(LocalizationKeys.language),
                    body: Column(
                      children: [
                        CustomDividerWidget(verticalPadding: 8),
                        SizedBox(height: 16.h),
                        _languageItemWidget(
                          appLocale: appLocale,
                          language: 'English',
                          locale: 'en',
                          onTap: _englishItemOnTap,
                        ),

                        _languageItemWidget(
                          appLocale: appLocale,
                          language: 'عربي',
                          locale: 'ar',
                          onTap: _arabicItemOnTap,
                        ),
                      ],
                    ),
                  ),
                  LogOutWidget(
                    onPressed: () {
                      _logoutConfirmation();
                    },
                    text: context.translate(LocalizationKeys.logout),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else if (state is HospitalSettingErrorState && state.codeError == 1015) {
      return InternetErrorWidget();
    } else {
      return EmptyWidget();
    }
  }

  Widget _systemInformation() {
    return ContainerWithShadow(
      borderSideColor: AppColors.seconderColor,
      padding: EdgeInsets.symmetric(vertical: 12.h),
      contentPadding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            context.translate(LocalizationKeys.systemInformation),
            style: context.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.blackText,
            ),
          ),
          CustomDividerWidget(),
          DataRowWithDivider(
            divider: true,
            title: context.translate(LocalizationKeys.appVersion),
            subTitle: "v2.5.0",
          ),
          DataRowWithDivider(
            divider: true,
            title: context.translate(LocalizationKeys.userId),
            subTitle: "KE",
          ),
          DataRowWithDivider(
            divider: true,
            title: context.translate(LocalizationKeys.lastUpdate),
            subTitle: "2025-02-10",
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.translate(LocalizationKeys.connectionStatus),
                style: context.textTheme.labelMedium!.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
              ContainerWithBackground(
                backgroundColor: AppColors.readyTextBG,
                text: "متصل",
                textColor: AppColors.readyText,
              ),
            ],
          ),
          SizedBox(height: 16.h),
          AppButtonWithGradientColors(
            text: context.translate(LocalizationKeys.details),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _hospitalInfoSection() {
    return ContainerWithShadow(
      padding: EdgeInsets.only(bottom: 24.h),
      contentPadding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            context.translate(LocalizationKeys.hospitalInformation),
            style: context.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            context.translate(LocalizationKeys.basicHospitalInfoMoh),
            style: context.textTheme.labelMedium!.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
          CustomDividerWidget(),
          _textField(
            title: context.translate(LocalizationKeys.hospitalName),
            hintText: hospitalInformationSettingUiModel.hospitalName,
          ),
          Row(
            children: [
              Flexible(
                child: Column(
                  children: [
                    _textField(
                      title: context.translate(
                        LocalizationKeys.registrationNumber,
                      ),
                      hintText: hospitalInformationSettingUiModel.licenseNumber,
                    ),
                    _textField(
                      title: context.translate(LocalizationKeys.numberOfBeds),
                      hintText: "HSP-2024-001",
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.w),
              Flexible(
                child: Column(
                  children: [
                    _textField(
                      title: context.translate(LocalizationKeys.city),
                      hintText: hospitalInformationSettingUiModel.hospitalCity,
                    ),
                    _textField(
                      isEnable: true,
                      title: context.translate(LocalizationKeys.phoneNumber),
                      hintText: hospitalInformationSettingUiModel.phone,
                    ),
                  ],
                ),
              ),
            ],
          ),
          _textField(
            isEnable: true,
            title: context.translate(LocalizationKeys.email),
            hintText: hospitalInformationSettingUiModel.email,
          ),
          Padding(
            padding: EdgeInsets.only(top: 16.h, bottom: 24.h),
            child: AppButtonWithGradientColors(
              text: context.translate(LocalizationKeys.saveChange),
              onTap: () {},
            ),
          ),
          _notice(),
        ],
      ),
    );
  }

  Widget _notice() {
    return ContainerWithBackground(
      isCentered: true,
      contentPadding: EdgeInsets.symmetric(vertical: 9.h, horizontal: 16.w),
      textColor: AppColors.notificationMainTitle,
      backgroundColor: AppColors.notificationImportantItemBG,
      text: context.translate(LocalizationKeys.mohNota),
    );
  }

  Widget _textField({
    bool? isEnable,
    required String title,
    required String hintText,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: AppTextFormField(
        enable: isEnable ?? false,
        title: title,
        enableBorderColor: isEnable == true
            ? AppColors.enableBorderColorSetting
            : null,
        fillColor: isEnable == true ? AppColors.filledColorEnable : null,
        titleColor: AppColors.grayText,
        hintText: hintText,
        hintTextStyle: context.textTheme.labelMedium!.copyWith(
          color: isEnable == true ? AppColors.textColor : AppColors.blackText,
        ),
      ),
    );
  }

  Widget _languageItemWidget({
    required String appLocale,
    required String language,
    required void Function() onTap,
    required String locale,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 7.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              language,
              style: context.textTheme.headlineMedium!.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            appLocale == locale
                ? const Icon(
                    Icons.check_box,
                    size: 26,
                    color: AppColors.blackText,
                  )
                : const Icon(
                    Icons.check_box_outline_blank,
                    size: 26,
                    color: AppColors.blackText,
                  ),
          ],
        ),
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper Method ////////////////////////
  ///////////////////////////////////////////////////////////
  HospitalSettingBloc get _currentBloc => context.read<HospitalSettingBloc>();
  void _arabicItemOnTap() {
    _changeToArabicEvent();
  }

  void _englishItemOnTap() {
    _changeToEnglishEvent();
  }

  void _changeToEnglishEvent() {
    BlocProvider.of<LocaleCubit>(context).changeLocale(LocaleApp.en);
  }

  void _changeToArabicEvent() {
    BlocProvider.of<LocaleCubit>(context).changeLocale(LocaleApp.ar);
  }

  Future<void> _logoutConfirmation() {
    return showAppDialog(
      context: context,
      dialogWidget: LogoutConfirmationDialogScreen(),
      shouldPopCallback: () {
        return true;
      },
    );
  }
}
