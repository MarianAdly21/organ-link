part of 'hospital_details_bloc.dart';

sealed class HospitalDetailsEvent extends Equatable {
  const HospitalDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetHospitalDetailsDataEvent extends HospitalDetailsEvent {
  final int id;
  const GetHospitalDetailsDataEvent({required this.id});
}
