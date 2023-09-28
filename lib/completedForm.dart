import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shark_valley/dtos/patrolTimeRequest.dto.dart';
import 'package:shark_valley/services/logProvider.dart';
import 'package:shark_valley/services/patrolLog.service.dart';
import 'package:shark_valley/vault.dart';

import 'dtos/patrolLogLast10.dto.dart';

class CompletedFormPage extends ConsumerStatefulWidget {
  const CompletedFormPage({super.key});

  @override
  ConsumerState<CompletedFormPage> createState() => _CompletedFormState();
}

class _CompletedFormState extends ConsumerState<CompletedFormPage> {
  late Future<PatrolLogLast10Response> patrolLogsResponse;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    patrolLogsResponse = getPatrolLogs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.info_outline),
        ),
        title: const Text('Previous Logs'),
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
                      title: Text('Previous Logs'),
                      subtitle: Text('Scroll below to see your past logs'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        TextButton(
                          child: const Text('New Patrol Log'),
                          onPressed: () {
                            ref.read(patrolLogProvider.notifier).reset();
                            context.go('/logTimesPage');
                          },
                        ),
                        TextButton(
                          child: const Text('Start Time'),
                          onPressed: () {},
                        ),
                        // const SizedBox(width: 8),
                        // TextButton(
                        //   child: const Text('LISTEN'),
                        //   onPressed: () {/* ... */},
                        // ),
                        const SizedBox(width: 8),
                      ],
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
