class UploadFileResponse {
  final String message;

  UploadFileResponse({required this.message});
  factory UploadFileResponse.fromJson(Map<String, dynamic> json) {
    return UploadFileResponse(message: json["message"]);
  }
}
