part of 'medical_details_bloc.dart';

sealed class MedicalDetailsState extends Equatable {
  const MedicalDetailsState();
  
  @override
  List<Object> get props => [];
}

final class MedicalDetailsInitial extends MedicalDetailsState {}
