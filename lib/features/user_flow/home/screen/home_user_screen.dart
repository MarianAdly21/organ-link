import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/widgets/base_stateful_screen_widget.dart';
import 'package:organ_link/apis/_base/dio_api_manager.dart';
import 'package:organ_link/apis/managers/user_manager/user_home_api_manager.dart';
import 'package:organ_link/features/hospital_flow/widget/container_with_background.dart';
import 'package:organ_link/features/user_flow/case_follow_up/screen/case_follow_up_screen.dart';
import 'package:organ_link/features/user_flow/home/bloc/user_home_bloc.dart';
import 'package:organ_link/features/user_flow/home/bloc/user_home_repository.dart';
import 'package:organ_link/features/user_flow/home/model/user_home_data_ui_model.dart';
import 'package:organ_link/features/user_flow/hospital_information/screen/hospital_information_screen.dart';
import 'package:organ_link/features/user_flow/medical_details/screens/medical_details_screen.dart';
import 'package:organ_link/features/user_flow/notification/screens/notification_screen.dart';
import 'package:organ_link/features/user_flow/settings/screen/settings_screen.dart';
import 'package:organ_link/features/widgets/container_with_black_shadow.dart';
import 'package:organ_link/features/widgets/custom_divider_widget.dart';
import 'package:organ_link/features/widgets/custom_notification_icon.dart';
import 'package:organ_link/res/app_asset_paths.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';

class HomeUserScreen extends StatelessWidget {
  const HomeUserScreen({super.key});
  static const routeName = "/home-user-screen";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserHomeBloc(
        UserHomeRepository(
          userHomeApiManager: UserHomeApiManager(GetIt.I<DioApiManager>()),
        ),
      ),
      child: const HomeUserScreenWithBloc(),
    );
  }
}

class HomeUserScreenWithBloc extends BaseStatefulScreenWidget {
  const HomeUserScreenWithBloc({super.key});

  @override
  BaseScreenState<BaseStatefulScreenWidget> baseScreenCreateState() =>
      _HomeUserScreenWithBlocState();
}

class _HomeUserScreenWithBlocState
    extends BaseScreenState<HomeUserScreenWithBloc> {
  // @override
  // void initState() {
  //   _currentBloc.add(GetHomeUserDateEvent(id: 1));
  //   super.initState();
  // }

  late UserHomeDataUiModel userHomeDataUiModel;
  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: BlocListener<UserHomeBloc, UserHomeState>(
        listener: (context, state) {
          if (state is UserHomeLoadingState) {
            showLoading();
          } else {
            hideLoading();
          }
          if (state is UserHomeDataLoadedSuccessfullyState) {
            userHomeDataUiModel = state.userHomeDataUiModel;
          } else if (state is NavToNotificationScreenState) {
            Navigator.of(context).pushNamed(NotificationScreen.routeName);
          } else if (state is NavToSettingScreenState) {
            Navigator.of(context).pushNamed(SettingsScreen.routeName);
          } else if (state is NavToHospitalInfoScreenState) {
            Navigator.of(
              context,
            ).pushNamed(HospitalInformationScreen.routeName);
          } else if (state is NavToCaseFollowUpScreenState) {
            Navigator.of(context).pushNamed(CaseFollowUpScreen.routeName);
          } else if (state is NavToMedicalDetailsScreenState) {
            Navigator.of(context).pushNamed(MedicalDetailsScreen.routeName);
          }
        },
        child: _buildBody(),
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper widget ////////////////////////
  ///////////////////////////////////////////////////////////

  Widget _buildBody() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
        child: Column(
          children: [
            _appBarWidget(),
            SizedBox(height: 8.h),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 48.h, bottom: 24.h),
                      child: _cardDetails(),
                    ),
                    _buildBodyList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBodyList() {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              child: _mainCard(
                onTap: () {
                  _navToMedicalDetailsScreenEvent();
                },
                icon: AppAssetPaths.personalIcon,
                title: LocalizationKeys.medicalDetails,
                subTitle: LocalizationKeys.viewHealthInformation,
              ),
            ),
            SizedBox(width: 16.w),
            Flexible(
              child: _mainCard(
                onTap: () {
                  _navToCaseFollowUpScreenEvent();
                },
                icon: AppAssetPaths.stockChartIcon,
                title: LocalizationKeys.caseFollowUp,
                subTitle: LocalizationKeys.operationStagesTracking,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Flexible(
              child: _mainCard(
                onTap: () {
                  _navToHospitalInfoScreenEvent();
                },
                icon: AppAssetPaths.hospitalIcon,
                title: LocalizationKeys.hospitalInformation,
                subTitle: LocalizationKeys.contactAndLocation,
              ),
            ),
            SizedBox(width: 16.w),
            Flexible(
              child: _mainCard(
                onTap: () {
                  _navToSettingsScreenEvent();
                },
                icon: AppAssetPaths.settingIcon,
                title: LocalizationKeys.settings,
                subTitle: LocalizationKeys.accountManagement,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _mainCard({
    required String icon,
    required String title,
    required String subTitle,
    required void Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: ContainerWithBlackShadow(
        height: 116.h,
        width: 164.w,
        contentPadding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 14.w),
        body: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(icon),
              SizedBox(height: 16.h),
              Text(
                context.translate(title),
                style: context.textTheme.labelMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.blackText,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                textAlign: TextAlign.center,
                context.translate(subTitle),
                style: context.textTheme.labelMedium!.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  color: AppColors.grayText,
                ),
              ),
            ],
          ),
        ),
      ), );
  }

  Widget _appBarWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomNotificationIcon(
          onTap: () {
            _navToNotificationScreenEvent();
          },
          height: 32.h,
          width: 32.w,
        ),
        SvgPicture.asset(
          height: 32.h,
          width: 109.w,
          AppAssetPaths.organLinkTextWithIcon,
        ),
      ],
    );
  }

  Widget _cardDetails() {
    return Container(
      width: 343.w,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowForContainerInfo.withValues(alpha: 0.25),
            blurRadius: 4,
          ),
        ],
        borderRadius: BorderRadius.circular(16.r),
        color: AppColors.containerColor,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: FittedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Mariana Adly Labib",
                          style: context.textTheme.bodyLarge!.copyWith(
                            color: AppColors.blackText,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          "${context.translate(LocalizationKeys.identificationNumberWithColumn)}1234 ",
                          style: context.textTheme.labelMedium!.copyWith(
                            color: AppColors.grayText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 9),
                ContainerWithBackground(
                  isCentered: true,
                  borderRadius: 8,
                  textStyle: context.textTheme.labelMedium!.copyWith(
                    color: AppColors.textColor,
                    fontSize: 14,
                    height: 1.2,
                  ),
                  backgroundColor: AppColors.displayFieldBGColor,
                  text: "مريض",
                ),  ],
            ),
            CustomDividerWidget(),
            Text(
              context.translate(LocalizationKeys.currentStatus),
              style: context.textTheme.labelMedium!.copyWith(
                color: AppColors.blackText,
              ),
            ),
            SizedBox(height: 12.h),
            Container(
              height: 40.h,
              width: 310.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: AppColors.displayFieldBGColor,
              ),
              child: Center(
                child: Text(
                  "تحت المتابعة",
                  /// change based on condition
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: AppColors.textColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              "${context.translate(LocalizationKeys.lastUpdate)}: date",
              style: context.textTheme.bodySmall!.copyWith(
                color: AppColors.grayText,
                fontWeight: FontWeight.w400,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper methods ////////////////////////
  ///////////////////////////////////////////////////////////

  UserHomeBloc get _currentBloc => context.read<UserHomeBloc>();
  void _navToNotificationScreenEvent() {
    _currentBloc.add(NavToNotificationScreenEvent());
  }

  void _navToSettingsScreenEvent() {
    _currentBloc.add(NavToSettingScreenEvent());
  }

  void _navToHospitalInfoScreenEvent() {
    _currentBloc.add(NavToHospitalInfoScreenEvent());
  }

  void _navToCaseFollowUpScreenEvent() {
    _currentBloc.add(NavToCaseFollowUpScreenEvent());
  }

  void _navToMedicalDetailsScreenEvent() {
    _currentBloc.add(NavToMedicalDetailsScreenEvent());
  }
}
