import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'medical_details_event.dart';
part 'medical_details_state.dart';

class MedicalDetailsBloc extends Bloc<MedicalDetailsEvent, MedicalDetailsState> {
  MedicalDetailsBloc() : super(MedicalDetailsInitial()) {
    on<MedicalDetailsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
