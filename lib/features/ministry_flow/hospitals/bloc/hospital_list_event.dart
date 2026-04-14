part of 'hospital_list_bloc.dart';

sealed class HospitalListEvent extends Equatable {
  const HospitalListEvent();

  @override
  List<Object> get props => [];
}

class GetHospitalListDataEvent extends HospitalListEvent {}

class NavToHospitalDetailsScreenEvent extends HospitalListEvent {
  final int id;

  const NavToHospitalDetailsScreenEvent({required this.id});
}
