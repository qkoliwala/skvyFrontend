import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:shark_valley/completedForm.dart';
import 'package:shark_valley/contactWithVisitor.dart';
import 'package:shark_valley/entry_page.dart';
import 'package:shark_valley/incidentsReportPage.dart';
import 'package:shark_valley/logSubmitionConfirmation.dart';
import 'package:shark_valley/logTimes.dart';
import 'package:shark_valley/newIncident.dart';
import 'package:shark_valley/normal_user.dart';
import 'package:shark_valley/notes.dart';
import 'package:shark_valley/signUpPage.dart';
import 'package:shark_valley/signatures.dart';
import 'package:shark_valley/suppliesExpended.dart';
import 'package:shark_valley/userInfo.dart';
import 'package:shark_valley/weather.dart';
import 'package:shark_valley/wildlife.dart';
import 'package:shark_valley/initiLog.dart';

import 'login.dart';
import 'main.dart';
import 'newSignature.dart';
import 'newSupply.dart';

class CustomRoute {
  final String name;
  final String path;
  final WidgetBuilder builder;
  const CustomRoute(
      {required this.name, required this.path, required this.builder});
}

final routes = [
  CustomRoute(
    name: 'LoginPage',
    path: 'loginPage',
    builder: (context) => const LoginPage(),
  ),
  CustomRoute(
    name: 'LogTimesPage',
    path: 'logTimesPage',
    builder: (context) => LogTimesPage(),
  ),
  CustomRoute(
    name: 'FirstPage',
    path: 'firstPage',
    builder: (context) => const MyHomePage(title: "Shark Valley Patrol Log"),
  ),
  CustomRoute(
    name: 'WeatherPage',
    path: 'weatherPage',
    builder: (context) => WeatherPage(),
  ),
  CustomRoute(
    name: 'ContactWithVisitorPage',
    path: 'contactWithVisitorPage',
    builder: (context) => ContactWithVisitorPage(),
  ),
  CustomRoute(
    name: 'IncidentsReportPage',
    path: 'incidentsReportPage',
    builder: (context) => const IncidentsReportPage(),
  ),
  CustomRoute(
    name: 'NewIncidentPage',
    path: 'newIncidentPage',
    builder: (context) => NewIncidentPage(),
  ),
  CustomRoute(
    name: 'SuppliesExpendedPage',
    path: 'suppliesExpendedPage',
    builder: (context) => SuppliesExpendedPage(),
  ),
  CustomRoute(
    name: 'NewSupplyPage',
    path: 'newSupplyPage',
    builder: (context) => const NewSupplyPage(),
  ),
  CustomRoute(
    name: 'wildLifePage',
    path: 'wildLifePage',
    builder: (context) => const WildLifePage(),
  ),
  CustomRoute(
    name: 'notesPage',
    path: 'notesPage',
    builder: (context) => NotesPage(),
  ),
  CustomRoute(
    name: 'signaturesPage',
    path: 'signaturesPage',
    builder: (context) => const SignaturesPage(),
  ),
  CustomRoute(
    name: 'newSignaturePage',
    path: 'newSignaturePage',
    builder: (context) => const NewSignaturePage(),
  ),
  CustomRoute(
    name: 'completedFormPage',
    path: 'completedFormPage',
    builder: (context) => CompletedFormPage(),
  ),
  CustomRoute(
    name: 'signUpPage',
    path: 'signUpPage',
    builder: (context) => const SignUpPage(),
  ),
  CustomRoute(
    name: 'entryPage',
    path: 'entryPage',
    builder: (context) => const EntryPage(),
  ),
  CustomRoute(
    name: 'createLog',
    path: 'createLog',
    builder: (context) => InitLog(),
  ),
  CustomRoute(
    name: 'logConfirmation',
    path: 'logConfirmation',
    builder: (context) => LogConfirmation(),
  ),
  CustomRoute(
    name: 'userInfo',
    path: 'userInfo',
    builder: (context) => const UserInfo(),
  ),
];

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginPage(),
      routes: [
        for (final route in routes)
          GoRoute(
            path: route.path,
            builder: (context, state) => route.builder(context),
          ),
      ],
    ),
  ],
);
