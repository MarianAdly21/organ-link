import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/widgets/base_stateful_screen_widget.dart';
import 'package:organ_link/apis/_base/dio_api_manager.dart';
import 'package:organ_link/apis/managers/user_manager/user_api_manager.dart';
import 'package:organ_link/features/shared_screens/screens/empty_notification_widget.dart';
import 'package:organ_link/features/user_flow/notification/bloc/notification_user_bloc.dart';
import 'package:organ_link/features/user_flow/notification/bloc/notification_user_repository.dart';
import 'package:organ_link/features/user_flow/notification/models/notification_user_ui_model.dart';
import 'package:organ_link/features/user_flow/notification/widget/notification_item.dart';
import 'package:organ_link/features/user_flow/widget/base_body_scaffold.dart';
import 'package:organ_link/features/widgets/internet_error_widget.dart';
import 'package:organ_link/preferences/preferences_manager.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/empty/empty_widgets.dart';
import 'package:organ_link/utils/feedback/feedback_message.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});
  static const routeName = "/notification-screen";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationUserBloc(
        NotificationUserRepository(
          userApiManager: UserApiManager(GetIt.I<DioApiManager>()),
          preferencesManager: GetIt.I<PreferencesManager>(),
        ),
      ),
      child: NotificationScreenWithBloc(),
    );
  }
}

class NotificationScreenWithBloc extends BaseStatefulScreenWidget {
  const NotificationScreenWithBloc({super.key});

  @override
  BaseScreenState<BaseStatefulScreenWidget> baseScreenCreateState() =>
      _NotificationScreenWithBlocState();
}

class _NotificationScreenWithBlocState
    extends BaseScreenState<NotificationScreenWithBloc> {
  late List<NotificationUserUiModel> notificationUserUiModel;
  @override
  void initState() {
    super.initState();
    _getNotificationList();
  }

  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: BaseBodyScaffold(
        title: context.translate(LocalizationKeys.notificationScreen),
        onBackTap: () {
          Navigator.pop(context);
        },
        body: BlocConsumer<NotificationUserBloc, NotificationUserState>(
          listener: (context, state) {
            if (state is NotificationUserLoadingState) {
              showLoading();
            } else {
              hideLoading();
            }
            if (state is NotificationUserErrorState &&
                state.codeError != 1016) {
              showFeedbackMessage(
                context: context,
                feedbackStyle: FeedbackStyle.snackBar,
                state.errorMessage,
              );
            } else if (state is NotificationUserDataLoadedSuccessfullyState) {
              notificationUserUiModel = state.notificationUserUiModel;
            }
          },
          buildWhen: (previous, current) =>
              current is NotificationUserDataLoadedSuccessfullyState ||
              current is NotificationUserErrorState,
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

  Widget _buildBody(NotificationUserState state) {
    if (state is NotificationUserDataLoadedSuccessfullyState) {
      return notificationUserUiModel.isEmpty
          ? EmptyNotificationScreen()
          : ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: notificationUserUiModel.length,
              itemBuilder: (context, index) {
                return NotificationItem(
                  color: notificationUserUiModel[index].notificationType == ""
                      ? AppColors.notificationImportantItemBG
                      : AppColors.notificationItemBG,
                  title: notificationUserUiModel[index].messageTitle,
                  content: notificationUserUiModel[index].messageContent,
                  date: DateFormat(
                    'dd/MM/yyyy',
                  ).format(notificationUserUiModel[index].date),
                );
              },
            );
    } else if (state is NotificationUserErrorState && state.codeError == 1016) {
      return InternetErrorWidget();
    } else {
      return EmptyWidget();
    }
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper method ////////////////////////
  ///////////////////////////////////////////////////////////

  NotificationUserBloc get _currentBloc => context.read<NotificationUserBloc>();

  void _getNotificationList() {
    _currentBloc.add(GetNotificationUserDataEvent());
  }
}
