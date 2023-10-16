class EndTimer {
  String? email;
  DateTime? time;

  Map<String, dynamic> toJson() => {
        'email': email,
        'EndedPatrolTime': time,
      };
}
