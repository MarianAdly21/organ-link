part of 'medical_details_bloc.dart';

sealed class MedicalDetailsEvent extends Equatable {
  const MedicalDetailsEvent();

  @override
  List<Object> get props => [];
}


class GetMedicalDetailsDataEvent extends MedicalDetailsEvent {
  
}
