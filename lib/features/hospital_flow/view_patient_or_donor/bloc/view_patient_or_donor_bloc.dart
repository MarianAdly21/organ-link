import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:organ_link/features/hospital_flow/enum/nav_type.dart';
import 'package:organ_link/features/hospital_flow/view_patient_or_donor/bloc/view_patient_or_donor_repository.dart';
import 'package:organ_link/features/hospital_flow/view_patient_or_donor/models/patient_or_donor_ui_model.dart';

part 'view_patient_or_donor_event.dart';
part 'view_patient_or_donor_state.dart';

class ViewPatientOrDonorBloc
    extends Bloc<ViewPatientOrDonorEvent, ViewPatientOrDonorState> {
  final ViewPatientOrDonorRepository viewPatientOrDonorRepository;
  ViewPatientOrDonorBloc(this.viewPatientOrDonorRepository)
    : super(ViewPatientOrDonorInitial()) {
    on<GetViewPatientOrDonorDataEvent>(_getList);
    on<SearchByNamePatientOrDonorEvent>(_getSearchedList);
    on<SearchByOrganOrStatusPatientOrDonorEvent>(
      _getSearchedByOrganOrStatusList,
    );
    on<NavToDetailsScreenEvent>(_navToDetailsScreenEvent);
  }

  FutureOr<void> _navToDetailsScreenEvent(
    NavToDetailsScreenEvent event,
    Emitter<ViewPatientOrDonorState> emit,
  ) {
    emit(NavToDetailsScreenState(id: event.id));
  }

  List<PatientOrDonorUiModel> _patientOrDonorList = [];
  String _selectedOrgan = '';
  String _selectedCase = '';
  String _searchQuery = '';


  FutureOr<void> _getList(
    GetViewPatientOrDonorDataEvent event,
    Emitter<ViewPatientOrDonorState> emit,
  ) async {
    emit(ViewPatientOrDonorLoadingState());

    ViewPatientOrDonorState responseState;

    if (event.type == NavType.donor) {
      responseState = await viewPatientOrDonorRepository.getViewDonorData();
    } else {
      responseState = await viewPatientOrDonorRepository.getViewPatientData();
    }

    if (responseState is ViewPatientOrDonorDataLoadedSuccessfullyState) {
      _patientOrDonorList = responseState.donorOrPatientList;
    }

    emit(responseState);
  }

  void _applyFilters(Emitter<ViewPatientOrDonorState> emit) {
    final filteredList = _patientOrDonorList.where((item) {
      final matchSearch =
          item.fullName.toLowerCase().contains(_searchQuery) ||
          item.medicalRecordNumber.toLowerCase().contains(_searchQuery);

      final matchOrgan = _selectedOrgan.isEmpty || item.organ == _selectedOrgan;
      final matchCase = _selectedCase.isEmpty || item.status == _selectedCase;

      return matchSearch && matchOrgan && matchCase;
    }).toList();

    emit(
      ViewPatientOrDonorDataLoadedSuccessfullyState(
        donorOrPatientList: filteredList,
      ),
    );
  }

  FutureOr<void> _getSearchedByOrganOrStatusList(
    SearchByOrganOrStatusPatientOrDonorEvent event,
    Emitter<ViewPatientOrDonorState> emit,
  ) async {
    _selectedOrgan = event.organ;
    _selectedCase = event.status;
    _applyFilters(emit);
  }

  FutureOr<void> _getSearchedList(
    SearchByNamePatientOrDonorEvent event,
    Emitter<ViewPatientOrDonorState> emit,
  ) {
    _searchQuery = event.query.trim().toLowerCase();
    _applyFilters(emit);

    // final query = event.query.trim().toLowerCase();
    // if (query.isEmpty) {
    //   emit(
    //     ViewPatientOrDonorDataLoadedSuccessfullyState(
    //       donorOrPatientList: _patientOrDonorList,
    //     ),
    //   );
    //   return;
    // }

    // final filteredList = _patientOrDonorList.where((item) {
    //   return item.fullName.toLowerCase().contains(query) ||
    //       item.medicalRecordNumber.toLowerCase().contains(query);
    // }).toList();

    // emit(
    //   ViewPatientOrDonorDataLoadedSuccessfullyState(
    //     donorOrPatientList: filteredList,
    //   ),
    // );
  }
}
