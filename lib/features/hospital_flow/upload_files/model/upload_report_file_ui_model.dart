import 'dart:io';

class UploadReportFileUiModel {
  final String reportType;
  final String reportName;
  final String examDate;
  final int userId;
  final String? description;
  final File file;

  UploadReportFileUiModel({
    required this.reportType,
    required this.reportName,
    required this.examDate,
    required this.userId,
    required this.description,
    required this.file,
  });
}
