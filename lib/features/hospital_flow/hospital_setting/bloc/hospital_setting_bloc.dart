import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:organ_link/features/hospital_flow/hospital_setting/bloc/hospital_setting_repository.dart';
import 'package:organ_link/features/hospital_flow/hospital_setting/model/hospital_information_setting_ui_model.dart';

part 'hospital_setting_event.dart';
part 'hospital_setting_state.dart';

class HospitalSettingBloc
    extends Bloc<HospitalSettingEvent, HospitalSettingState> {
  final HospitalSettingRepository hospitalSettingRepository;
  HospitalSettingBloc(this.hospitalSettingRepository)
    : super(HospitalSettingInitial()) {
    // on<LogOutEvent>(_logOutEvent);
    // on<SelectArabicLanguageEvent>(_selectArabicLanguageEvent);
    // on<SelectEnglishLanguageEvent>(_selectEnglishLanguageEvent);
    on<GetHospitalSettingDataEvent>(_hospitalSettingLoadedSuccessfullyEvent);
  }

  // FutureOr<void> _logOutEvent(
  //   LogOutEvent event,
  //   Emitter<HospitalSettingState> emit,
  // ) {
  //   emit(LogOutState());
  // }

  // FutureOr<void> _selectArabicLanguageEvent(
  //   SelectArabicLanguageEvent event,
  //   Emitter<HospitalSettingState> emit,
  // ) {
  //   emit(SelectArabicLanguageState());
  // }

  // FutureOr<void> _selectEnglishLanguageEvent(
  //   SelectEnglishLanguageEvent event,
  //   Emitter<HospitalSettingState> emit,
  // ) {
  //   emit(SelectEnglishLanguageState());
  // }
  FutureOr<void> _hospitalSettingLoadedSuccessfullyEvent(
    GetHospitalSettingDataEvent event,
    Emitter<HospitalSettingState> emit,
  ) async {
    emit(HospitalSettingLoadingState());
    emit(await hospitalSettingRepository.getHospitalInformationData());
  }
}
