import '../models/contactsLog.dart';
import '../models/incidentReportLog.dart';
import '../models/patrolTimeLog.dart';
import '../models/supply.dart';
import '../models/weatherLog.dart';
import '../models/wildLifeSight.dart';

class PatrolTimeRequest{

  PatrolTimeLog? patrolTime;

  WeatherLog? weatherLog;

  ContactsLog? contactLog;

  String? comments;

  List<IncidentReportLog>? incidentReports;

  List<WildLifeSight>? wildlifeSights;

  List<Supply>? supplies;
  List<String>? signatures;

  Map<String, dynamic> toJson() => {
    'patrolTime': patrolTime,
    'weatherLog': weatherLog,
    'contactLog': contactLog,
    'comments': comments,
    'incidentReports': incidentReports?.map((r) => r.toJson()).toList(),
    'wildlifeSights': wildlifeSights?.map((r) => r.toJson()).toList(),
    'supplies': supplies?.map((r) => r.toJson()).toList(),
    'signatures': signatures?.toList(),
  };

}