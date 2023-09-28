import 'package:flutter/material.dart';

class PatrolTimeLog{
DateTime? patrolDate ;
TimeOfDay? arrivalTime;
TimeOfDay? startedPatrol;
TimeOfDay? completedPatrol;
TimeOfDay? leftPatrol;

Map<String, dynamic> toJson() => {
  'patrolDate': patrolDate?.toIso8601String(),
  'arrivalTime': convertToDate(arrivalTime).toIso8601String(),
  'startedPatrol': convertToDate(startedPatrol).toIso8601String(),
  'completedPatrol': convertToDate(completedPatrol).toIso8601String(),
  'leftPatrol': convertToDate(leftPatrol).toIso8601String(),
};



DateTime convertToDate(TimeOfDay? timeOfDay){

  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day, timeOfDay?.hour??now.hour, timeOfDay?.minute??now.minute);
}

}