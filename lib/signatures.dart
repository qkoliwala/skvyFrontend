import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shark_valley/services/logProvider.dart';
import 'package:shark_valley/services/patrolLog.service.dart';
import 'dtos/patrolTimeRequest.dto.dart';

/// This class stores and receives all the signitures for the users
/// who have participated in the patrol log.
class SignaturesPage extends ConsumerWidget {
  const SignaturesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> signatures = ref.watch(patrolLogProvider).signatures;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.go('/notesPage');
          },
          icon: const Icon(Icons.keyboard_backspace),
        ),
        title: const Text('Signatures'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          const Icon(Icons.draw),
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
                itemCount: signatures.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      leading: CircleAvatar(child: Text(signatures[index][0])),
                      title: Text(signatures[index]),
                      subtitle: const Text("Signed"),
                      trailing: IconButton(
                        onPressed: () {
                          ref.watch(patrolLogProvider).removeSignatureAt(index);
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
              if (signatures.isNotEmpty) {
                PatrolTimeRequest pt = PatrolTimeRequest();
                pt.patrolTime = ref.watch(patrolLogProvider).patrolTime;
                pt.weatherLog = ref.watch(patrolLogProvider).weatherLog;
                pt.contactLog = ref.watch(patrolLogProvider).contactLog;
                pt.comments = ref.watch(patrolLogProvider).comments;
                pt.incidentReports =
                    ref.watch(patrolLogProvider).incidentReports;
                pt.wildlifeSights = ref.watch(patrolLogProvider).wildlifeSights;
                pt.supplies = ref.watch(patrolLogProvider).supplies;
                pt.signatures = ref.watch(patrolLogProvider).signatures;
                savePatrolLog(pt);

                context.go('/logConfirmation');
              } else {
                var snackbar = SnackBar(
                  content: const Text('At least one signature is required'),
                  elevation: 16,
                  backgroundColor: Colors.blueGrey,
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'Dismiss',
                    onPressed: () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    },
                  ),
                );

                ScaffoldMessenger.of(context).showSnackBar(snackbar);
              }
            },
            child: const Text('Submit Log'))
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        // isExtended: true,
        backgroundColor: Colors.grey,
        onPressed: () {
          context.go('/newSignaturePage');
        },
        // isExtended: true,
        child: const Icon(Icons.add),
      ),
    );
  }
}
