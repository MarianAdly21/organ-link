enum MedicalTestStatus {
  medicalReport,
  radiology,
  labTests,
  completed,
  inProgress,
}

MedicalTestStatus mapMedicalTestStatus(String status) {
  switch (status) {
    case "قيد الإجراء":
      return MedicalTestStatus.inProgress;
    case "أشعة":
      return MedicalTestStatus.radiology;
    case "تقرير طبي":
      return MedicalTestStatus.medicalReport;
    case "مكتمل":
      return MedicalTestStatus.completed;
    case 'تحاليل':
      return MedicalTestStatus.labTests;
    default:
      return MedicalTestStatus.inProgress;
  }
}
