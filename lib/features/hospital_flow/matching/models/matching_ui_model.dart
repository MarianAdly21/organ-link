class MatchingUiModel {
  final String patientName;
  final String? requestStatus;
  final String status;
  final String requestDate;
  final String donorName;
  final String requestId;
  final String organType;
  final String matchPercentage;
  final String donorBloodType;
  final String aiMessage;

  MatchingUiModel({
    required this.patientName,
    required this.requestStatus,
    required this.status,
    required this.requestDate,
    required this.donorName,
    required this.requestId,
    required this.organType,
    required this.matchPercentage,
    required this.donorBloodType,
    required this.aiMessage,
  });
}
