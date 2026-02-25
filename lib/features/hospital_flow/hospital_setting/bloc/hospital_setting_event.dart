part of 'hospital_setting_bloc.dart';

sealed class HospitalSettingEvent extends Equatable {
  const HospitalSettingEvent();

  @override
  List<Object> get props => [];
}

final class GetHospitalSettingDataEvent
    extends HospitalSettingEvent {}

// final class SelectEnglishLanguageEvent extends HospitalSettingEvent {}

// final class SelectArabicLanguageEvent extends HospitalSettingEvent {}

// final class LogOutEvent extends HospitalSettingEvent {}
