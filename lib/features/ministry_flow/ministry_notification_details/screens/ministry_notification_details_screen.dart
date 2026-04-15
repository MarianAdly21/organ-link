import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/widgets/base_stateful_screen_widget.dart';
import 'package:organ_link/apis/_base/dio_api_manager.dart';
import 'package:organ_link/apis/managers/ministry_manager/ministry_api_manager.dart';
import 'package:organ_link/features/hospital_flow/enum/ministry_notification_type.dart';
import 'package:organ_link/features/hospital_flow/extension/ministry_notification_type_ui.dart';
import 'package:organ_link/features/hospital_flow/widget/app_base_body_scaffold.dart';
import 'package:organ_link/features/hospital_flow/widget/container_with_background.dart';
import 'package:organ_link/features/ministry_flow/ministry_notification/methods/get_gradient_by_status.dart';
import 'package:organ_link/features/ministry_flow/ministry_notification_details/bloc/ministry_notification_details_bloc.dart';
import 'package:organ_link/features/ministry_flow/ministry_notification_details/bloc/ministry_notification_details_repository.dart';
import 'package:organ_link/features/ministry_flow/ministry_notification_details/models/ministry_notification_details_ui_model.dart';
import 'package:organ_link/features/widgets/container_with_black_shadow.dart';
import 'package:organ_link/features/widgets/custom_divider_widget.dart';
import 'package:organ_link/features/widgets/data_row_with_divider.dart';
import 'package:organ_link/features/widgets/data_row_with_status_container_widget.dart';
import 'package:organ_link/features/widgets/internet_error_widget.dart';
import 'package:organ_link/features/widgets/notice_container.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/empty/empty_widgets.dart';
import 'package:organ_link/utils/feedback/feedback_message.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';

class MinistryNotificationDetailsScreen extends StatelessWidget {
  const MinistryNotificationDetailsScreen({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MinistryNotificationDetailsBloc(
        MinistryNotificationDetailsRepository(
          ministryApiManager: MinistryApiManager(
            dioApiManager: GetIt.I<DioApiManager>(),
          ),
        ),
      ),
      child: MinistryNotificationDetailsScreenWithBloc(id: id),
    );
  }
}

class MinistryNotificationDetailsScreenWithBloc
    extends BaseStatefulScreenWidget {
  const MinistryNotificationDetailsScreenWithBloc({
    super.key,
    required this.id,
  });
  final int id;
  @override
  BaseScreenState<BaseStatefulScreenWidget> baseScreenCreateState() =>
      _MinistryNotificationDetailsScreenState();
}

class _MinistryNotificationDetailsScreenState
    extends BaseScreenState<MinistryNotificationDetailsScreenWithBloc> {
  late MinistryNotificationDetailsUiModel ministryNotificationDetailsUiModel;
  @override
  void initState() {
    super.initState();
    _currentBloc.add(GetMinistryNotificationDetailsDataEvent(id: widget.id));
  }

  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: AppBaseBodyScaffold(
        titleOfScreen: context.translate(LocalizationKeys.alertDetails),
        backTap: () {
          Navigator.pop(context);
        },
        body:
            BlocConsumer<
              MinistryNotificationDetailsBloc,
              MinistryNotificationDetailsState
            >(
              listener: (context, state) {
                if (state is MinistryNotificationDetailsLoadingState) {
                  showLoading();
                } else {
                  hideLoading();
                }
                if (state
                    is MinistryNotificationDetailsDataLoadedSuccessfullyState) {
                  ministryNotificationDetailsUiModel =
                      state.ministryNotificationDetailsUiModel;
                } else if (state is MinistryNotificationDetailsErrorState &&
                    state.codeError != 1016) {
                  showFeedbackMessage(
                    context: context,
                    feedbackStyle: FeedbackStyle.snackBar,
                    state.errorMessage,
                  );
                }
              },
              buildWhen: (previous, current) =>
                  current
                      is MinistryNotificationDetailsDataLoadedSuccessfullyState ||
                  current is MinistryNotificationDetailsErrorState,

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

  Widget _buildBody(MinistryNotificationDetailsState state) {
    if (state is MinistryNotificationDetailsDataLoadedSuccessfullyState) {
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
          child: Column(
            children: [
              _headerContainer(),
              _descriptionSection(),
              //_recordSupportSection(),
              NoticeContainer(
                height: 80.h,
                padding: EdgeInsetsDirectional.only(
                  end: 6.w,
                  bottom: 24.h,
                  top: 24.h,
                ),
                notice: context.translate(
                  LocalizationKeys.hospitalNotifiedOnAction,
                ),
              ),
            ],
          ),
        ),
      );
    } else if (state is MinistryNotificationDetailsErrorState &&
        state.codeError == 1016) {
      return InternetErrorWidget();
    } else {
      return EmptyWidget();
    }
  }

  // Widget _recordSupportSection() {
  //   return ContainerWithBlackShadow(
  //     backgroundColor: AppColors.generalContainerBGMinistry,
  //     body: Column(
  //       children: [
  //         TitleAndSubtitleCustomWidget(
  //           title: "تسجيل الدعم",
  //           subTitle: "للدعم الفني والمساعدة",
  //         ),
  //         CustomDividerWidget(),
  //         _textField(
  //           padding: EdgeInsets.only(top: 16.h),
  //           title: "البريد الالكتروني",
  //           hintText: "giza.hospital@moh.gov.eg",
  //         ),
  //         _textField(title: " رقم الهاتف", hintText: "+201024567890"),
  //         _textField(
  //           padding: EdgeInsets.all(0),
  //           title: "المسؤول",
  //           hintText: "د. أحمد محمود - مسؤول النظام",
  //         ),
  //         Padding(
  //           padding: EdgeInsets.only(top: 16.h),
  //           child: Row(
  //             children: [
  //               Expanded(
  //                 child: AppButtonWithGradientColors(
  //                   colors: [Color(0xffCC0C10), Color(0xffCC0C10)],
  //                   onTap: () {},
  //                   text: context.translate("اتخاذ إجراء"),
  //                 ),
  //               ),
  //               SizedBox(width: 16),
  //               Expanded(
  //                 child: AppButtonWithGradientColors(
  //                   onTap: () {},
  //                   text: context.translate("تجاهل"),
  //                   textColor: AppColors.blackText,
  //                   border: BoxBorder.all(color: AppColors.backButtonBorder),
  //                   colors: [
  //                     AppColors.followUpInvestigation,
  //                     AppColors.followUpInvestigation,
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _textField({
  //   required String title,
  //   required String hintText,
  //   EdgeInsetsGeometry? padding,
  // }) {
  //   return Padding(
  //     padding: padding ?? EdgeInsets.symmetric(vertical: 24.h),
  //     child: AppTextFormField(
  //       enable: false,
  //       title: title,
  //       hintText: hintText,
  //       hintTextStyle: context.textTheme.labelMedium!.copyWith(
  //         color: AppColors.blackText,
  //       ),
  //     ),
  //   );
  // }

  Widget _descriptionSection() {
    return ContainerWithBlackShadow(
      padding: EdgeInsets.symmetric(vertical: 24.h),
      contentPadding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
      backgroundColor: AppColors.generalContainerBGMinistry,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            context.translate(LocalizationKeys.description),
            style: context.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.blackText,
            ),
          ),
          SizedBox(height: 8),
          Text(
            ministryNotificationDetailsUiModel.description,
            style: context.textTheme.labelMedium!.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
          CustomDividerWidget(verticalPadding: 24),
          DataRowWithStatusContainerWidget(
            title: context.translate(LocalizationKeys.status),
            subTitle: ministryNotificationDetailsUiModel.status,
            backgroundColor: AppColors.pendingBG,
            subTitleColor: AppColors.pendingText,
            divider: true,
          ),
          DataRowWithDivider(
            divider: true,
            title: context.translate(LocalizationKeys.alertType),
            subTitle: ministryNotificationDetailsUiModel.alertType,
          ),
          DataRowWithDivider(
            divider: true,
            title: context.translate(LocalizationKeys.creationDate),
            subTitle: ministryNotificationDetailsUiModel.createdAt,
          ),
          DataRowWithDivider(
            title: context.translate(LocalizationKeys.priority),
            subTitle: ministryNotificationDetailsUiModel.priority,
          ),
        ],
      ),
    );
  }

  Widget _headerContainer() {
    return ContainerWithBlackShadow(
      gradientBackgroundColor: getGradientByStatus(
        mapMinistryNotificationStatus(
          ministryNotificationDetailsUiModel.alertType,
        ),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      body: Column(
        children: [
          ContainerWithBackground(
            backgroundColor: mapMinistryNotificationStatus(
              ministryNotificationDetailsUiModel.alertType,
            ).backgroundColor,
            text: ministryNotificationDetailsUiModel.alertType,
            textColor: AppColors.statusTextInMinistryAlert,
          ),
          SizedBox(height: 16.h),
          Text(
            ministryNotificationDetailsUiModel.messageTitle,
            style: context.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          CustomDividerWidget(endIndent: 36, indent: 36),
          Text(
            ministryNotificationDetailsUiModel.createdAt,
            style: context.textTheme.labelMedium!.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper method ////////////////////////
  ///////////////////////////////////////////////////////////
  MinistryNotificationDetailsBloc get _currentBloc =>
      context.read<MinistryNotificationDetailsBloc>();
}
