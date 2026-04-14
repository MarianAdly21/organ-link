enum HospitalStatus { ready, underReview,}

HospitalStatus mapHospitalStatus(String status) {
  switch (status) {
    case 'جاهز':
      return HospitalStatus.ready;
    case "تحت المراجعه":
      return HospitalStatus.underReview;
    default:
      return HospitalStatus.underReview;
  }
}
