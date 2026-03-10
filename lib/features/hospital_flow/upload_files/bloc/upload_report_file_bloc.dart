import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:organ_link/features/hospital_flow/upload_files/model/upload_report_file_ui_model.dart';

part 'upload_report_file_event.dart';
part 'upload_report_file_state.dart';

class UploadReportFileBloc
    extends Bloc<UploadReportFileEvent, UploadReportFileState> {
  UploadReportFileBloc() : super(UploadReportFileInitial()) {
    on<ValidateReportDateEvent>(_validateReportDataEvent);
    on<UploadReportDataEvent>(_uploadReportDataEvent);
  }

  FutureOr<void> _uploadReportDataEvent(
    UploadReportDataEvent event,
    Emitter<UploadReportFileState> emit,
  ) async {
    emit(UploadReportFileLoadingState());
    // emit(UploadReportFileSuccessfullyState());
  }

  FutureOr<void> _validateReportDataEvent(
    ValidateReportDateEvent event,
    Emitter<UploadReportFileState> emit,
  ) async {
    if (event.reportFile != null &&
        event.examDate != null &&
        event.reportName != null &&
        event.reportType != null) {
      emit(UploadReportFileValidatedState());
    } else {
      emit(UploadReportFileNotValidatedState());
    }

    // if (event.reportFormKey.currentState?.validate() ?? false) {
    //   if (event.reportFile == null) {
    //     emit(UploadReportFileNotValidatedState());
    //     return;
    //   }
    //   event.reportFormKey.currentState!.save();
    //   emit(UploadReportFileValidatedState());
    // } else {
    //   emit(UploadReportFileNotValidatedState());
    // }
  }
}
