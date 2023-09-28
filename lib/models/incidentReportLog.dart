class IncidentReportLog{
  String type,description,createdBy;
  DateTime created = DateTime.now();
  IncidentReportLog({required this.type, required this.description, required this.createdBy});
  Map<String, dynamic> toJson() => {
    'type': type,
    'description': description,
    'createdBy': createdBy.toString(),
    'created': created.toIso8601String(),
  };

}