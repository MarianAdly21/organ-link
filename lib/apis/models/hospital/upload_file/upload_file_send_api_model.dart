import 'dart:io';

import 'package:dio/dio.dart';

class UploadFileSendApiModel {
  final String reportType;
  final String reportName;
  final String examDate;
  final int userId;
  final String? description;
  final File file;

  UploadFileSendApiModel({
    required this.reportType,
    required this.reportName,
    required this.examDate,
    required this.file,
    required this.userId,
    this.description,
  });

  Future<FormData> toFormData()async {
    return FormData.fromMap({
      "report_type": reportType,
      "report_name": reportName,
      "exam_date": examDate,
      "description": description,
      "report_file": await MultipartFile.fromFile(file.path),
      "id": userId,
    }); 
  }
}
