part of 'view_patient_or_donor_bloc.dart';

sealed class ViewPatientOrDonorEvent extends Equatable {
  const ViewPatientOrDonorEvent();

  @override
  List<Object> get props => [];
}

class GetViewPatientOrDonorDataEvent extends ViewPatientOrDonorEvent {
  final NavType type;

  const GetViewPatientOrDonorDataEvent({required this.type});
}

class NavToDetailsScreenEvent extends ViewPatientOrDonorEvent {
  final int id;

  const NavToDetailsScreenEvent({required this.id});
}
