part of 'surgery_details_bloc.dart';

sealed class SurgeryDetailsEvent extends Equatable {
  const SurgeryDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetSurgeryDetailsDataEvent extends SurgeryDetailsEvent {
  final int id;

  const GetSurgeryDetailsDataEvent({required this.id});
}

class NavToPatientOrDonorDetailsScreenEvent extends SurgeryDetailsEvent {
  final int id;
  final NavType type;


  const NavToPatientOrDonorDetailsScreenEvent({required this.id, required this.type});
}
