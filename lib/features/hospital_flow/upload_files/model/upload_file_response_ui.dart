import 'package:organ_link/apis/models/hospital/upload_file/upload_file_response.dart';

class UploadFileResponseUi {
  final String message;
  UploadFileResponseUi({required this.message});

  factory UploadFileResponseUi.fromApiModel(UploadFileResponse e) {
    return UploadFileResponseUi(message: e.message);
  }
}
