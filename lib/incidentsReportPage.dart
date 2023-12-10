import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shark_valley/services/logProvider.dart';

import 'models/incidentReportLog.dart';

/// This class reports the number of incidents encountered
/// by the volunteers during their patrol.
class IncidentsReportPage extends ConsumerWidget {
  const IncidentsReportPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<IncidentReportLog> incidentReports =
        ref.watch(patrolLogProvider).incidentReports;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.go('/contactWithVisitorPage');
          },
          icon: const Icon(Icons.keyboard_backspace),
        ),
        title: const Text('Incidents Report'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          const Icon(Icons.receipt_long),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          )
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: Column(children: <Widget>[
        SizedBox(
            height: 500, // Constrain height.

            child: Scrollbar(
              child: ListView.separated(
                itemCount: incidentReports.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      leading: CircleAvatar(
                          child: Text(incidentReports[index].createdBy[0])),
                      title: Text(incidentReports[index].type),
                      subtitle: Text(incidentReports[index].description),
                      trailing: IconButton(
                        onPressed: () {
                          ref
                              .watch(patrolLogProvider)
                              .removeIncidentReportAt(index);
                        },
                        icon: const Icon(Icons.close),
                      ));
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(height: 1),
              ),
            )),
        const SizedBox(
          height: 50, // <-- SEE HERE
        ),
        FilledButton(
            onPressed: () {
              context.go('/suppliesExpendedPage');
            },
            child: const Text('Next'))
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        // isExtended: true,
        backgroundColor: Colors.grey,
        onPressed: () {
          context.go('/newIncidentPage');
        },
        // isExtended: true,
        child: const Icon(Icons.add),
      ),
    );
  }
}
