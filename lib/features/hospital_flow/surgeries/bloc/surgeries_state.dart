part of 'surgeries_bloc.dart';

sealed class SurgeriesState extends Equatable {
  const SurgeriesState();

  @override
  List<Object> get props => [];
}

final class SurgeriesInitial extends SurgeriesState {}

class SurgeriesErrorState extends SurgeriesState {
  final String errorMessage;
  final int codeError;

  const SurgeriesErrorState({
    required this.errorMessage,
    required this.codeError,
  });
}

class SurgeriesLoadingState extends SurgeriesState {}

class SurgeriesDataLoadedSuccessfullyState extends SurgeriesState {
  final List<SurgeryUiModel> surgeriesList;

  const SurgeriesDataLoadedSuccessfullyState({required this.surgeriesList});
}

class NavToSurgeryDetailsScreenState extends SurgeriesState {
  final int id;
  const NavToSurgeryDetailsScreenState({required this.id});

  @override
  List<Object> get props => [identityHashCode(this)];
}
