import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shark_valley/models/patrolTimeLog.dart';
import 'package:shark_valley/services/logProvider.dart';

/// This class records the times that the user will approximately
/// enter in the time pages, which then can be reported back in the
/// back end for further analysis and information to the administration
/// staff.
class LogTimesPage extends ConsumerWidget {
  LogTimesPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final _patrolDateController = TextEditingController();
  final _parkArrivalController = TextEditingController();
  final _startedPatrolController = TextEditingController();
  final _selectedCompletedPatrolController = TextEditingController();
  final _selectedLeftPatrolController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PatrolTimeLog patrolTimeLog = ref.watch(patrolLogProvider).patrolTime;

    DateTime? selectedPatrolDate = patrolTimeLog.patrolDate ?? DateTime.now();
    _patrolDateController.text = selectedPatrolDate != null
        ? DateFormat("yyyy-MM-dd").format(selectedPatrolDate!)
        : '';

    TimeOfDay? selectedArrivalTime = patrolTimeLog.arrivalTime;
    _parkArrivalController.text = selectedArrivalTime?.format(context) ?? '';

    TimeOfDay? selectedStartedPatrol = patrolTimeLog.startedPatrol;
    _startedPatrolController.text =
        selectedStartedPatrol?.format(context) ?? '';

    TimeOfDay? selectedCompletedPatrol = patrolTimeLog.completedPatrol;
    _selectedCompletedPatrolController.text =
        selectedCompletedPatrol?.format(context) ?? '';

    TimeOfDay? selectedLeftPatrol =
        patrolTimeLog.leftPatrol ?? TimeOfDay.fromDateTime(DateTime.now());
    _selectedLeftPatrolController.text =
        selectedLeftPatrol?.format(context) ?? '';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // back arrow icon left side topBar
          onPressed: () {
            context.go('/completedFormPage');
          },
        ),
        title: const Text('Shark Valley Patrol Log'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          const Icon(Icons.access_time),
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
                    TextField(
                      keyboardType: TextInputType.none,
                      textInputAction: TextInputAction.next,
                      controller: _patrolDateController,
                      decoration: InputDecoration(
                          hintText: 'Date of patrol',
                          labelText: 'Patrol Date',
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.calendar_month),
                            onPressed: () async {
                              selectedPatrolDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                lastDate: DateTime.now(),
                                firstDate: DateTime(DateTime.now().year),
                              );

                              _patrolDateController.text =
                                  selectedPatrolDate != null
                                      ? DateFormat("yyyy-MM-dd")
                                          .format(selectedPatrolDate!)
                                      : '';
                            },
                          )),
                    ),
                    TextField(
                      keyboardType: TextInputType.none,
                      textInputAction: TextInputAction.next,
                      controller: _parkArrivalController,
                      decoration: InputDecoration(
                          hintText: 'Park Arrival Time',
                          labelText: 'Park Arrival',
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.schedule),
                            onPressed: () async {
                              selectedArrivalTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (context.mounted) {
                                _parkArrivalController.text =
                                    selectedArrivalTime?.format(context) ?? '';
                              }
                            },
                          )),
                    ),
                    TextField(
                      keyboardType: TextInputType.none,
                      textInputAction: TextInputAction.next,
                      controller: _startedPatrolController,
                      decoration: InputDecoration(
                          hintText: 'Started Patrol Time',
                          labelText: 'Started Patrol',
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.schedule),
                            onPressed: () async {
                              selectedStartedPatrol = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (context.mounted) {
                                _startedPatrolController.text =
                                    selectedStartedPatrol?.format(context) ??
                                        '';
                              }
                            },
                          )),
                    ),
                    TextField(
                      keyboardType: TextInputType.none,
                      textInputAction: TextInputAction.next,
                      controller: _selectedCompletedPatrolController,
                      decoration: InputDecoration(
                          hintText: 'Completed Patrol Time',
                          labelText: 'Completed Patrol',
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.schedule),
                            onPressed: () async {
                              selectedCompletedPatrol = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (context.mounted) {
                                _selectedCompletedPatrolController.text =
                                    selectedCompletedPatrol?.format(context) ??
                                        '';
                              }
                            },
                          )),
                    ),
                    TextField(
                      keyboardType: TextInputType.none,
                      textInputAction: TextInputAction.next,
                      controller: _selectedLeftPatrolController,
                      decoration: InputDecoration(
                          hintText: 'Left Patrol Time',
                          labelText: 'Left Patrol',
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.schedule),
                            onPressed: () async {
                              selectedLeftPatrol = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (context.mounted) {
                                _selectedLeftPatrolController.text =
                                    selectedLeftPatrol?.format(context) ?? '';
                              }
                            },
                          )),
                    ),
                    FilledButton(
                        onPressed: () {
                          PatrolTimeLog patrolTimeLog = PatrolTimeLog();
                          patrolTimeLog.patrolDate = selectedPatrolDate;
                          patrolTimeLog.arrivalTime = selectedArrivalTime;
                          patrolTimeLog.startedPatrol = selectedStartedPatrol;
                          patrolTimeLog.completedPatrol =
                              selectedCompletedPatrol;
                          patrolTimeLog.leftPatrol = selectedLeftPatrol;

                          if (patrolTimeLog.patrolDate != null &&
                              patrolTimeLog.arrivalTime != null &&
                              patrolTimeLog.startedPatrol != null &&
                              patrolTimeLog.completedPatrol != null &&
                              patrolTimeLog.leftPatrol != null) {
                            ref
                                .read(patrolLogProvider.notifier)
                                .setPatrolTimeLog(patrolTimeLog);
                            context.go('/weatherPage');
                          } else {
                            var snackbar = SnackBar(
                              content: const Text(
                                  'At least one of the fields is missing'),
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
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                },
                              ),
                            );

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackbar);
                          }
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
