part of 'upload_report_file_bloc.dart';

sealed class UploadReportFileState extends Equatable {
  const UploadReportFileState();

  @override
  List<Object> get props => [];
}

final class UploadReportFileInitial extends UploadReportFileState {}

final class UploadReportFileLoadingState extends UploadReportFileState {}

final class UploadReportFileErrorState extends UploadReportFileState {
  final String errorMessage;
  final int codeError;

  const UploadReportFileErrorState({
    required this.errorMessage,
    required this.codeError,
  });
}

final class UploadReportFileValidatedState extends UploadReportFileState {
  @override
  List<Object> get props => [identityHashCode(this)];
}

final class UploadReportFileNotValidatedState extends UploadReportFileState {
  @override
  List<Object> get props => [identityHashCode(this)];
}

final class UploadReportFileSuccessfullyState extends UploadReportFileState {
  final UploadFileResponseUi uploadFileResponseUi;

 const UploadReportFileSuccessfullyState({required this.uploadFileResponseUi});
}
