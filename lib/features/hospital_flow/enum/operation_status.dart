enum OperationStatus { scheduled, successful, ongoing, underObservation }

OperationStatus mapOperationStatus(String status) {
  switch (status) {
    case 'scheduled':
      return OperationStatus.scheduled;
    case "successful":
      return OperationStatus.successful;
    case "in_progress":
      return OperationStatus.ongoing;
    case "under_follow_up":
      return OperationStatus.underObservation;
    default:
      return OperationStatus.scheduled;
  }
}
