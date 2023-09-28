import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shark_valley/models/incidentReportLog.dart';
import 'package:shark_valley/services/logProvider.dart';
import 'package:shark_valley/vault.dart';

class NewIncidentPage extends ConsumerStatefulWidget {

  const NewIncidentPage({super.key});

  @override
  ConsumerState<NewIncidentPage> createState() => _NewIncidentPageState();
}

class _NewIncidentPageState extends ConsumerState<NewIncidentPage> {
  final _formKey = GlobalKey<FormState>();
  final _notesController = TextEditingController();
  String _currentSelectedValue ='Medical';

  final _types = [
   "Medical",
    "Enforcement",
    "Other"
  ];

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: const Icon(Icons.group),
          leading: IconButton(
            onPressed: (){
              context.go('/incidentsReportPage');
            },
            icon: const Icon(Icons.keyboard_backspace),
          ),
        title: const Text('New Incident'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions:  [
          const Icon(Icons.post_add),
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
                    FormField<String>(
                      builder: (FormFieldState<String> state) {
                        return InputDecorator(
                          decoration: InputDecoration(
                              hintText: 'Please select expense',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                          isEmpty: _currentSelectedValue == '',
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _currentSelectedValue,
                              isDense: true,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _currentSelectedValue = newValue??'Medical';
                                });

                              },
                              items: _types.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      width: 400,
                      child: TextFormField(
                        controller: _notesController,
                        decoration: const InputDecoration(
                          hintText: 'Description',
                          labelText: 'Description',
                          contentPadding:
                          EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [ElevatedButton.icon(
                        onPressed: (){ context.go('/incidentsReportPage');},
            icon: const Icon( // <-- Icon
              Icons.cancel,
              size: 24.0,
            ),
            label: const Text('Cancel'), // <-- Text
          ) , ElevatedButton.icon(
                        onPressed: (){
                          IncidentReportLog incidentReport =  IncidentReportLog(type: _currentSelectedValue, description: _notesController.text, createdBy: Vault.userName??"-");
                          ref.read(patrolLogProvider.notifier).addIncidentReport(incidentReport);
                          context.go('/incidentsReportPage');},
                        icon: const Icon( // <-- Icon
                          Icons.save,
                          size: 24.0,
                        ),
                        label: const Text('Save'), // <-- Text
                      )],
                    )


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
