import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:shark_valley/completedForm.dart';
import 'package:shark_valley/contactWithVisitor.dart';
import 'package:shark_valley/entry_page.dart';
import 'package:shark_valley/incidentsReportPage.dart';
import 'package:shark_valley/logSubmitionConfirmation.dart';
import 'package:shark_valley/logTimes.dart';
import 'package:shark_valley/newIncident.dart';
import 'package:shark_valley/notes.dart';
import 'package:shark_valley/signUpPage.dart';
import 'package:shark_valley/signatures.dart';
import 'package:shark_valley/suppliesExpended.dart';
import 'package:shark_valley/weather.dart';
import 'package:shark_valley/wildlife.dart';
import 'package:shark_valley/initiLog.dart';

import 'login.dart';
import 'main.dart';
import 'newSignature.dart';
import 'newSupply.dart';

/// This is one of the most important classes in this program,
/// since it is used as the main rerouter of the current context
/// of the program. Each time there is a need to progress from
/// one page to the other, you can use the context.go("/path_to")
/// method, which reports the current context, and tells the app to go
/// to another context. If you need to add new pages to this app,
/// you will need to update this router class to allow you to
/// switch the context of the current page to the one you added,
/// when you want it to change.
///
/// For more information about how the GoRouter works, check the
/// documetation at: https://pub.dev/packages/go_router
class CustomRoute {
  final String name;
  final String path;
  final WidgetBuilder builder;
  const CustomRoute(
      {required this.name, required this.path, required this.builder});
}

/// Whenever you want to add a new page/route, you need it to
/// be added here, since the class uses the items in the list
/// below to figure out what are the known routes.
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
];

/// Whenever you are trying to change the current page and
/// opening another page, this final constant will help you
/// guide the context to where you want to go.
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
