import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/widgets/base_stateful_screen_widget.dart';
import 'package:organ_link/apis/_base/dio_api_manager.dart';
import 'package:organ_link/apis/managers/hospital_manager/hospital_api_manager.dart';
import 'package:organ_link/features/hospital_flow/enum/nav_type.dart';
import 'package:organ_link/features/hospital_flow/hospital_dashboard/bloc/hospital_dashboard_bloc.dart';
import 'package:organ_link/features/hospital_flow/hospital_dashboard/bloc/hospital_dashboard_repository.dart';
import 'package:organ_link/features/hospital_flow/hospital_dashboard/models/hospital_dashboard_ui_model.dart';
import 'package:organ_link/features/hospital_flow/hospital_setting/screen/hospital_setting_screen.dart';
import 'package:organ_link/features/hospital_flow/matching/screen/matching_screen.dart';
import 'package:organ_link/features/hospital_flow/notification_screen/screen/hospital_notification_screen.dart';
import 'package:organ_link/features/hospital_flow/surgeries/screen/surgeries_screen.dart';
import 'package:organ_link/features/hospital_flow/view_patient_or_donor/screen/view_patient_or_donor_screen.dart';
import 'package:organ_link/features/hospital_flow/widget/hospital_app_bar_base.dart';
import 'package:organ_link/features/ministry_flow/widgets/title_and_subtitle_custom_widget.dart';
import 'package:organ_link/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:organ_link/features/widgets/container_with_black_shadow.dart';
import 'package:organ_link/features/widgets/custom_notification_icon.dart';
import 'package:organ_link/features/widgets/internet_error_widget.dart';
import 'package:organ_link/preferences/preferences_manager.dart';
import 'package:organ_link/res/app_asset_paths.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/empty/empty_widgets.dart';
import 'package:organ_link/utils/feedback/feedback_message.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';

class HospitalDashboardScreen extends StatelessWidget {
  const HospitalDashboardScreen({super.key});
  static const routeName = "/hospital-dashboard-screen";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HospitalDashboardBloc(
        HospitalDashboardRepository(
          hospitalApiManager: HospitalApiManager(
            dioApiManager: GetIt.I<DioApiManager>(),
          ),
          preferencesManager: GetIt.I<PreferencesManager>(),
        ),
      ),
      child: const HospitalDashboardScreenWithBloc(),
    );
  }
}

class HospitalDashboardScreenWithBloc extends BaseStatefulScreenWidget {
  const HospitalDashboardScreenWithBloc({super.key});

  @override
  BaseScreenState<BaseStatefulScreenWidget> baseScreenCreateState() =>
      _HospitalDashboardScreenWithBlocState();
}

class _HospitalDashboardScreenWithBlocState
    extends BaseScreenState<HospitalDashboardScreenWithBloc> {
  late HospitalDashboardUiModel hospitalDashboardUiModel;
  @override
  void initState() {
    super.initState();
    _currentBloc.add(GetHospitalDashboardDataEvent());
  }

  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: BlocConsumer<HospitalDashboardBloc, HospitalDashboardState>(
        listener: (context, state) {
          if (state is HospitalDashboardLoadingState) {
            showLoading();
          } else {
            hideLoading();
          }
          if (state is HospitalDashboardDataLoadedSuccessfullyState) {
            hospitalDashboardUiModel = state.hospitalDashboardUiModel;
          } else if (state is NavToMatchingScreenState) {
            _navToMatchingScreen();
          } else if (state is NavToSurgeriesScreenState) {
            _navToSurgeriesScreen();
          } else if (state is NavToHospitalSettingScreenState) {
            _navToHospitalSettingScreen();
          } else if (state is NavToHospitalNotificationScreenState) {
            _navToHospitalNotificationScreen();
          } else if (state is NavToViewPatientOrDonorScreenState) {
            _navToViewPatientOrDonorScreen(state);
          } else if (state is HospitalDashboardErrorState &&
              state.codeError != 1016) {
            showFeedbackMessage(state.errorMessage);
          }
        },
        buildWhen: (previous, current) =>
            current is HospitalDashboardDataLoadedSuccessfullyState ||
            current is HospitalDashboardErrorState,
        builder: (context, state) {
          return _buildBody(state);
        },
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper widget ////////////////////////
  ///////////////////////////////////////////////////////////

  Widget _buildBody(HospitalDashboardState state) {
    if (state is HospitalDashboardDataLoadedSuccessfullyState) {
      return SafeArea(
        child: Column(
          children: [
            _appBar(),
            Expanded(child: SingleChildScrollView(child: _bodyContent())),
          ],
        ),
      );
    } else if (state is HospitalDashboardErrorState &&
        state.codeError == 1016) {
      return InternetErrorWidget();
    } else {
      return EmptyWidget();
    }
  }

  Widget _appBar() {
    return HospitalAppBarBase(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    child: Text(
                      hospitalDashboardUiModel.hospitalName,
                      style: context.textTheme.bodyLarge!.copyWith(
                        color: AppColors.blackText,
                      ),
                    ),
                  ),
                  SizedBox(height: 9.h),
                  Text(
                    hospitalDashboardUiModel.hospitalCity,
                    style: context.textTheme.labelMedium!.copyWith(
                      color: AppColors.blackText,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 24),
              child: CustomNotificationIcon(
                onTap: () {
                  _navToHospitalNotificationScreenEvent();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bodyContent() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TitleAndSubtitleCustomWidget(
            title: context.translate(LocalizationKeys.dashboard),
            subTitle:
                " ${context.translate(LocalizationKeys.welcomeMessage)} ${hospitalDashboardUiModel.hospitalName}",
          ),
          _dashboardSection(),
          _quickActionsSection(),
        ],
      ),
    );
  }

  Widget _quickActionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          context.translate(LocalizationKeys.quickActions),
          style: context.bodyMedium!.copyWith(color: AppColors.textColor),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Row(
            children: [
              _quickActionsBtn(
                onTap: () {
                  _navToPatientOrDonorEvent(NavType.donor);
                },
                text: LocalizationKeys.viewDonors,
                backgroundColor: AppColors.seconderColor,
              ),
              SizedBox(width: 16.w),
              _quickActionsBtn(
                onTap: () {
                  _navToPatientOrDonorEvent(NavType.patient);
                },
                text: LocalizationKeys.viewPatients,
                backgroundColor: AppColors.mainColor,
              ),
            ],
          ),
        ),
        Row(
          children: [
            _quickActionsBtn(
              onTap: () {
                _navToSurgeriesScreenEvent();
              },
              text: LocalizationKeys.operations,
              backgroundColor: Color(0xffFF0004),
            ),
            SizedBox(width: 16.w),
            _quickActionsBtn(
              onTap: () {
                _navToMatchingScreenEvent();
              },
              text: LocalizationKeys.compatibilityRequests,
              backgroundColor: AppColors.grayText,
            ),
          ],
        ),
        _settingBtn(),
      ],
    );
  }

  Widget _settingBtn() {
    return GestureDetector(
      onTap: () {
        _currentBloc.add(NavToHospitalSettingScreenEvent());
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Container(
          height: 48.h,
          //padding: EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: Color(0xffD9D9D9),
            borderRadius: BorderRadius.circular(8.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 2,
              ),
            ],
          ),
          child: Center(
            child: FittedBox(
              child: Text(
                context.translate(LocalizationKeys.settings),
                style: context.textTheme.bodyMedium!.copyWith(
                  color: Color(0xff4F4F4F),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _quickActionsBtn({
    required String text,
    Color? textColor,
    required Color? backgroundColor,
    required void Function() onTap,
  }) {
    return Expanded(
      child: AppElevatedButton(
        onPressed: onTap,
        color: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),

        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        label: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            context.translate(text),
            style: context.textTheme.bodyMedium!.copyWith(
              color: textColor ?? AppColors.hospitalBtnText,
            ),
          ),
        ),
      ),
    );
  }

  Widget _dashboardSection() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: _mainCard(
                  icon: AppAssetPaths.heartIcon,
                  title: LocalizationKeys.registeredDonor,
                  count: hospitalDashboardUiModel.donorsCount.toString(),
                  // subTitle2:
                  //     "+3${context.translate(LocalizationKeys.thisMonthCount)}",
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _mainCard(
                  icon: AppAssetPaths.peopleIcon,
                  title: LocalizationKeys.patientWaitingForTransplant,
                  count: hospitalDashboardUiModel.patientsCount.toString(),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _mainCard(
                  icon: AppAssetPaths.notesBookIcon,
                  title: LocalizationKeys.matchingRequests,
                  count: hospitalDashboardUiModel.totalMatches.toString(),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _mainCard(
                  icon: AppAssetPaths.voltageIcon,
                  title: LocalizationKeys.ongoingOperations,
                  count: hospitalDashboardUiModel.totalSurgeries.toString(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _mainCard({
    required String icon,
    required String title,
    required String count,
  }) {
    return ContainerWithBlackShadow(
      height: 132.h,
      body: FittedBox(
        fit: BoxFit.scaleDown,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(icon),
            SizedBox(height: 16),
            Text(
              maxLines: 1,
              context.translate(title),
              style: context.textTheme.labelMedium!.copyWith(
                color: AppColors.grayText,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 7),
              child: Text(
                textAlign: TextAlign.center,
                count,
                style: context.textTheme.bodyLarge!.copyWith(
                  color: AppColors.blackText,
                ),
              ),
            ),
            // Text(
            //   textAlign: TextAlign.center,
            //   subTitle2,
            //   style: context.textTheme.labelMedium!.copyWith(
            //     fontWeight: FontWeight.w400,
            //     fontSize: 13,
            //     color: AppColors.grayText,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper method ////////////////////////
  ///////////////////////////////////////////////////////////
  HospitalDashboardBloc get _currentBloc =>
      context.read<HospitalDashboardBloc>();
  void _navToHospitalSettingScreen() {
    Navigator.of(context).pushNamed(HospitalSettingScreen.routeName);
  }

  void _navToHospitalNotificationScreenEvent() {
    _currentBloc.add(NavToHospitalNotificationScreenEvent());
  }

  void _navToViewPatientOrDonorScreen(
    NavToViewPatientOrDonorScreenState state,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ViewPatientOrDonorScreen(type: state.type),
      ),
    );

    // Navigator.of(
    //   context,
    // ).pushNamed(ViewPatientOrDonorScreen.routeName, arguments: state.type);
  }

  void _navToSurgeriesScreenEvent() {
    _currentBloc.add(NavToSurgeriesScreenEvent());
  }

  void _navToMatchingScreenEvent() {
    _currentBloc.add(NavToMatchingScreenEvent());
  }

  void _navToHospitalNotificationScreen() {
    Navigator.of(context).pushNamed(HospitalNotificationScreen.routeName);
  }

  void _navToSurgeriesScreen() {
    Navigator.of(context).pushNamed(SurgeriesScreen.routeName);
  }

  void _navToMatchingScreen() {
    Navigator.of(context).pushNamed(MatchingScreen.routeName);
  }

  void _navToPatientOrDonorEvent(NavType type) {
    _currentBloc.add(NavToViewPatientOrDonorScreenEvent(type: type));
  }
}
