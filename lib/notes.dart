
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shark_valley/dtos/patrolTimeRequest.dto.dart';
import 'package:shark_valley/services/logProvider.dart';
import 'package:shark_valley/services/patrolLog.service.dart';

class NotesPage extends ConsumerWidget {

 NotesPage({super.key});


  final _formKey = GlobalKey<FormState>();
  final _notesController = TextEditingController();



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String comments = ref.watch(patrolLogProvider).comments??'';
    _notesController.text = comments;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            context.go('/wildLifePage');
          },
          icon: const Icon(Icons.keyboard_backspace),
        ),
        title: const Text('Notes'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions:  [
          const Icon(Icons.group),
          IconButton(
            onPressed: (){},
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
                    SizedBox(
                      width: 400,
                      child: TextFormField(
                        controller: _notesController,
                        decoration: const InputDecoration(
                          hintText: 'Notes',
                          labelText: 'Notes',
                          contentPadding:
                          EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),

                    FilledButton(onPressed: (){
                      String comments =_notesController.text;
                      ref.read(patrolLogProvider.notifier).setComments(comments);



                      context.go('/signaturesPage');}, child: const Text('Next'))

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


