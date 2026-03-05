import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/widgets/base_stateful_screen_widget.dart';
import 'package:organ_link/apis/_base/dio_api_manager.dart';
import 'package:organ_link/apis/managers/hospital_manager/hospital_api_manager.dart';
import 'package:organ_link/features/hospital_flow/enum/nav_type.dart';
import 'package:organ_link/features/hospital_flow/enum/operation_status.dart';
import 'package:organ_link/features/hospital_flow/extension/operation_status_ui.dart';
import 'package:organ_link/features/hospital_flow/patient_or_donor_details/screen/patient_or_donor_details_screen.dart';
import 'package:organ_link/features/hospital_flow/surgery_details/bloc/surgery_details_bloc.dart';
import 'package:organ_link/features/hospital_flow/surgery_details/bloc/surgery_details_repository.dart';
import 'package:organ_link/features/hospital_flow/surgery_details/models/surgery_details_ui_model.dart';
import 'package:organ_link/features/hospital_flow/widget/app_base_body_scaffold.dart';
import 'package:organ_link/features/widgets/app_buttons/app_button_with_gradient_colors.dart';
import 'package:organ_link/features/widgets/container_with_shadow.dart';
import 'package:organ_link/features/widgets/data_row_with_divider.dart';
import 'package:organ_link/features/widgets/data_row_with_status_container_widget.dart';
import 'package:organ_link/features/widgets/internet_error_widget.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/empty/empty_widgets.dart';
import 'package:organ_link/utils/feedback/feedback_message.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';

class SurgeryDetailsScreen extends StatelessWidget {
  const SurgeryDetailsScreen({super.key, required this.id});
  static const String routeName = "/surgery-details-screen";
  final int id;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SurgeryDetailsBloc(
        SurgeryDetailsRepository(
          hospitalApiManager: HospitalApiManager(
            dioApiManager: GetIt.I<DioApiManager>(),
          ),
        ),
      ),
      child: SurgeryDetailsScreenWithBloc(id: id),
    );
  }
}

class SurgeryDetailsScreenWithBloc extends BaseStatefulScreenWidget {
  const SurgeryDetailsScreenWithBloc({super.key, required this.id});
  final int id;

  @override
  BaseScreenState<BaseStatefulScreenWidget> baseScreenCreateState() =>
      _SurgeryDetailsScreenWithBlocState();
}

class _SurgeryDetailsScreenWithBlocState
    extends BaseScreenState<SurgeryDetailsScreenWithBloc> {
  late final SurgeryDetailsUiModel surgeryDetailsUiModel;
  @override
  void initState() {
    super.initState();
    _currentBloc.add(GetSurgeryDetailsDataEvent(id: widget.id));
  }

  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: AppBaseBodyScaffold(
        titleOfScreen: LocalizationKeys.surgeryDetails,
        backTap: () {
          Navigator.pop(context);
        },
        body: BlocConsumer<SurgeryDetailsBloc, SurgeryDetailsState>(
          listener: (context, state) {
            if (state is SurgeryDetailsLoadingState) {
              showLoading();
            } else {
              hideLoading();
            }
            if (state is SurgeryDetailsDataLoadedSuccessfullyState) {
              surgeryDetailsUiModel = state.surgeryDetailsUiModel;
            } else if (state is NavToPatientOrDonorDetailsScreenState) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PatientOrDonorDetailsScreen(
                    id: state.id,
                    type: state.type,
                  ),
                ),
              );
            } else if (state is SurgeryDetailsErrorState &&
                state.codeError != 1016) {
              showFeedbackMessage(state.errorMessage);
            }
          },
          buildWhen: (previous, current) =>
              current is SurgeryDetailsDataLoadedSuccessfullyState ||
              current is SurgeryDetailsErrorState,
          builder: (context, state) {
            return _buildBody(state);
          },
        ),
      ),
    );
  }
  ///////////////////////////////////////////////////////////
  /////////////////// Helper widget ////////////////////////
  ///////////////////////////////////////////////////////////

  Widget _buildBody(SurgeryDetailsState state) {
    if (state is SurgeryDetailsDataLoadedSuccessfullyState) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "${context.translate(LocalizationKeys.surgeryNumber)}:${surgeryDetailsUiModel.surgeryNumber}",
              style: context.textTheme.bodyLarge,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: _surgeryInfoSection(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: _patientInfoSection(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: _donorInfoSection(),
            ),
            if (surgeryDetailsUiModel.date != null) ...[_infoNoticeCard()],
          ],
        ),
      );
    } else if (state is SurgeryDetailsErrorState && state.codeError == 1016) {
      return InternetErrorWidget();
    } else {
      return EmptyWidget();
    }
  }

  Widget _surgeryInfoSection() {
    return ContainerWithShadow(
      borderSideColor: mapOperationStatus(
        surgeryDetailsUiModel.surgeryStatus,
      ).sideColor,
      padding: EdgeInsets.symmetric(vertical: 12.h),
      contentPadding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
      sectionTitle: context.translate(LocalizationKeys.surgeryInformation),
      child: Column(
        children: [
          DataRowWithDivider(
            divider: true,
            title: context.translate(LocalizationKeys.organ),
            subTitle: surgeryDetailsUiModel.organType,
          ),
          DataRowWithDivider(
            divider: true,
            title: context.translate(LocalizationKeys.responsibleSurgeon),
            subTitle: surgeryDetailsUiModel.responsibleSurgeon,
          ),
          DataRowWithDivider(
            divider: true,
            title: context.translate(LocalizationKeys.department),
            subTitle: surgeryDetailsUiModel.department,
          ),
          DataRowWithDivider(
            divider: true,
            title: context.translate(LocalizationKeys.date),
            subTitle: surgeryDetailsUiModel.date ?? "",
          ),
          DataRowWithStatusContainerWidget(
            title: LocalizationKeys.surgeryStatus,
            subTitle: surgeryDetailsUiModel.surgeryStatus,
            backgroundColor: mapOperationStatus(
              surgeryDetailsUiModel.surgeryStatus,
            ).badgeBackground,
            subTitleColor: mapOperationStatus(
              surgeryDetailsUiModel.surgeryStatus,
            ).sideColor,
          ),
        ],
      ),
    );
  }

  Widget _donorInfoSection() {
    return ContainerWithShadow(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      contentPadding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
      sectionTitle: context.translate(LocalizationKeys.donorInformation),
      child: Column(
        children: [
          DataRowWithDivider(
            divider: true,
            title: context.translate(LocalizationKeys.donorName),
            subTitle: surgeryDetailsUiModel.donorName,
          ),
          DataRowWithDivider(
            title: context.translate(LocalizationKeys.fileNumberWithoutColumn),
            subTitle: surgeryDetailsUiModel.donorNameFileNumber,
          ),
          SizedBox(height: 24.h),
          AppButtonWithGradientColors(
            text: context.translate(LocalizationKeys.goToDonorFile),
            onTap: () {
              _navToPatientOrDonorDetailsScreenEvent(
                id: surgeryDetailsUiModel.donorId,
                type: NavType.donor,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _patientInfoSection() {
    return ContainerWithShadow(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      contentPadding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
      sectionTitle: context.translate(LocalizationKeys.patientInformation),
      child: Column(
        children: [
          DataRowWithDivider(
            divider: true,
            title: context.translate(LocalizationKeys.patientName),
            subTitle: surgeryDetailsUiModel.patientName,
          ),
          DataRowWithDivider(
            title: context.translate(LocalizationKeys.fileNumberWithoutColumn),
            subTitle: surgeryDetailsUiModel.patientFileNumber,
          ),
          SizedBox(height: 24.h),
          AppButtonWithGradientColors(
            text: context.translate(LocalizationKeys.goToPatientFile),
            onTap: () {
              _navToPatientOrDonorDetailsScreenEvent(
                id: surgeryDetailsUiModel.patientId,
                type: NavType.patient,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _infoNoticeCard() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 24.h),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.notCardBorder),
          color: AppColors.notCardBG,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.translate(LocalizationKeys.notes),
                style: context.textTheme.bodyMedium,
              ),
              Text(
                "العملية محددة في الساعة 08:00 صباحا",

                /// from back
                style: context.textTheme.labelMedium!.copyWith(
                  color: AppColors.seconderColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper method ////////////////////////
  ///////////////////////////////////////////////////////////
  SurgeryDetailsBloc get _currentBloc => context.read<SurgeryDetailsBloc>();
  void _navToPatientOrDonorDetailsScreenEvent({
    required int id,
    required NavType type,
  }) {
    _currentBloc.add(NavToPatientOrDonorDetailsScreenEvent(id: id, type: type));
  }
}
