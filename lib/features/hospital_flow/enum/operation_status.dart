enum OperationStatus { scheduled, completed, ongoing, underObservation }

OperationStatus mapOperationStatus(String status) {
  switch (status) {
    case 'مجدولة':
      return OperationStatus.scheduled;
    case 'تمت بنجاح':
      return OperationStatus.completed;
    case 'جارية':
      return OperationStatus.ongoing;
    case 'تحت المتابعة':
      return OperationStatus.underObservation;
    default:
      return OperationStatus.scheduled;
  }
}
