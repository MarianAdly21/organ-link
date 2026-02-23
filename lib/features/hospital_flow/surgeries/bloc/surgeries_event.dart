part of 'surgeries_bloc.dart';

sealed class SurgeriesEvent extends Equatable {
  const SurgeriesEvent();

  @override
  List<Object> get props => [];
}

class GetSurgeriesDataEvent extends SurgeriesEvent {}

class NavToSurgeryDetailsScreenEvent extends SurgeriesEvent {
  final int id;

  const NavToSurgeryDetailsScreenEvent({required this.id});
}
