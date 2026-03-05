import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/widgets/base_stateful_screen_widget.dart';
import 'package:organ_link/apis/_base/dio_api_manager.dart';
import 'package:organ_link/apis/managers/hospital_manager/hospital_api_manager.dart';
import 'package:organ_link/features/hospital_flow/enum/operation_status.dart';
import 'package:organ_link/features/hospital_flow/extension/operation_status_ui.dart';
import 'package:organ_link/features/hospital_flow/surgeries/bloc/surgeries_bloc.dart';
import 'package:organ_link/features/hospital_flow/surgeries/bloc/surgeries_repository.dart';
import 'package:organ_link/features/hospital_flow/surgeries/models/counter_ui_model.dart';
import 'package:organ_link/features/hospital_flow/surgeries/models/surgery_list_ui_model.dart';
import 'package:organ_link/features/hospital_flow/surgeries/models/surgery_ui_model.dart';
import 'package:organ_link/features/hospital_flow/surgery_details/screen/surgery_details_screen.dart';
import 'package:organ_link/features/hospital_flow/widget/container_with_background.dart';
import 'package:organ_link/features/hospital_flow/widget/app_base_body_scaffold.dart';
import 'package:organ_link/features/ministry_flow/widgets/title_and_subtitle_custom_widget.dart';
import 'package:organ_link/features/widgets/app_buttons/app_button_with_gradient_colors.dart';
import 'package:organ_link/features/widgets/container_with_shadow.dart';
import 'package:organ_link/features/widgets/custom_divider_widget.dart';
import 'package:organ_link/features/widgets/custom_over_view_container.dart';
import 'package:organ_link/features/widgets/data_row_with_divider.dart';
import 'package:organ_link/features/widgets/internet_error_widget.dart';
import 'package:organ_link/preferences/preferences_manager.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/empty/empty_widgets.dart';
import 'package:organ_link/utils/feedback/feedback_message.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';

class SurgeriesScreen extends StatelessWidget {
  const SurgeriesScreen({super.key});
  static const routeName = "/surgeries-screen";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SurgeriesBloc(
        SurgeriesRepository(
          hospitalApiManager: HospitalApiManager(
            dioApiManager: GetIt.I<DioApiManager>(),
          ),
          preferencesManager: GetIt.I<PreferencesManager>(),
        ),
      ),
      child: SurgeriesScreenWithBloc(),
    );
  }
}

class SurgeriesScreenWithBloc extends BaseStatefulScreenWidget {
  const SurgeriesScreenWithBloc({super.key});

  @override
  BaseScreenState<BaseStatefulScreenWidget> baseScreenCreateState() =>
      _SurgeriesScreenWithBlocState();
}

class _SurgeriesScreenWithBlocState
    extends BaseScreenState<SurgeriesScreenWithBloc> {
  late SurgeryUiModel surgeries;
  late List<SurgeryListUiModel> surgeryList;
  List<CounterUiModel> get counters => [
    CounterUiModel(
      counterName: LocalizationKeys.underReview,
      count: surgeries.underReviewSurgeriesCount,
      color: Color(0xffFFF2DC),
    ),
    CounterUiModel(
      counterName: LocalizationKeys.completed,
      count: surgeries.completedSurgeriesCount,
      color: Color(0xffDEFFDF),
    ),
    CounterUiModel(
      counterName: LocalizationKeys.ongoing,
      count: surgeries.ongoingSurgeriesCount,
      color: Color(0xffE6F4FF),
    ),
    CounterUiModel(
      counterName: LocalizationKeys.scheduled,
      count: surgeries.scheduledSurgeriesCount,
      color: Color(0xffFCE4FF),
    ),
  ];
  @override
  void initState() {
    _currentBloc.add(GetSurgeriesDataEvent());
    super.initState();
  }

  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: AppBaseBodyScaffold(
        titleOfScreen: context.translate(LocalizationKeys.surgeries),
        backTap: () {
          Navigator.pop(context);
        },
        body: BlocConsumer<SurgeriesBloc, SurgeriesState>(
          listener: (context, state) {
            if (state is SurgeriesLoadingState) {
              showLoading();
            } else {
              hideLoading();
            }
            if (state is SurgeriesDataLoadedSuccessfullyState) {
              surgeries = state.surgeries;
              surgeryList = surgeries.surgeryList;
            } else if (state is NavToSurgeryDetailsScreenState) {
              _navToMatchingDetailsScreen(state);
            } else if (state is SurgeriesErrorState &&
                state.codeError != 1016) {
              showFeedbackMessage(state.errorMessage);
            }
          },
          buildWhen: (previous, current) =>
              current is SurgeriesDataLoadedSuccessfullyState ||
              current is SurgeriesErrorState,
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

  Widget _buildBody(SurgeriesState state) {
    if (state is SurgeriesDataLoadedSuccessfullyState) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [_headerWidget(), _surgeriesList()],
        ),
      );
    } else if (state is SurgeriesErrorState && state.codeError == 1016) {
      return InternetErrorWidget();
    } else {
      return EmptyWidget();
    }
  }

  Widget _headerWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TitleAndSubtitleCustomWidget(
          title: context.translate(LocalizationKeys.surgeryRecord),
          subTitle: context.translate(LocalizationKeys.organTransplantFollowUp),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 24.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...List.generate(
                counters.length,
                (index) => CustomOverViewContainer(
                  backgroundColor: counters[index].color,
                  text: context.translate(counters[index].counterName),
                  count: counters[index].count.toString(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _surgeriesList() {
    return surgeryList.isEmpty
        ? Center(
            child: Text(
              context.translate(LocalizationKeys.noSurgeriesAvailable),
              style: context.textTheme.bodyMedium!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.textColor,
              ),
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                context.translate(LocalizationKeys.surgeriesList),
                style: context.textTheme.bodyMedium!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.blackText,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: surgeryList.length,
                itemBuilder: (context, index) {
                  return ContainerWithShadow(
                    borderSideColor: mapOperationStatus(
                      surgeries.surgeryList[index].surgeryState,
                    ).sideColor,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 24.h,
                      horizontal: 16.w,
                    ),
                    child: Column(
                      children: [
                        _surgeryNameAndIdAndStatusRow(index),
                        CustomDividerWidget(),
                        DataRowWithDivider(
                          divider: true,
                          title: context.translate(LocalizationKeys.patient),
                          subTitle: surgeryList[index].patientName,
                        ),
                        DataRowWithDivider(
                          divider: true,
                          title: context.translate(LocalizationKeys.donor),
                          subTitle: surgeryList[index].donorName,
                        ),
                        DataRowWithDivider(
                          divider: true,
                          title: context.translate(LocalizationKeys.department),
                          subTitle: surgeryList[index].department,
                        ),
                        DataRowWithDivider(
                          title: context.translate(LocalizationKeys.date),
                          subTitle: surgeryList[index].date,
                        ),
                        CustomDividerWidget(indent: 24.w, endIndent: 24.w),
                        SizedBox(height: 16.h),
                        AppButtonWithGradientColors(
                          text: context.translate(LocalizationKeys.details),
                          onTap: () {
                            _currentBloc.add(
                              NavToSurgeryDetailsScreenEvent(
                                id: surgeryList[index].id,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          );
  }

  Widget _surgeryNameAndIdAndStatusRow(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              surgeryList[index].surgeryName,
              style: context.textTheme.bodyMedium!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.blackText,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Text(
                "${context.translate(LocalizationKeys.surgeryNumber)}:${surgeryList[index].surgeryNumber}",
                style: context.textTheme.labelMedium!.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        ContainerWithBackground(
          backgroundColor: mapOperationStatus(
            surgeryList[index].surgeryState,
          ).badgeBackground,
          text: surgeryList[index].surgeryState,
        ),
      ],
    );
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper method ////////////////////////
  ///////////////////////////////////////////////////////////
  SurgeriesBloc get _currentBloc => context.read<SurgeriesBloc>();
  void _navToMatchingDetailsScreen(NavToSurgeryDetailsScreenState state) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => SurgeryDetailsScreen(id: state.id)),
    );
  }
}
