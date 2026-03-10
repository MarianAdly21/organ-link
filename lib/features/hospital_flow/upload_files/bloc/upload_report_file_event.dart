part of 'upload_report_file_bloc.dart';

sealed class UploadReportFileEvent extends Equatable {
  const UploadReportFileEvent();

  @override
  List<Object> get props => [];
}

class ValidateReportDateEvent extends UploadReportFileEvent {
  final File? reportFile;
  final String? reportType;
  final String? reportName;
  final String? examDate;

  const ValidateReportDateEvent({
    required this.reportFile,
    required this.reportType,
    required this.reportName,
    required this.examDate,
  });
  @override
  List<Object> get props => [identityHashCode(this)];
}

class UploadReportDataEvent extends UploadReportFileEvent {
  final UploadReportFileUiModel uploadReportFileUiModel;

  const UploadReportDataEvent({required this.uploadReportFileUiModel});
}
