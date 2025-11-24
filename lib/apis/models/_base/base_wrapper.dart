abstract class BaseWrapper {
  final bool? isSuccess;
  final String? message;

  BaseWrapper(this.isSuccess, this.message);

  BaseWrapper.fromJson(Map<String, dynamic> json)
      : isSuccess = json['success'] != null ? json['success'] as bool : null,
        message = json['message'] != null ? json['message'] as String? : null;
}
