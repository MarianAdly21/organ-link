import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/widgets/base_stateful_screen_widget.dart';
import 'package:organ_link/apis/_base/dio_api_manager.dart';
import 'package:organ_link/apis/managers/user_manager/user_api_manager.dart';
import 'package:organ_link/features/user_flow/hospital_information/bloc/hospital_information_bloc.dart';
import 'package:organ_link/features/user_flow/hospital_information/bloc/hospital_information_repository.dart';
import 'package:organ_link/features/user_flow/hospital_information/models/hospital_information_ui_model.dart';
import 'package:organ_link/features/user_flow/widget/base_body_scaffold.dart';
import 'package:organ_link/features/user_flow/widget/hospital_name_container.dart';
import 'package:organ_link/features/widgets/data_row_with_divider.dart';
import 'package:organ_link/features/widgets/data_section.dart';
import 'package:organ_link/features/widgets/custom_divider_widget.dart';
import 'package:organ_link/features/widgets/internet_error_widget.dart';
import 'package:organ_link/preferences/preferences_manager.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/empty/empty_widgets.dart';
import 'package:organ_link/utils/feedback/feedback_message.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';

class HospitalInformationScreen extends StatelessWidget {
  const HospitalInformationScreen({super.key});
  static const routeName = "/hospital-information-screen";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HospitalInformationBloc(
        HospitalInformationRepository(
          preferencesManager: GetIt.I<PreferencesManager>(),
          userApiManager: UserApiManager(GetIt.I<DioApiManager>()),
        ),
      ),
      child: HospitalInformationScreenWithBloc(),
    );
  }
}

class HospitalInformationScreenWithBloc extends BaseStatefulScreenWidget {
  const HospitalInformationScreenWithBloc({super.key});

  @override
  BaseScreenState<BaseStatefulScreenWidget> baseScreenCreateState() =>
      _HospitalInformationScreenWithBlocState();
}

class _HospitalInformationScreenWithBlocState
    extends BaseScreenState<HospitalInformationScreenWithBloc> {
  @override
  void initState() {
    _getHospitalInfoData();
    super.initState();
  }

  late HospitalInformationUiModel hospitalInformationUiModel;
  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: BaseBodyScaffold(
        title: context.translate(LocalizationKeys.contactUs),
        onBackTap: () {
          Navigator.pop(context);
        },
        body: BlocConsumer<HospitalInformationBloc, HospitalInformationState>(
          listener: (context, state) {
            if (state is HospitalInformationLoadingState) {
              showLoading();
            } else {
              hideLoading();
            }
            if (state is HospitalInformationErrorState &&
                state.codeError != 1016) {
              showFeedbackMessage(state.errorMessage);
            } else if (state
                is HospitalInformationDataLoadedSuccessfullyState) {
              hospitalInformationUiModel = state.hospitalInformationUiModel;
            }
          },
          buildWhen: (previous, current) =>
              current is HospitalInformationDataLoadedSuccessfullyState ||
              current is HospitalInformationErrorState,
          builder: (context, state) => _buildBody(state),
        ),
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper widget ////////////////////////
  ///////////////////////////////////////////////////////////

  Widget _buildBody(HospitalInformationState state) {
    if (state is HospitalInformationDataLoadedSuccessfullyState) {
      return Padding(
        padding: EdgeInsets.only(bottom: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            HospitalNameContainer(
              hospitalName:
                  hospitalInformationUiModel.hospitalUiModel.hospitalName,
              hospitalLocation: hospitalInformationUiModel.hospitalUiModel.city,
            ),
            DataSection(
              paddingAroundContainer: EdgeInsets.symmetric(vertical: 0),
              title: context.translate(LocalizationKeys.location),
              titleOfButton: context.translate(LocalizationKeys.openInMaps),
              onTap: () {},
              body: Text(
                hospitalInformationUiModel.hospitalUiModel.location,
                style: context.textTheme.labelMedium!.copyWith(
                  color: AppColors.grayText,
                ),
              ),
            ),
            DataSection(
              title: context.translate(LocalizationKeys.contactInformation),
              titleOfButton: context.translate(LocalizationKeys.callNow),
              body: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomDividerWidget(verticalPadding: 8),
                  SizedBox(height: 16.h),
                  DataRowWithDivider(
                    divider: true,
                    title: context.translate(LocalizationKeys.mainPhone),
                    subTitle:
                        hospitalInformationUiModel.hospitalUiModel.minaPhone,
                  ),
                  DataRowWithDivider(
                    isImportant: true,
                    divider: true,
                    title: context.translate(LocalizationKeys.emergency),
                    subTitle: hospitalInformationUiModel
                        .hospitalUiModel
                        .emergencyPhone,
                  ),
                  DataRowWithDivider(
                    title: context.translate(LocalizationKeys.email),
                    subTitle: hospitalInformationUiModel.hospitalUiModel.email,
                  ),
                ],
              ),
            ),
            DataSection(
              paddingAroundContainer: EdgeInsets.symmetric(vertical: 0),
              title: context.translate(LocalizationKeys.attendingPhysician),
              body: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomDividerWidget(verticalPadding: 8),
                  SizedBox(height: 16.h),
                  DataRowWithDivider(
                    divider: true,
                    title: context.translate(LocalizationKeys.name),
                    subTitle: hospitalInformationUiModel
                        .supervisorDoctorUiModel
                        .doctorName,
                  ),
                  DataRowWithDivider(
                    divider: true,
                    title: context.translate(LocalizationKeys.specialty),
                    subTitle: hospitalInformationUiModel
                        .supervisorDoctorUiModel
                        .specialty,
                  ),
                  DataRowWithDivider(
                    title: context.translate(
                      LocalizationKeys.clinicPhoneNumber,
                    ),
                    subTitle: hospitalInformationUiModel
                        .supervisorDoctorUiModel
                        .phone,
                  ),
                ],
              ),
            ),
            DataSection(
              title: context.translate(LocalizationKeys.workingHours),
              body: Column(
                children: [
                  CustomDividerWidget(verticalPadding: 8.h),
                  Center(
                    child: Text(
                      hospitalInformationUiModel.hospitalUiModel.workingHours,
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: AppColors.blackText,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _infoNoticeCard(),
          ],
        ),
      );
    } else if (state is HospitalInformationErrorState &&
        state.codeError == 1016) {
      return InternetErrorWidget();
    } else {
      return EmptyWidget();
    }
  }

  Widget _infoNoticeCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        height: 95.h,
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: AppColors.importantText, blurRadius: 2)],
          borderRadius: BorderRadius.circular(16.r),
          color: AppColors.backgroundForImportantText,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 26.w),
          child: Text(
            context.translate(LocalizationKeys.emergencyMessage),
            style: context.textTheme.labelMedium!.copyWith(
              color: Color(0xff656464),
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper method ////////////////////////
  ///////////////////////////////////////////////////////////
  HospitalInformationBloc get _currentBloc =>
      context.read<HospitalInformationBloc>();

  void _getHospitalInfoData() {
    _currentBloc.add(GetHospitalInformationDataEvent());
  }
}
