part of 'patient_or_donor_details_bloc.dart';

sealed class PatientOrDonorDetailsEvent extends Equatable {
  const PatientOrDonorDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetPatientOrDonorDetailsDataEvent extends PatientOrDonorDetailsEvent {
  final int id;

  const GetPatientOrDonorDetailsDataEvent({required this.id});
}

class AddNewReportClickEvent extends PatientOrDonorDetailsEvent {
  @override
  List<Object> get props => [identityHashCode(this)];
}
