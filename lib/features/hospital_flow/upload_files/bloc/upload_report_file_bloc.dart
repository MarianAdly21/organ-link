import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:organ_link/apis/models/hospital/upload_file/upload_file_send_api_model.dart';
import 'package:organ_link/features/hospital_flow/upload_files/bloc/upload_report_file_repository.dart';
import 'package:organ_link/features/hospital_flow/upload_files/model/upload_file_response_ui.dart';
import 'package:organ_link/features/hospital_flow/upload_files/model/upload_report_file_ui_model.dart';

part 'upload_report_file_event.dart';
part 'upload_report_file_state.dart';

class UploadReportFileBloc
    extends Bloc<UploadReportFileEvent, UploadReportFileState> {
  final UploadReportFileRepository uploadReportFileRepository;
  UploadReportFileBloc(this.uploadReportFileRepository)
    : super(UploadReportFileInitial()) {
    on<ValidateReportDateEvent>(_validateReportDataEvent);
    on<UploadReportDataEvent>(_uploadReportDataEvent);
  }

  FutureOr<void> _uploadReportDataEvent(
    UploadReportDataEvent event,
    Emitter<UploadReportFileState> emit,
  ) async {
    emit(UploadReportFileLoadingState());
    emit(
      await uploadReportFileRepository.uploadReport(
        UploadFileSendApiModel(
          reportType: event.uploadReportFileUiModel.reportType,
          reportName: event.uploadReportFileUiModel.reportName,
          examDate: event.uploadReportFileUiModel.examDate,
          file: event.uploadReportFileUiModel.file,
          userId: event.uploadReportFileUiModel.userId,
        ),
      ),
    );
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
  }
}
