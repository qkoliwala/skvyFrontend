import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shark_valley/services/logProvider.dart';
import 'models/supply.dart';

/// Creates a list with all the different supplies that have been
/// expended, and sends them to the database.
class SuppliesExpendedPage extends ConsumerWidget {
  const SuppliesExpendedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Supply> supplies = ref.watch(patrolLogProvider).supplies;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.go('/incidentsReportPage');
          },
          icon: const Icon(Icons.keyboard_backspace),
        ),
        title: const Text('Supplies Expended'),
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
                itemCount: supplies.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      leading: CircleAvatar(
                          child: Text(supplies[index].createdBy[0])),
                      title: Text(supplies[index].type),
                      subtitle: Text(supplies[index].number),
                      trailing: IconButton(
                        onPressed: () {
                          ref.watch(patrolLogProvider).removeSupplyAt(index);
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
              context.go('/wildLifePage');
            },
            child: const Text('Next'))
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        // isExtended: true,
        backgroundColor: Colors.grey,
        onPressed: () {
          context.go('/newSupplyPage');
        },
        // isExtended: true,
        child: const Icon(Icons.add),
      ),
    );
  }
}
