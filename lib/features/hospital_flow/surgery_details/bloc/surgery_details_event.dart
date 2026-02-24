part of 'surgery_details_bloc.dart';

sealed class SurgeryDetailsEvent extends Equatable {
  const SurgeryDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetSurgeryDetailsDataEvent extends SurgeryDetailsEvent {
  final int id;

const  GetSurgeryDetailsDataEvent({required this.id});
}

class NavToPatientDetailsScreenEvent extends SurgeryDetailsEvent {
  final int id;

  const NavToPatientDetailsScreenEvent({required this.id});
}
class NavToDonorDetailsScreenEvent extends SurgeryDetailsEvent {
  final int id;

  const NavToDonorDetailsScreenEvent({required this.id});
}
