class SurgeryUiModel {
  final String surgeryName;
  final String surgeryNumber;
 final String patientName;
  final String donorName;
  final String hospitalName;
  final String date;
 final OperationStatus surgeryState;

  SurgeryUiModel({required this.surgeryName, required this.surgeryNumber, required this.surgeryState, required this.patientName, required this.donorName, required this.hospitalName, required this.date,});

  factory SurgeryUiModel.fromJson(Map<String,dynamic> json)
  {
    return SurgeryUiModel(
      surgeryName: json[""],
      surgeryNumber: json["surgeryNumber"],
      patientName: json["patientName"], 
      donorName: json["donorName"], 
      hospitalName: json["hospitalName"],
      date: json["date"],
      surgeryState:mapOperationStatus(json["surgeryState"]) , 
     );
  }
}



enum OperationStatus {
  scheduled,
  completed,
  ongoing,
  underObservation,
}

OperationStatus mapOperationStatus(String status) {
  switch (status) {
    case 'scheduled':
      return OperationStatus.scheduled;
    case 'completed':
      return OperationStatus.completed;
    case 'ongoing':
      return OperationStatus.ongoing;
    case 'under_observation':
      return OperationStatus.underObservation;
    default:
      return OperationStatus.scheduled;
  }
}

