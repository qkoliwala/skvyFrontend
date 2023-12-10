import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shark_valley/models/contactsLog.dart';
import 'package:shark_valley/services/logProvider.dart';

/// This class will implement the number of contancts
/// that a volunteer will have with visitors of the park.
class ContactWithVisitorPage extends ConsumerWidget {
  ContactWithVisitorPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final _numberOfContactsController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ContactsLog contactsLog = ref.watch(patrolLogProvider).contactLog;

    _numberOfContactsController.text =
        (contactsLog.noContacts ?? '0').toString();
    _notesController.text = (contactsLog.comments ?? '').toString();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.go('/weatherPage');
          },
          icon: const Icon(Icons.keyboard_backspace),
        ),
        title: const Text('Contact with visitors'),
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
                    TextFormField(
                        controller: _numberOfContactsController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(
                          labelText: "Total Number of Contacts",
                          hintText: "Total Number of Contacts",
                        )),
                    SizedBox(
                      width: 400,
                      child: TextFormField(
                        controller: _notesController,
                        decoration: const InputDecoration(
                          hintText: 'Notes',
                          labelText: 'Notes',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 40, horizontal: 20),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    FilledButton(
                        onPressed: () {
                          ContactsLog contactLog = ContactsLog();
                          contactLog.noContacts =
                              int.parse(_numberOfContactsController.text);
                          contactLog.comments = _notesController.text;
                          ref
                              .read(patrolLogProvider.notifier)
                              .setContactLog(contactLog);

                          context.go('/incidentsReportPage');
                        },
                        child: const Text('Next'))
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
