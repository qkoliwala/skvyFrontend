class EndTimer {
  String? time;

  Map<String, dynamic> toJson() => {
        'EndedPatrolTime': time,
      };
}
