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
import 'package:organ_link/features/user_flow/procedure_scheduling/bloc/schedule_procedure_bloc.dart';
import 'package:organ_link/features/user_flow/procedure_scheduling/bloc/schedule_procedure_repository.dart';
import 'package:organ_link/features/user_flow/procedure_scheduling/models/schedule_procedure_ui_model.dart';
import 'package:organ_link/features/user_flow/widget/base_body_scaffold.dart';
import 'package:organ_link/features/widgets/data_row_with_divider.dart';
import 'package:organ_link/features/widgets/data_section.dart';
import 'package:organ_link/features/widgets/container_with_shadow.dart';
import 'package:organ_link/features/widgets/custom_divider_widget.dart';
import 'package:organ_link/preferences/preferences_manager.dart';
import 'package:organ_link/res/app_asset_paths.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/empty/empty_widgets.dart';
import 'package:organ_link/utils/feedback/feedback_message.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';

class ProcedureSchedulingScreen extends StatelessWidget {
  const ProcedureSchedulingScreen({super.key});
  static const routeName = "/procedure-scheduling-screen";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScheduleProcedureBloc(
        ScheduleProcedureRepository(
          userApiManager: UserApiManager(GetIt.I<DioApiManager>()),
          preferencesManager: GetIt.I<PreferencesManager>(),
        ),
      ),
      child: const ProcedureSchedulingScreenWithBloc(),
    );
  }
}

class ProcedureSchedulingScreenWithBloc extends BaseStatefulScreenWidget {
  const ProcedureSchedulingScreenWithBloc({super.key});

  @override
  BaseScreenState<BaseStatefulScreenWidget> baseScreenCreateState() =>
      _ProcedureSchedulingScreenWithBlocState();
}

class _ProcedureSchedulingScreenWithBlocState
    extends BaseScreenState<ProcedureSchedulingScreenWithBloc> {
  @override
  void initState() {
    super.initState();
    _currentBloc.add(GetScheduleProcedureDataEvent());
  }

  late ScheduleProcedureUiModel scheduleProcedureUiModel;
  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: BlocConsumer<ScheduleProcedureBloc, ScheduleProcedureState>(
        listener: (context, state) {
          if (state is ScheduleProcedureLoadingState) {
            showLoading();
          } else {
            hideLoading();
          }
          if (state is ScheduleProcedureErrorState) {
            showFeedbackMessage(state.errorMessage);
          } else if (state is ScheduleProcedureDataLoadedSuccessfullyState) {
            scheduleProcedureUiModel = state.scheduleProcedureUiModel;
          }
        },
        buildWhen: (previous, current) =>
            current is ScheduleProcedureDataLoadedSuccessfullyState,
        builder: (context, state) {
          return _buildBody(state);
        },
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper widget ////////////////////////
  ///////////////////////////////////////////////////////////

  Widget _buildBody(ScheduleProcedureState state) {
    if (state is ScheduleProcedureDataLoadedSuccessfullyState) {
      return BaseBodyScaffold(
        title: context.translate(LocalizationKeys.scheduleProcedure),
        onBackTap: () {
          Navigator.pop(context);
        },
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _transplantStatusMessage(),
            _procedureInfo(),
            _dataSectionWithName(
              context,
              padding: EdgeInsets.only(top: 24.h),
              title: LocalizationKeys.procedureLocation,
              subTitle: scheduleProcedureUiModel.hospitalName,
              body: Column(
                children: [
                  CustomDividerWidget(verticalPadding: 8.h),
                  SizedBox(height: 16.h),
                  DataRowWithDivider(
                    divider: true,
                    title: context.translate(LocalizationKeys.operatingRoom),
                    subTitle: scheduleProcedureUiModel.operationRoom,
                  ),
                  DataRowWithDivider(
                    title: context.translate(LocalizationKeys.arrivalTime),
                    subTitle: "قبل الموعد المحدد بساعتين (8 ص)",
                  ),
                ],
              ),
            ),
            _dataSectionWithName(
              context,
              padding: EdgeInsets.symmetric(vertical: 0),
              title: LocalizationKeys.medicalTeam,
              subTitle: context.translate(LocalizationKeys.expertTeam),
              body: Column(
                children: [
                  CustomDividerWidget(verticalPadding: 8.h),
                  SizedBox(height: 16.h),
                  DataRowWithDivider(
                    divider: true,
                    title: scheduleProcedureUiModel.doctorName,
                    titleStyle: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textColor,
                    ),
                    subTitle: scheduleProcedureUiModel.doctorSpecialty,
                    subTitleStyle: context.textTheme.labelMedium!.copyWith(
                      color: AppColors.grayText,
                    ),
                  ),
                  // DataRowWithDivider(
                  //   divider: true,
                  //   title: "د. سارة محمد",
                  //   titleStyle: context.textTheme.bodyMedium!.copyWith(
                  //     fontWeight: FontWeight.w600,
                  //     color: AppColors.textColor,
                  //   ),
                  //   subTitle: "جراح مساعد",
                  //   subTitleStyle: context.textTheme.labelMedium!.copyWith(
                  //     color: AppColors.grayText,
                  //   ),
                  // ),
                  DataRowWithDivider(
                    title: "د. سارة محمد",
                    titleStyle: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textColor,
                    ),
                    subTitle: "جراح مساعد",
                    subTitleStyle: context.textTheme.labelMedium!.copyWith(
                      color: AppColors.grayText,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return EmptyWidget();
    }
  }

  Widget _dataSectionWithName(
    BuildContext context, {
    EdgeInsetsGeometry? padding,
    required String title,
    required String subTitle,
    required Widget body,
  }) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(vertical: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(context.translate(title), style: context.textTheme.bodyLarge),
          DataSection(title: subTitle, body: body),
        ],
      ),
    );
  }

  Widget _procedureInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _infoCard(
          context,
          icon: AppAssetPaths.stopSwitchIcon,
          title: context.translate(LocalizationKeys.duration),
          subTile:
              "${scheduleProcedureUiModel.duration.toString()} ${context.translate(LocalizationKeys.hours)}",
        ),
        SizedBox(width: 16),
        _infoCard(
          context,
          icon: AppAssetPaths.alarmClockIcon,
          title: context.translate(LocalizationKeys.time),
          subTile: _getTime(scheduleProcedureUiModel.scheduledTime),
        ),
        SizedBox(width: 16),
        _infoCard(
          context,
          icon: AppAssetPaths.calendarIcon,
          title: context.translate(LocalizationKeys.date),
          subTile: DateFormat(
            'dd/MM',
          ).format(scheduleProcedureUiModel.scheduledDate),
        ),
      ],
    );
  }

  Widget _infoCard(
    BuildContext context, {
    required String title,
    required String subTile,
    required String icon,
  }) {
    return Container(
      height: 112.h,
      width: 103.w,
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
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
              title,
              style: context.textTheme.labelSmall!.copyWith(
                fontWeight: FontWeight.w400,
                color: AppColors.blackText,
                fontSize: 13,
              ),
            ),
          ),
          SizedBox(height: 4.h),
          Expanded(
            child: Text(
              subTile,
              style: context.textTheme.bodyMedium!.copyWith(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _transplantStatusMessage() {
    return ContainerWithShadow(
      contentPadding: EdgeInsets.symmetric(vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SvgPicture.asset(AppAssetPaths.inProgressIcon),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              textAlign: TextAlign.center,
              context.translate(LocalizationKeys.procedureScheduled),
              style: context.textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            softWrap: true,
            overflow: TextOverflow.visible,
            textAlign: TextAlign.center,
            context.translate(LocalizationKeys.allSetWeAreWithYou),
            style: context.textTheme.labelMedium!.copyWith(
              color: AppColors.grayText,
            ),
          ),
        ],
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper method ////////////////////////
  ///////////////////////////////////////////////////////////
  ScheduleProcedureBloc get _currentBloc =>
      context.read<ScheduleProcedureBloc>();

  String _getTime(String time) {
    final timeParts = time.split(':');
    final hour = timeParts[0];
    final minute = timeParts[1];
    return "$hour:$minute";
  }
}
