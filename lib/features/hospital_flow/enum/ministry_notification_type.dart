enum MinistryNotificationType { danger, warning, resolved, critical }

MinistryNotificationType mapMinistryNotificationStatus(String status) {
  switch (status) {
    case 'خطر':
      return MinistryNotificationType.danger;
    case "تحذير":
      return MinistryNotificationType.warning;
    case "تم الحل":
      return MinistryNotificationType.resolved;
    case "حرج":
      return MinistryNotificationType.critical;
    default:
      return MinistryNotificationType.danger;
  }
}
