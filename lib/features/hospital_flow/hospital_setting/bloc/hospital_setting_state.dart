part of 'hospital_setting_bloc.dart';

sealed class HospitalSettingState extends Equatable {
  const HospitalSettingState();

  @override
  List<Object> get props => [];
}

final class HospitalSettingInitial extends HospitalSettingState {}

final class HospitalSettingErrorState extends HospitalSettingState {
   final String errorMessage;
  final int codeError;

 const HospitalSettingErrorState({required this.errorMessage, required this.codeError});
}

final class HospitalSettingLoadingState extends HospitalSettingState {}

final class HospitalSettingLoadedSuccessfullyState
    extends HospitalSettingState {
  final HospitalInformationSettingUiModel hospitalInformationSettingUiModel;

  const HospitalSettingLoadedSuccessfullyState({
    required this.hospitalInformationSettingUiModel,
  });
}

// final class SelectEnglishLanguageState extends HospitalSettingState {}

// final class SelectArabicLanguageState extends HospitalSettingState {}

// final class LogOutState extends HospitalSettingState {}
