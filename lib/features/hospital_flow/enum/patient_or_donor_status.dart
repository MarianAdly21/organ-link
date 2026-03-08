enum PatientOrDonorStatus {
  ready,
  underMatching,
  underReview,
  surgeryCompleted,
  donationCompleted,
  goodHealth,
  excellentHealth,
  veryGoodHealth,
  mediumPriority,
  highPriority,
  lowPriority,
}

PatientOrDonorStatus mapPatientOrDonorStatus(String status) {
  switch (status) {
    case "تمت العملية":
      return PatientOrDonorStatus.surgeryCompleted;
    case "تحت المراجعة":
      return PatientOrDonorStatus.underReview;
    case "تحت المطابقة":
      return PatientOrDonorStatus.underMatching;
    case "جاهز":
      return PatientOrDonorStatus.ready;
    case "تم التبرع":
      return PatientOrDonorStatus.donationCompleted;
    case "صحة جيدة":
      return PatientOrDonorStatus.goodHealth;
    case 'صحة ممتازة':
      return PatientOrDonorStatus.excellentHealth;
    case 'صحة جيدة جدًا':
      return PatientOrDonorStatus.veryGoodHealth;
    case "أولوية متوسطة":
      return PatientOrDonorStatus.mediumPriority;
    case "أولوية عالية":
      return PatientOrDonorStatus.highPriority;
    case  "اولوليه منخفضه":
      return PatientOrDonorStatus.lowPriority;
    default:
      return PatientOrDonorStatus.underReview;
  }
}
