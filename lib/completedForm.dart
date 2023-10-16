import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shark_valley/dtos/initLogResponse.dto.dart';
import 'package:shark_valley/dtos/patrolTimeRequest.dto.dart';
import 'package:shark_valley/dtos/startTimerRequest.dto.dart';
import 'package:shark_valley/initiLog.dart';
import 'package:shark_valley/services/logProvider.dart';
import 'package:shark_valley/services/patrolLog.service.dart';
import 'package:shark_valley/services/initLog.service.dart';
import 'package:shark_valley/services/userTimer.service.dart';
import 'package:shark_valley/vault.dart';
import 'package:intl/intl.dart';

import 'dtos/patrolLogLast10.dto.dart';

class CompletedFormPage extends ConsumerStatefulWidget {
  const CompletedFormPage({super.key});

  @override
  ConsumerState<CompletedFormPage> createState() => _CompletedFormState();
}

class _CompletedFormState extends ConsumerState<CompletedFormPage> {
  late Future<PatrolLogLast10Response> patrolLogsResponse;
  late Future<InitLogResponse> intiLogs;
  final _formKey = GlobalKey<FormState>();

  var startedPatrol = false;
  var endedPatrol = false;
  var showSubmit = false;

  @override
  void initState() {
    super.initState();
    patrolLogsResponse = getPatrolLogs();
    intiLogs = getInitLog();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.info_outline),
        ),
        title: const Text('Log Submitted'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          const Icon(Icons.group),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          )
        ],
      ),
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
                      leading: Icon(Icons.emoji_emotions),
                      title: Text('Log Submitted'),
                      subtitle:
                          Text('Your log have been submitted successfully'),
                    ),
                    FutureBuilder<InitLogResponse>(
                        future: intiLogs,
                        builder: (context, snapshot) {

                        if (snapshot.hasData) {
                          
                          print(snapshot.data!.isCreated!);
                            // adding visibility to buttons so they show based on criteria
                            if(snapshot.data!.isCreated!){
                            return Visibility(
                              visible: snapshot.data!.isCreated!,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Visibility(
                                    visible: snapshot.data!.isCreated!,
                                    child: TextButton(
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
                                  Visibility(
                                    visible: !startedPatrol,
                                    child: TextButton(
                                      child: const Text('Start Patrol'),
                                      onPressed: () {
                                        StartTimer startTimerRequest =
                                            StartTimer();

                                        final now = DateTime.now();
                                        String formatter =
                                            DateFormat('yyyy-MM-ddTHH:mm:ss')
                                                .format(now);

                                        startTimerRequest.email = Vault.email;
                                        startTimerRequest.time = formatter;

                                        startTimer(startTimerRequest);

                                        setState(() {
                                          startedPatrol = true;
                                        });
                                      },
                                    ),
                                  ),
                                  Visibility(
                                    visible: startedPatrol && !endedPatrol,
                                    child: TextButton(
                                      child: const Text('End Patrol'),
                                      onPressed: () {
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

                          
                            var isCreator = snapshot.data!.isCreator;

                            if (!snapshot.data!.isCreated!) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Visibility(
                                    visible: true,
                                    child: TextButton(
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
                            }



                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }

                          // Return circular spinner if data is not loaded
                          return const CircularProgressIndicator();
                        }),
                    FutureBuilder<PatrolLogLast10Response>(
                      future: patrolLogsResponse,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<PatrolLogResponse> patrolLogsResponse =
                              snapshot.data!.userPatrolLogs!;
                          return Column(children: [
                            const Divider(height: 2),
                            SizedBox(
                                height: 500, // Constrain height.
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
