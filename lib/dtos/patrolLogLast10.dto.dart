class PatrolLogLast10Response{
  List<PatrolLogResponse>? userPatrolLogs;
  int? userPatrolLogsCount;
  int? patroLogsCount;

  PatrolLogLast10Response.fromJson(Map<String, dynamic> json)
      : userPatrolLogs = List<PatrolLogResponse>.from(json['userPatrolLogs'].map((model)=> PatrolLogResponse.fromJson(model))),
        userPatrolLogsCount = json['userPatrolLogsCount'],
        patroLogsCount = json['patroLogsCount'];

}

class PatrolLogResponse{
  String? patrolNo;
  String? created;

  PatrolLogResponse.fromJson(Map<String, dynamic> json)
      : patrolNo = json['patrolNo'],
        created = json['created'];
}