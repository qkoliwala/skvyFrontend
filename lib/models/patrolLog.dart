import 'package:flutter/cupertino.dart';
import 'package:shark_valley/models/contactsLog.dart';
import 'package:shark_valley/models/incidentReportLog.dart';
import 'package:shark_valley/models/patrolTimeLog.dart';
import 'package:shark_valley/models/supply.dart';
import 'package:shark_valley/models/weatherLog.dart';
import 'package:shark_valley/models/wildLifeSight.dart';

class PatrolLog extends ChangeNotifier{

  PatrolTimeLog patrolTime = PatrolTimeLog();
  void setPatrolTimeLog(PatrolTimeLog patrolTime) {
    this.patrolTime = patrolTime;
    notifyListeners();
  }

  WeatherLog weatherLog = WeatherLog();
  void setWeatherLog(WeatherLog weatherLog) {
    this.weatherLog = weatherLog;
    notifyListeners();
  }
  ContactsLog contactLog = ContactsLog();
  void setContactLog(ContactsLog contactLog) {
    this.contactLog = contactLog;
    notifyListeners();
  }

  String? comments;
  void setComments(String comments) {
    this.comments = comments;
    notifyListeners();
  }

  List<IncidentReportLog> incidentReports = [];
  void addIncidentReport(IncidentReportLog incidentReport) {
    incidentReports.add(incidentReport);
    notifyListeners();
  }
  void removeIncidentReportAt(int index){
    incidentReports.removeAt(index);
    notifyListeners();
  }

  List<WildLifeSight> wildlifeSights =[
  ];
  void addWildLifeSight(WildLifeSight wildLifeSight) {
    wildlifeSights.add(wildLifeSight);
    notifyListeners();
  }
  void removeWildLifeSightAt(int index){
    wildlifeSights.removeAt(index);
    notifyListeners();
  }

  void addOrUpdateWildLifeSight(WildLifeSight wildLifeSight){
    int sightIndex = wildlifeSights.indexWhere((sight) => sight.name == wildLifeSight.name);
  if(sightIndex > -1){

   wildlifeSights[sightIndex] = wildLifeSight;
        }
  else {
    wildlifeSights.add(wildLifeSight);
  }
  }

  List<Supply> supplies = [];
  void addSupply(Supply supply) {
    supplies.add(supply);
    notifyListeners();
  }
  void removeSupplyAt(int index){
    supplies.removeAt(index);
    notifyListeners();
  }


  List<String> signatures = [];
  void addSignature(String sign) {
    signatures.add(sign);
    notifyListeners();
  }
  void removeSignatureAt(int index){
    signatures.removeAt(index);
    notifyListeners();
  }

  void reset(){
  patrolTime = PatrolTimeLog();
  weatherLog = WeatherLog();
  contactLog = ContactsLog();
  incidentReports = [];
  wildlifeSights = [
  ];
  supplies = [];
  comments ="";
  signatures=[];
  notifyListeners();
  }

}

const wildLifeDefaultItems =["Alligator","Crocodile","Turtle", "G Bl Heron", "L Bl Heron", "Rat Snake", "Tri Heron", "Gr Heron",
"Great Egret", "Snowy Egret", "White Ibis", "Glades Racer", "Glossy Ibis", "Red S Hawk", "Tky Vulture", "Blk Vulture", "Am Crow", "Python", "Anhinga", "Corm’r’nt", "Limpkin", "W Stork", "Spoonbill", "Other Snake"];