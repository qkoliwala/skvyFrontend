class Supply{
  String type,number,createdBy;
  DateTime created = DateTime.now();
  Supply({required this.type, required this.number, required this.createdBy});
  Map<String, dynamic> toJson() => {
    'type': type,
    'number': number,
    'createdBy': createdBy,
    'created': created.toIso8601String(),
  };
}