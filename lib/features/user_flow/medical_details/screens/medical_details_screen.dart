import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/widgets/base_stateful_screen_widget.dart';
import 'package:organ_link/apis/_base/dio_api_manager.dart';
import 'package:organ_link/apis/managers/user_manager/user_api_manager.dart';
import 'package:organ_link/features/shared_screens/method/calculate_age.dart';
import 'package:organ_link/features/user_flow/medical_details/bloc/medical_details_bloc.dart';
import 'package:organ_link/features/user_flow/medical_details/bloc/medical_details_repository.dart';
import 'package:organ_link/features/user_flow/medical_details/models/medical_details_ui_model.dart';
import 'package:organ_link/features/user_flow/medical_details/models/medical_test_ui_model.dart';
import 'package:organ_link/features/user_flow/widget/base_body_scaffold.dart';
import 'package:organ_link/features/widgets/container_with_black_shadow.dart';
import 'package:organ_link/features/widgets/container_with_shadow.dart';
import 'package:organ_link/features/widgets/custom_divider_widget.dart';
import 'package:organ_link/features/widgets/notice_container.dart';
import 'package:organ_link/preferences/preferences_manager.dart';
import 'package:organ_link/res/app_asset_paths.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/empty/empty_widgets.dart';
import 'package:organ_link/utils/feedback/feedback_message.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';

class MedicalDetailsScreen extends StatelessWidget {
  const MedicalDetailsScreen({super.key});
  static String routeName = "/medical-details-screen";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MedicalDetailsBloc(
        MedicalDetailsRepository(
          userApiManager: UserApiManager(GetIt.I<DioApiManager>()),
          preferencesManager: GetIt.I<PreferencesManager>(),
        ),
      ),
      child: MedicalDetailsScreenWithBloc(),
    );
  }
}

class MedicalDetailsScreenWithBloc extends BaseStatefulScreenWidget {
  const MedicalDetailsScreenWithBloc({super.key});

  @override
  BaseScreenState<BaseStatefulScreenWidget> baseScreenCreateState() =>
      _MedicalDetailsScreenWithBlocState();
}

class _MedicalDetailsScreenWithBlocState
    extends BaseScreenState<MedicalDetailsScreenWithBloc> {
  @override
  void initState() {
    _currentBloc.add(GetMedicalDetailsDataEvent());
    super.initState();
  }

  late MedicalDetailsUiModel medicalDetailsUiModel;
  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: BlocConsumer<MedicalDetailsBloc, MedicalDetailsState>(
        listener: (context, state) {
          if (state is MedicalDetailsLoadingState) {
            showLoading();
          } else {
            hideLoading();
          }
          if (state is MedicalDetailsDataLoadedSuccessfullyState) {
            medicalDetailsUiModel = state.medicalDetailsUiModel;
          } else if (state is MedicalDetailsErrorState) {
            showFeedbackMessage(state.errorMessage);
          }
        },
        buildWhen: (previous, current) =>
            current is MedicalDetailsDataLoadedSuccessfullyState,
        builder: (context, state) => _buildBody(state),
      ),
    );
  }
  ///////////////////////////////////////////////////////////
  /////////////////// Helper widget ////////////////////////
  ///////////////////////////////////////////////////////////

  Widget _buildBody(MedicalDetailsState state) {
    if (state is MedicalDetailsDataLoadedSuccessfullyState) {
      return BaseBodyScaffold(
        title: context.translate(LocalizationKeys.medicalDetailsScreen),
        onBackTap: () {
          Navigator.pop(context);
        },
        body: Column(
          children: [
            _personalInfoCard(),
            _chronicDiseasesCard(),
            if (medicalDetailsUiModel.medicalTestList.isNotEmpty)
              _medicalTestCard(),
            _upcomingAppointmentCard(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: NoticeContainer(notice: LocalizationKeys.hospitalDataNote),
            ),
          ],
        ),
      );
    } else {
      return EmptyWidget();
    }
  }

  Widget _baseOfCard({
    required String titleOfCard,
    required Widget body,
    EdgeInsetsGeometry? padding,
    double? verticalPaddingOfDivider,
  }) {
    return ContainerWithShadow(
      padding: EdgeInsets.symmetric(vertical: 16.w),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.translate(titleOfCard),
            style: context.textTheme.bodyLarge,
          ),
          Padding(
            padding: padding ?? EdgeInsets.all(0),
            child: CustomDividerWidget(
              verticalPadding: verticalPaddingOfDivider ?? 0,
            ),
          ),
          body,
        ],
      ),
    );
  }

  Widget _personalInfoCard() {
    return _baseOfCard(
      padding: EdgeInsets.only(bottom: 8.h, top: 16.h),
      titleOfCard: LocalizationKeys.personalInformation,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _personalInfoColumn(
                  title: LocalizationKeys.fullName,
                  subTitle: medicalDetailsUiModel.fullName,
                ),
                _personalInfoColumn(
                  title: LocalizationKeys.type,
                  subTitle: medicalDetailsUiModel.type,
                ),
                _personalInfoColumn(
                  title: LocalizationKeys.requiredOrgan,
                  subTitle: medicalDetailsUiModel.organ,
                ),
              ],
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _personalInfoColumn(
                  title: LocalizationKeys.medicalFileNumber,
                  subTitle: medicalDetailsUiModel.medicalFileNumber,
                ),
                _personalInfoColumn(
                  title: LocalizationKeys.age,
                  subTitle:
                      "${calculateAge(medicalDetailsUiModel.age)} ${context.translate(LocalizationKeys.year)}",
                ),
                _personalInfoColumn(
                  title: LocalizationKeys.bloodType,
                  subTitle: medicalDetailsUiModel.bloodType,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _chronicDiseasesCard() {
    return _baseOfCard(
      verticalPaddingOfDivider: 16.h,
      titleOfCard: LocalizationKeys.chronicDiseases,
      body: Wrap(
        spacing: 16.w,
        runSpacing: 8.h,
        children: List.generate(
          medicalDetailsUiModel.chronicDiseasesList.length,
          (index) => medicalDetailsUiModel.chronicDiseasesList.isNotEmpty
              ? _diseaseCard(
                  disease:
                      medicalDetailsUiModel.chronicDiseasesList[index].name,
                )
              : Text(
                  context.translate(LocalizationKeys.noChronicDiseasesRecorded),
                  style: context.textTheme.labelLarge,
                ),
        ),
      ),
    );
  }

  Widget _diseaseCard({required String disease}) {
    return ContainerWithBlackShadow(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      body: Text(
        disease,
        style: context.textTheme.labelSmall!.copyWith(
          fontWeight: FontWeight.w400,
          color: AppColors.blackText,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _medicalTestCard() {
    return _baseOfCard(
      verticalPaddingOfDivider: 16.h,
      titleOfCard: LocalizationKeys.medicalTests,
      body: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: medicalDetailsUiModel.medicalTestList.length,
        itemBuilder: (context, index) {
          return _medicalTest(
            model: medicalDetailsUiModel.medicalTestList[index],
          );
        },
      ),
    );
  }

  Widget _medicalTest({required MedicalTestUiModel model}) {
    return ContainerWithShadow(
      height: 85.h,
      borderSideColor: Color(0xff00C951),
      padding: EdgeInsets.only(bottom: 16.h),
      background: AppColors.medicalTestContainerBG,
      contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.testName,
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 9.h),
                  Text(
                    DateFormat('yyyy-MM-dd').format(model.date)  
                    ,
                    style: context.textTheme.labelSmall!.copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppColors.blackText,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 9),
          Container(
            height: 26.h,
            width: 53.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.medicalTestDoneBG,
            ),
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  child: Text(
                    model.status,

                    /// change based on condition
                    style: context.textTheme.labelMedium!.copyWith(
                      color: AppColors.medicalTestDoneText,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _upcomingAppointmentCard() {
    return _baseOfCard(
      verticalPaddingOfDivider: 16.h,
      titleOfCard: LocalizationKeys.upcomingAppointments,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.medicalTestContainerBG,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowForContainerInfo.withValues(alpha: 0.25),
                blurRadius: 4,
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 84.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(AppAssetPaths.calendarIcon),
                SizedBox(height: 16.h),
                Text(
                  context.translate(LocalizationKeys.visitAppointment),
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: AppColors.grayText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 9.h),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: medicalDetailsUiModel.upcomingAppointments != null
                      ? Text(
                          DateFormat(
                            'yyyy-MM-dd',
                          ).format(medicalDetailsUiModel.upcomingAppointments!),
                          style: context.textTheme.bodyLarge,
                        )
                      : SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _personalInfoColumn({
    required String title,
    required String subTitle,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.translate(title),
            style: context.textTheme.labelMedium!.copyWith(
              color: AppColors.grayText,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 8.h),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              subTitle,
              style: context.textTheme.labelSmall!.copyWith(
                color: AppColors.textColor,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper method ////////////////////////
  ///////////////////////////////////////////////////////////

  MedicalDetailsBloc get _currentBloc => context.read<MedicalDetailsBloc>();
}
