import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/extensions/screen_sizer_extension.dart';
import 'package:organ_link/_core/widgets/base_stateful_screen_widget.dart';
import 'package:organ_link/apis/_base/dio_api_manager.dart';
import 'package:organ_link/apis/managers/hospital_manager/hospital_api_manager.dart';
import 'package:organ_link/features/hospital_flow/enum/medical_test_status.dart';
import 'package:organ_link/features/hospital_flow/enum/nav_type.dart';
import 'package:organ_link/features/hospital_flow/extension/medical_test_status_ui.dart';
import 'package:organ_link/features/hospital_flow/patient_or_donor_details/bloc/patient_or_donor_details_bloc.dart';
import 'package:organ_link/features/hospital_flow/patient_or_donor_details/bloc/patient_or_donor_details_repository.dart';
import 'package:organ_link/features/hospital_flow/patient_or_donor_details/models/patient_or_donor_details_ui_model.dart';
import 'package:organ_link/features/hospital_flow/patient_or_donor_details/widget/gradient_text.dart';
import 'package:organ_link/features/hospital_flow/upload_files/screen/upload_files_screen.dart';
import 'package:organ_link/features/hospital_flow/widget/container_with_background.dart';
import 'package:organ_link/features/hospital_flow/widget/app_base_body_scaffold.dart';
import 'package:organ_link/features/hospital_flow/widget/status_row_widget.dart';
import 'package:organ_link/features/shared_models/medical_test_ui_model.dart';
import 'package:organ_link/features/widgets/app_buttons/app_buttons.dart';
import 'package:organ_link/features/widgets/container_with_shadow.dart';
import 'package:organ_link/features/widgets/custom_divider_widget.dart';
import 'package:organ_link/features/widgets/data_row_with_divider.dart';
import 'package:organ_link/features/widgets/data_section.dart';
import 'package:organ_link/features/widgets/internet_error_widget.dart';
import 'package:organ_link/res/app_asset_paths.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/empty/empty_widgets.dart';
import 'package:organ_link/utils/feedback/feedback_message.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';
import 'package:timelines_plus/timelines_plus.dart';

class PatientOrDonorDetailsScreen extends StatelessWidget {
  const PatientOrDonorDetailsScreen({
    super.key,
    required this.id,
    required this.type,
  });
  final int id;
  final NavType type;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PatientOrDonorDetailsBloc(
        PatientOrDonorDetailsRepository(
          hospitalApiManager: HospitalApiManager(
            dioApiManager: GetIt.I<DioApiManager>(),
          ),
        ),
      ),
      child: PatientOrDonorDetailsScreenWithBloc(id: id, type: type),
    );
  }
}

class PatientOrDonorDetailsScreenWithBloc extends BaseStatefulScreenWidget {
  const PatientOrDonorDetailsScreenWithBloc({
    super.key,
    required this.id,
    required this.type,
  });
  final int id;
  final NavType type;

  @override
  BaseScreenState<BaseStatefulScreenWidget> baseScreenCreateState() =>
      _PatientOrDonorDetailsScreenWithBlocState();
}

class _PatientOrDonorDetailsScreenWithBlocState
    extends BaseScreenState<PatientOrDonorDetailsScreenWithBloc> {
  late PatientOrDonorDetailsUiModel patientOrDonorDetailsUiModel;
  @override
  void initState() {
    super.initState();
    _currentBloc.add(GetPatientOrDonorDetailsDataEvent(id: widget.id));
  }

  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: AppBaseBodyScaffold(
        titleOfScreen: context.translate(
          widget.type == NavType.donor
              ? LocalizationKeys.donorDetails
              : LocalizationKeys.patientDetails,
        ),
        backTap: () {
          Navigator.pop(context);
        },
        body:
            BlocConsumer<PatientOrDonorDetailsBloc, PatientOrDonorDetailsState>(
              listener: (context, state) {
                if (state is PatientOrDonorDetailsLoadingState) {
                  showLoading();
                } else {
                  hideLoading();
                }
                if (state is PatientOrDonorDetailsDataLoadedSuccessfullyState) {
                  patientOrDonorDetailsUiModel =
                      state.patientOrDonorDetailsUiModel;
                } else if (state is PatientOrDonorDetailsErrorState &&
                    state.codeError != 1016) {
                  showFeedbackMessage(state.errorMessage);
                }
              },
              buildWhen: (previous, current) =>
                  current is PatientOrDonorDetailsDataLoadedSuccessfullyState ||
                  current is PatientOrDonorDetailsErrorState,
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

  Widget _buildBody(PatientOrDonorDetailsState state) {
    if (state is PatientOrDonorDetailsDataLoadedSuccessfullyState) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _headerInfoWidget(),
            _personalInfoSection(),
            _medicalInfoSection(),
            SizedBox(height: 24.h),
            _vitalSigns(),
            _reportAndInvestigationsSection(),
            DataSection(
              paddingAroundContainer: EdgeInsets.only(bottom: 24.h),
              title: context.translate(LocalizationKeys.caseRecord),
              body: Column(
                children: [CustomDividerWidget(), _myTimeLineColumn()],
              ),
            ),
          ],
        ),
      );
    } else if (state is PatientOrDonorDetailsErrorState &&
        state.codeError == 1016) {
      return InternetErrorWidget();
    } else {
      return EmptyWidget();
    }
  }

  Widget _reportAndInvestigationsSection() {
    return DataSection(
      title: context.translate(LocalizationKeys.reportAndInvestigations),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          patientOrDonorDetailsUiModel.reportAndInvestigations.isEmpty
              ? Text(
                  context.translate(LocalizationKeys.noReportsAvailable),
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: Colors.black,
                  ),
                )
              : Column(
                  children: patientOrDonorDetailsUiModel.reportAndInvestigations
                      .map((x) => _medicalTestItem(test: x))
                      .toList(),
                ),
          _addReportBtn(),
        ],
      ),
    );
  }

  Widget _medicalTestItem({required MedicalTestUiModel test}) {
    return ContainerWithShadow(
      contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 17.w),
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 2.w),
      background: AppColors.reportContainerBG,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                test.testName,
                style: context.textTheme.bodyMedium!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 13.h),
              Text(
                DateFormat('yyyy-MM-dd').format(test.date),
                style: context.textTheme.labelMedium,
              ),
            ],
          ),
          ContainerWithBackground(
            backgroundColor: mapMedicalTestStatus(
              test.testType,
            ).badgeBackground,
            text: test.testType,
            textColor: mapMedicalTestStatus(test.testType).textColor,
          ),
        ],
      ),
    );
  }

  Widget _medicalInfoSection() {
    return DataSection(
      paddingAroundContainer: EdgeInsets.zero,
      title: context.translate(LocalizationKeys.medicalInformation),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.translate(
                  patientOrDonorDetailsUiModel.role == "donor"
                      ? LocalizationKeys.availableOrgan
                      : LocalizationKeys.requiredOrgan,
                ),
              ),
              ContainerWithBackground(
                backgroundColor: AppColors.readyTextBG,
                text: patientOrDonorDetailsUiModel.organ,
                textColor: AppColors.readyText,
              ),
            ],
          ),
          CustomDividerWidget(verticalPadding: 24.h),
          _infoSection(
            title: context.translate(LocalizationKeys.medicalHistory),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: patientOrDonorDetailsUiModel.medicalHistory.isEmpty
                  ? [
                      _dotWithText(
                        text: context.translate(
                          LocalizationKeys.noDataAvailable,
                        ),
                      ),
                    ]
                  : List.generate(
                      patientOrDonorDetailsUiModel.medicalHistory.length,
                      (index) {
                        return _dotWithText(
                          text: patientOrDonorDetailsUiModel
                              .medicalHistory[index].name,
                        );
                      },
                    ),
            ),
          ),
          _infoSection(
            title: context.translate(LocalizationKeys.allergies),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: patientOrDonorDetailsUiModel.allergiesList.isEmpty
                  ? [
                      _dotWithText(
                        text: context.translate(
                          LocalizationKeys.noDataAvailable,
                        ),
                      ),
                    ]
                  : List.generate(
                      patientOrDonorDetailsUiModel.allergiesList.length,
                      (index) {
                        return _dotWithText(
                          text: patientOrDonorDetailsUiModel
                              .allergiesList[index]
                              .name,
                        );
                      },
                    ),
            ),
          ),
          _infoSection(
            title: context.translate(LocalizationKeys.currentMedications),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children:
                  patientOrDonorDetailsUiModel.currentMedicationsList.isEmpty
                  ? [
                      _dotWithText(
                        text: context.translate(
                          LocalizationKeys.noDataAvailable,
                        ),
                      ),
                    ]
                  : List.generate(
                      patientOrDonorDetailsUiModel
                          .currentMedicationsList
                          .length,
                      (index) {
                        return _dotWithText(
                          text:
                              "${patientOrDonorDetailsUiModel.currentMedicationsList[index].name}: ${patientOrDonorDetailsUiModel.currentMedicationsList[index].frequencyPerDay} ${patientOrDonorDetailsUiModel.currentMedicationsList[index].note}",
                        );
                      },
                    ),
            ),
            divider: false,
          ),
        ],
      ),
    );
  }

  Widget _personalInfoSection() {
    return DataSection(
      title: context.translate(LocalizationKeys.personalInformation),
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: AppColors.blackText,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomDividerWidget(verticalPadding: 8),
          SizedBox(height: 8.h),
          DataRowWithDivider(
            divider: true,
            title: context.translate(LocalizationKeys.fullName),
            subTitle: patientOrDonorDetailsUiModel.fullName,
          ),
          DataRowWithDivider(
            divider: true,
            title: context.translate(LocalizationKeys.age),
            subTitle:
                "${patientOrDonorDetailsUiModel.age} ${context.translate(LocalizationKeys.year)}",
          ),
          DataRowWithDivider(
            divider: true,
            title: context.translate(LocalizationKeys.type),
            subTitle: patientOrDonorDetailsUiModel.gender,
          ),
          DataRowWithDivider(
            divider: true,
            title: context.translate(LocalizationKeys.bloodType),
            subTitle: patientOrDonorDetailsUiModel.bloodType,
          ),
          DataRowWithDivider(
            divider: true,
            title: context.translate(LocalizationKeys.phoneNumber),
            subTitle: patientOrDonorDetailsUiModel.phoneNumber,
          ),
          DataRowWithDivider(
            divider: true,
            title: context.translate(LocalizationKeys.email),
            subTitle: patientOrDonorDetailsUiModel.email,
          ),
          DataRowWithDivider(
            title: context.translate(LocalizationKeys.city),
            subTitle: patientOrDonorDetailsUiModel.city,
          ),
        ],
      ),
    );
  }

  Widget _myTimeLineColumn() {
    return Column(
      children: [
        _timeLineItem(
          isDone: false,
          text: "تم تجهيز المريض للمطابقة",
          doneDate: "من 10:30 - 2025-02-05",
          isLast: true,
        ),

        _timeLineItem(
          isDone: true,
          text: "رفع التحاليل الشاملة",
          doneDate: "من 10:30 - 2025-02-05",
          isLast: true,
          isFirst: true,
        ),
        _timeLineItem(
          isDone: true,
          text: "تسجيل المريض",
          doneDate: "من 10:30 - 2025-02-05",
          isFirst: true,
        ),
      ],
    );
  }

  Widget _timeLineItem({
    required String doneDate,
    required String text,
    required bool isDone,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return TimelineTile(
      nodeAlign: TimelineNodeAlign.start,
      contents: SizedBox(
        height: 90.h,
        child: Padding(
          padding: const EdgeInsetsDirectional.only(start: 28),
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  text,
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  doneDate,
                  style: context.textTheme.labelMedium!.copyWith(
                    color: AppColors.personalInfoText,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      node: TimelineNode(
        indicator: DotIndicator(
          color: AppColors.timelineNode,
          size: 24,
          child: isDone ? Icon(Icons.done, color: AppColors.mainColor) : null,
        ),
        startConnector: isFirst
            ? SolidLineConnector(
                color: isDone ? AppColors.mainColor : AppColors.lineConnector,
              )
            : null,
        endConnector: isLast
            ? SolidLineConnector(
                color: isDone ? AppColors.mainColor : AppColors.lineConnector,
              )
            : null,
      ),
    );
  }

  Widget _addReportBtn() {
    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: DottedBorder(
        childOnTop: false,
        options: RoundedRectDottedBorderOptions(
          radius: Radius.circular(16),
          dashPattern: [6, 6],
          gradient: LinearGradient(
            colors: [AppColors.mainColor, AppColors.seconderColor],
          ),
        ),
        child: AppElevatedButton(
          onPressed: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => UploadFilesScreen()));
          },
          color: Colors.white,
          label: Center(
            child: GradientText(
              text: context.translate(LocalizationKeys.addNewReport),
            ),
          ),
        ),
      ),
    );
  }

  Widget _vitalSigns() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          context.translate(LocalizationKeys.vitalSigns),
          style: TextStyle(
            color: AppColors.textColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 16.h),
        Column(
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _vitalSignCard(
                  context,
                  icon: AppAssetPaths.dropOfBloodIcon,
                  vitalName: context.translate(
                    LocalizationKeys.respiratoryRate,
                  ),
                  reading: "12 - 20 / دقيقة",
                ),
                SizedBox(width: 16.w),
                _vitalSignCard(
                  context,
                  icon: AppAssetPaths.injectionIcon,
                  vitalName: context.translate(LocalizationKeys.bloodPressure),
                  reading: "120/80",
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: _vitalSignCard(
                context,
                icon: AppAssetPaths.temperatureIcon,
                vitalName: context.translate(LocalizationKeys.temperature),
                reading: "37.0 C",
              ),
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _vitalSignCard(
                  context,
                  icon: AppAssetPaths.scaleWeightIcon,
                  vitalName: context.translate(LocalizationKeys.heartRate),
                  reading: "60 - 80 / دقيقة",
                ),
                SizedBox(width: 16.w),
                _vitalSignCard(
                  context,
                  icon: AppAssetPaths.fitToHeightIcon,
                  vitalName: context.translate(
                    LocalizationKeys.oxygenSaturation,
                  ),
                  reading: "95 - 100 %",
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _vitalSignCard(
    BuildContext context, {
    required String vitalName,
    required String reading,
    required String icon,
  }) {
    return Container(
      height: 122.h,
      width: 163.w,
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            blurStyle: BlurStyle.outer,
            blurRadius: 8,
            color: Colors.black.withValues(alpha: 0.15),
          ),
        ],
        color: AppColors.homeCardBG.withValues(alpha: 0.45),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(child: SvgPicture.asset(icon)),
          SizedBox(height: 8.h),
          Expanded(
            child: Text(
              reading,
              style: context.textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w600,

                fontSize: 16,
              ),
            ),
          ),
          SizedBox(height: 4.h),
          Expanded(
            child: Text(
              vitalName,
              style: context.textTheme.labelMedium!.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget _infoSection({
  //   required String title,
  //   required List list,
  //   bool divider = true,
  // }) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.stretch,
  //     children: [
  //       Text(
  //         title,
  //         style: TextStyle(
  //           color: AppColors.textColor,
  //           fontSize: 16,
  //           fontWeight: FontWeight.w600,
  //         ),
  //       ),
  //       SizedBox(height: 8.h),
  //       Column(
  //         crossAxisAlignment: CrossAxisAlignment.stretch,
  //         children: list.isEmpty
  //             ? [
  //                 _dotWithText(
  //                   text: context.translate(LocalizationKeys.noDataAvailable),
  //                 ),
  //               ]
  //             : List.generate(list.length, (index) {
  //                 return _dotWithText(text: list[index]);
  //               }),
  //       ),
  //       divider
  //           ? CustomDividerWidget(endIndent: 24.w, indent: 24.w)
  //           : SizedBox.shrink(),
  //     ],
  //   );
  // }
  Widget _infoSection({
    required String title,
    required Widget body,
    bool divider = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppColors.textColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        body,
        divider
            ? CustomDividerWidget(endIndent: 24.w, indent: 24.w)
            : SizedBox.shrink(),
      ],
    );
  }

  Widget _dotWithText({required String text}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8.w,
            height: 8.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.personalInfoText,
            ),
          ),
          SizedBox(width: 16),
          Text(
            text,
            style: context.textTheme.labelMedium!.copyWith(
              color: AppColors.personalInfoText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _headerInfoWidget() {
    return ContainerWithShadow(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 4.h),
      width: context.width,
      contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      child: Column(
        children: [
          Text(
            patientOrDonorDetailsUiModel.fullName,
            style: context.textTheme.bodyMedium!.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.h, bottom: 16.h),
            child: Text(
              "${context.translate(LocalizationKeys.fileNumber)} ${patientOrDonorDetailsUiModel.fileNumber}",
              style: context.textTheme.labelMedium!.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          StatusRowWidget(
            priority:
                patientOrDonorDetailsUiModel.priority ??
                patientOrDonorDetailsUiModel.healthyStatus!,
            status: patientOrDonorDetailsUiModel.status,
          ),
        ],
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper method ////////////////////////
  ///////////////////////////////////////////////////////////
  PatientOrDonorDetailsBloc get _currentBloc =>
      context.read<PatientOrDonorDetailsBloc>();
}
