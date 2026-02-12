part of 'hospital_information_bloc.dart';

sealed class HospitalInformationEvent extends Equatable {
  const HospitalInformationEvent();

  @override
  List<Object> get props => [];
}

class GetHospitalInformationDataEvent extends HospitalInformationEvent {}
