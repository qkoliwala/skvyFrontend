import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shark_valley/dtos/endTimerRequest.dto.dart';
import 'package:shark_valley/dtos/initLogResponse.dto.dart';
import 'package:shark_valley/dtos/startTimerRequest.dto.dart';
import 'package:shark_valley/services/logProvider.dart';
import 'package:shark_valley/services/patrolLog.service.dart';
import 'package:shark_valley/services/initLog.service.dart';
import 'package:shark_valley/services/userTimer.service.dart';
import 'package:shark_valley/vault.dart';
import 'package:intl/intl.dart';

import 'dtos/patrolLogLast10.dto.dart';

enum MenuItem { item1 }

/// This class contains the methods and tools for building
/// the front page of the app, where you will see features
/// such as thepast patrols, start and end times, log out,
/// and more.
class CompletedFormPage extends ConsumerStatefulWidget {
  const CompletedFormPage({super.key});

  @override
  ConsumerState<CompletedFormPage> createState() => _CompletedFormState();
}

class _CompletedFormState extends ConsumerState<CompletedFormPage> {
  // These future variables will contain the information for the
  // last 10 patrols that will be displayed in the screem
  late Future<PatrolLogLast10Response> patrolLogsResponse;
  late Future<InitLogResponse> intiLogs;
  // Key used for debuging.
  final _formKey = GlobalKey<FormState>();
  // Information message printed when hitting the info button.
  final _infoMessage =
      "This page displays all the patrols you have submitted previously" +
          " with the number of the patrol log, the day and the hour when" +
          " it was sent.\n" +
          "- User Logs - Shows the number of logs you submitted.\n" +
          "- Total Logs - Shows the next Patrol Log number.";

  // Variables used to check the start/submit/end patrol button.
  var startedPatrol = false;
  var endedPatrol = false;
  var showSubmit = false;

  /// This function is used to initialize the patrol logs
  /// with the information from the database.
  @override
  void initState() {
    super.initState();
    patrolLogsResponse = getPatrolLogs();
    intiLogs = getInitLog();
  }

  /// This method creates a SnackBar component which takes
  /// as an input a String which can print an information
  /// in screen when you want to send out infomation to the user.
  SnackBar infoMessage(String str) {
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        height: 240,
        decoration: const BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Text(str),
      ),
    );
  }

  /// This is the main build function which builds the current page
  /// that will be displayed in the application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // This is the appbar which contains certain buttons to
      // perform certain functions that will be explained below.
      appBar: AppBar(
        leading: IconButton(
          // Prints out information about the current page
          onPressed: () {
            ScaffoldMessenger.of(context)
                .showSnackBar(infoMessage(_infoMessage));
          },
          icon: const Icon(Icons.info_outline),
        ),
        title: const Text('Patrol Log Manager'), // App bar title.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          // Currently does not do anything but to implement group functionality
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.group),
          ),
          // Creates a popup menu button for the sign out functionality.
          PopupMenuButton<MenuItem>(
            onSelected: (value) {
              // When you want to sign out, reset the user details in the vault.
              if (value == MenuItem.item1) {
                Vault.email = "";
                Vault.userId = "";
                Vault.userName = "";
                context.go('/loginPage');
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: MenuItem.item1,
                child: Text("Sign Out"),
              ),
            ],
          ),
        ],
      ),
      // Below we will be working on the body of the code.
      body: Form(
        key: _formKey,
        child: Scrollbar(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: AutofillGroup(
              child: Column(
                children: [
                  ...[
                    const ListTile(
                      leading: Icon(Icons.note),
                      title: Text('Log History and Tasks'),
                      subtitle: Text('Check logs, start/end/submit patrol'),
                    ),
                    // Below we implement the log creator and the start/create/end
                    // patrol functionality.
                    FutureBuilder<InitLogResponse>(
                      future: intiLogs,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var isCreator = snapshot.data!.isCreator;
                          var isCreated = snapshot.data!.isCreated!;

                          var hasStartedPatrol =
                              snapshot.data!.hasStartedPatrol!;
                          var hasEndedPatrol = snapshot.data!.hasEndedPatrol!;

                          print(hasEndedPatrol);

                          if (!isCreated) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Visibility(
                                  visible: true,
                                  child: ElevatedButton(
                                    child: const Text('Create New Log'),
                                    onPressed: () {
                                      ref
                                          .read(patrolLogProvider.notifier)
                                          .reset();
                                      context.go('/createLog');
                                    },
                                  ),
                                  //const SizedBox(width: 8),
                                ),
                              ],
                            );
                          } else if (isCreated) {
                            // adding visibility to buttons so they show based on criteria
                            return Visibility(
                              visible: true,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  if (!hasStartedPatrol)
                                    Visibility(
                                      visible: !startedPatrol,
                                      child: ElevatedButton(
                                        child: const Text('Start Patrol'),
                                        onPressed: () {
                                          StartTimer startTimerRequest =
                                              StartTimer();

                                          final now = DateTime.now();
                                          String formatter =
                                              DateFormat('yyyy-MM-ddTHH:mm:ss')
                                                  .format(now);

                                          startTimerRequest.time = formatter;

                                          startTimer(startTimerRequest);

                                          setState(() {
                                            startedPatrol = true;
                                          });
                                        },
                                      ),
                                    ),
                                  if (hasStartedPatrol || startedPatrol)
                                    Visibility(
                                      visible: isCreator,
                                      child: ElevatedButton(
                                        child: const Text('Submit Log'),
                                        onPressed: () {
                                          ref
                                              .read(patrolLogProvider.notifier)
                                              .reset();
                                          context.go('/logTimesPage');
                                        },
                                      ),
                                      //const SizedBox(width: 8),
                                    ),
                                  if ((hasStartedPatrol || startedPatrol) &&
                                      !hasEndedPatrol)
                                    Visibility(
                                      visible: !endedPatrol,
                                      child: ElevatedButton(
                                        child: const Text('End Patrol'),
                                        onPressed: () {
                                          EndTimer endTimerRequest = EndTimer();

                                          final now = DateTime.now();
                                          String formatter =
                                              DateFormat('yyyy-MM-ddTHH:mm:ss')
                                                  .format(now);

                                          endTimerRequest.time = formatter;

                                          endTimer(endTimerRequest);

                                          setState(() {
                                            endedPatrol = true;
                                          });
                                        },
                                      ),
                                      //const SizedBox(width: 8),
                                    ),
                                ],
                              ),
                            );
                          }
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }

                        // Return circular spinner if data is not loaded
                        return const CircularProgressIndicator();
                      },
                    ),
                    FutureBuilder<PatrolLogLast10Response>(
                      future: patrolLogsResponse,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<PatrolLogResponse> patrolLogsResponse =
                              snapshot.data!.userPatrolLogs!;
                          return Column(children: [
                            const Divider(height: 2),
                            SizedBox(
                                height: 450, // Constrain height.
                                child: Scrollbar(
                                  child: ListView.separated(
                                    itemCount: patrolLogsResponse.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return ListTile(
                                        leading: CircleAvatar(
                                            child: Text(Vault.userName![0])),
                                        title: Text(patrolLogsResponse[index]
                                            .patrolNo
                                            .toString()),
                                        subtitle: Text(
                                            patrolLogsResponse[index].created!),
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            const Divider(height: 1),
                                  ),
                                )),
                            const Divider(height: 2),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(children: [
                              const SizedBox(
                                width: 50,
                              ),
                              Text(
                                'User Logs: ${snapshot.data!.userPatrolLogsCount.toString()}',
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 50,
                              ),
                              Text(
                                  'Total Logs: ${snapshot.data!.patroLogsCount.toString()}',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold))
                            ]),
                          ]);
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }

                        // By default, show a loading spinner.
                        return const CircularProgressIndicator();
                      },
                    ),
                  ].expand(
                    (widget) => [
                      widget,
                      const SizedBox(
                        height: 24,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
