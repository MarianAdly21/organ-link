import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/widgets/base_stateful_screen_widget.dart';
import 'package:organ_link/apis/_base/dio_api_manager.dart';
import 'package:organ_link/apis/managers/hospital_manager/hospital_api_manager.dart';
import 'package:organ_link/features/hospital_flow/matching_details/bloc/matching_details_bloc.dart';
import 'package:organ_link/features/hospital_flow/matching_details/bloc/matching_details_repository.dart';
import 'package:organ_link/features/hospital_flow/matching_details/models/matching_details_ui_model.dart';
import 'package:organ_link/features/hospital_flow/widget/app_base_body_scaffold.dart';
import 'package:organ_link/features/widgets/container_with_shadow.dart';
import 'package:organ_link/features/widgets/data_row_with_divider.dart';
import 'package:organ_link/features/widgets/internet_error_widget.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/empty/empty_widgets.dart';
import 'package:organ_link/utils/feedback/feedback_message.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';

class MatchingDetailsScreen extends StatelessWidget {
  const MatchingDetailsScreen({super.key, required this.matchId});
  final int matchId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MatchingDetailsBloc(
        MatchingDetailsRepository(
          hospitalApiManager: HospitalApiManager(
            dioApiManager: GetIt.I<DioApiManager>(),
          ),
        ),
      ),
      child: MatchingDetailsScreenWithBloc(matchId: matchId),
    );
  }
}

class MatchingDetailsScreenWithBloc extends BaseStatefulScreenWidget {
  const MatchingDetailsScreenWithBloc({super.key, required this.matchId});
  final int matchId;

  @override
  BaseScreenState<BaseStatefulScreenWidget> baseScreenCreateState() =>
      _MatchingDetailsScreenWithBlocState();
}

class _MatchingDetailsScreenWithBlocState
    extends BaseScreenState<MatchingDetailsScreenWithBloc> {
  late MatchingDetailsUiModel matchingDetailsUiModel;
  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: BlocConsumer<MatchingDetailsBloc, MatchingDetailsState>(
        listener: (context, state) {
          if (state is MatchingDetailsLoadingState) {
            showLoading();
          } else {
            hideLoading();
          }
          if (state is MatchingDetailsDataLoadedSuccessfullyState) {
            matchingDetailsUiModel = state.matchingDetailsUiModel;
          } else if (state is MatchingDetailsErrorState &&
              state.codeError != 1016) {
            showFeedbackMessage(state.errorMessage);
          }
        },
        buildWhen: (previous, current) =>
            current is MatchingDetailsDataLoadedSuccessfullyState ||
            current is MatchingDetailsErrorState,
        builder: (context, state) {
          return _buildBody(state);
        },
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper widget ////////////////////////
  ///////////////////////////////////////////////////////////

  Widget _buildBody(MatchingDetailsState state) {
    if (state is MatchingDetailsDataLoadedSuccessfullyState) {
      return AppBaseBodyScaffold(
        titleOfScreen: context.translate(
          LocalizationKeys.matchingDetailsScreen,
        ),
        backTap: () {
          Navigator.pop(context);
        },
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _patientInfo(),
              if (matchingDetailsUiModel.requestStatus != "لم يتم العثور") ...[
                Text(
                  context.translate(LocalizationKeys.aiResult),
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                matchingDetailsUiModel.requestStatus == "قيد التحليل"
                    ? _waitingAiResultContainer()
                    : _matchingResultAi(),
              ],
            ],
          ),
        ),
      );
    } else if (state is MatchingDetailsErrorState && state.codeError == 1016) {
      return InternetErrorWidget();
    } else {
      return EmptyWidget();
    }
  }

  Widget _patientInfo() {
    return ContainerWithShadow(
      contentPadding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DataRowWithDivider(
            divider: true,
            title: context.translate(LocalizationKeys.patientName),
            subTitle: matchingDetailsUiModel.patientName,
          ),
          DataRowWithDivider(
            divider: true,
            title: context.translate(LocalizationKeys.fileNumberWithoutColumn),
            subTitle: matchingDetailsUiModel.patientFileNum,
          ),
          DataRowWithDivider(
            divider: true,
            title: context.translate(LocalizationKeys.requiredOrgan),
            subTitle: matchingDetailsUiModel.organ,
          ),
          DataRowWithDivider(
            divider: true,
            title: context.translate(LocalizationKeys.requestDate),
            subTitle: DateFormat(
              "dd-MM-yyyy",
            ).format(matchingDetailsUiModel.requestDate),
          ),
          DataRowWithDivider(
            isImportant:
                matchingDetailsUiModel.requestStatus == "لم يتم العثور",
            title: context.translate(LocalizationKeys.requestStatus),
            subTitle: matchingDetailsUiModel.requestStatus,
          ),
        ],
      ),
    );
  }

  Widget _matchingResultAi() {
    return ContainerWithShadow(
      background: AppColors.matchingDataUserContainerBG,
      contentPadding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
      child: Column(
        children: [
          DataRowWithDivider(
            divider: true,
            dividerColor: AppColors.matchingDataUserDivider,
            title: context.translate(LocalizationKeys.donorName),
            subTitle: matchingDetailsUiModel.donorName,
          ),
          DataRowWithDivider(
            divider: true,
            dividerColor: AppColors.matchingDataUserDivider,
            title: context.translate(LocalizationKeys.fileNumberWithoutColumn),
            subTitle: matchingDetailsUiModel.donorFileNum,
          ),
          DataRowWithDivider(
            divider: true,
            dividerColor: AppColors.matchingDataUserDivider,
            title: context.translate(LocalizationKeys.bloodType),
            subTitle: matchingDetailsUiModel.donorBloodType,
          ),
          DataRowWithDivider(
            isImportant: true,
            dividerColor: AppColors.matchingDataUserDivider,
            title: context.translate(LocalizationKeys.matchPercentage),
            subTitle: "${matchingDetailsUiModel.matchPercentage}%",
            importantTextColor: AppColors.matchingParentage,
          ),
        ],
      ),
    );
  }

  Widget _waitingAiResultContainer() {
    return ContainerWithShadow(
      height: 88.h,
      background: AppColors.waitingAiResultBG,
      contentPadding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
      child: Text(
        textAlign: TextAlign.center,
        "جارٍ تحليل البيانات بواسطة الذكاء الاصطناعي... النتيجة ستظهر خلال 24-48 ساعة",
        style: context.textTheme.labelMedium!.copyWith(
          color: AppColors.textColor,
        ),
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper method ////////////////////////
  ///////////////////////////////////////////////////////////
  MatchingDetailsBloc get _currentBloc => context.read<MatchingDetailsBloc>();

  void _getData() {
    _currentBloc.add(GetMatchingDetailsDataEvent(matchId: widget.matchId));
  }
}
