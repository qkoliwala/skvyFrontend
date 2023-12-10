import '../models/contactsLog.dart';
import '../models/incidentReportLog.dart';
import '../models/patrolTimeLog.dart';
import '../models/supply.dart';
import '../models/weatherLog.dart';
import '../models/wildLifeSight.dart';
import 'package:flutter/material.dart';

class PatrolTimeRequest {
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
        'endTime': convertToDate(patrolTime!.completedPatrol).toIso8601String(),
      };

  DateTime convertToDate(TimeOfDay? timeOfDay) {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, timeOfDay?.hour ?? now.hour,
        timeOfDay?.minute ?? now.minute);
  }
}
