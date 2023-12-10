import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shark_valley/models/weatherLog.dart';
import 'package:shark_valley/services/logProvider.dart';

/// This class is the page that takes in the weather information
/// that will be used to report the current information of the
/// weather during the patrol, such as the wind, temperature,
/// humidity, and other notes that need to be highlighted.
class WeatherPage extends ConsumerWidget {
  WeatherPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final _temperatureController = TextEditingController();
  final _windController = TextEditingController();
  final _cloudCoverController = TextEditingController();
  final _humidityController = TextEditingController();
  final _commentsController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WeatherLog weatherLog = ref.watch(patrolLogProvider).weatherLog;
    _temperatureController.text = (weatherLog.temperature ?? '70').toString();
    _windController.text = weatherLog.wind ?? '';
    _cloudCoverController.text = weatherLog.cloudCover ?? '';
    _humidityController.text = (weatherLog.humidity ?? '76').toString();
    _commentsController.text = weatherLog.comments ?? '';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.go('/logTimesPage');
          },
          icon: const Icon(Icons.keyboard_backspace),
        ),
        title: const Text('Weather'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          const Icon(Icons.wb_sunny),
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
                        controller: _temperatureController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(
                            labelText: "Temperature (°F)",
                            hintText: "Fahrenheit Grade",
                            suffixText: "°F")),
                    TextFormField(
                        controller: _windController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: "Wind",
                          hintText: "Wind",
                        )),
                    TextFormField(
                        controller: _cloudCoverController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: "Cloud Cover",
                          hintText: "Cloud Cover",
                        )),
                    TextFormField(
                        controller: _humidityController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                          PercentInputFormatter(),
                        ],
                        decoration: const InputDecoration(
                            labelText: "Humidity",
                            hintText: "Humidity",
                            suffixText: "%")),
                    SizedBox(
                      width: 400,
                      child: TextFormField(
                        controller: _commentsController,
                        decoration: const InputDecoration(
                          hintText: 'Comments',
                          labelText: 'Comments',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 40, horizontal: 20),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    FilledButton(
                        onPressed: () {
                          WeatherLog weatherLog = WeatherLog();
                          weatherLog.temperature =
                              int.parse(_temperatureController.text);
                          weatherLog.wind = _windController.text;
                          weatherLog.cloudCover = _cloudCoverController.text;
                          weatherLog.humidity =
                              int.parse(_humidityController.text);
                          weatherLog.comments = _commentsController.text;

                          if ((weatherLog.wind?.isNotEmpty ?? false) &&
                              (weatherLog.cloudCover?.isNotEmpty ?? false)) {
                            ref
                                .read(patrolLogProvider.notifier)
                                .setWeatherLog(weatherLog);
                            context.go('/contactWithVisitorPage');
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

/// Formating the value to a percent value.
class PercentInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text == '') {
      return const TextEditingValue();
    } else if (int.parse(newValue.text) < 1) {
      return const TextEditingValue().copyWith(text: '0');
    }

    return int.parse(newValue.text) > 100
        ? const TextEditingValue().copyWith(text: '100')
        : newValue;
  }
}
