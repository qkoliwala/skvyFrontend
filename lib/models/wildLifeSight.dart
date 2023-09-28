class WildLifeSight{
  String image,name,createdBy;
  String? localImagePath;
  int amount;
  DateTime created = DateTime.now();
  WildLifeSight({ required this.name,required this.amount,this.image='',required this.createdBy, this.localImagePath=''});

  Map<String, dynamic> toJson() => {
    'image': image,
    'name': name,
    'createdBy': createdBy,
    'amount': amount,
    'created': created.toIso8601String(),
  };
}