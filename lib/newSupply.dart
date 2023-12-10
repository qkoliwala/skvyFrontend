import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shark_valley/services/logProvider.dart';
import 'package:shark_valley/vault.dart';

import 'models/supply.dart';

/// This class stores and reports the supplies expended by
/// the volunteers during their patrol, by giving indormation
/// such as the name of the supplies used, such as water
/// bottles, snack products, etc, as well as the number of
/// supplies used for each category.
class NewSupplyPage extends ConsumerStatefulWidget {
  const NewSupplyPage({super.key});

  @override
  ConsumerState<NewSupplyPage> createState() => _NewSupplyPageState();
}

class _NewSupplyPageState extends ConsumerState<NewSupplyPage> {
  final _formKey = GlobalKey<FormState>();
  final _typeController = TextEditingController();
  final _numberController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.go('/suppliesExpendedPage');
          },
          icon: const Icon(Icons.keyboard_backspace),
        ),
        title: const Text('New Supply'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          const Icon(Icons.post_add),
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
                        controller: _typeController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: "Type",
                          hintText: "Type",
                        )),
                    TextFormField(
                        controller: _numberController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: "Number",
                          hintText: "Number",
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            context.go('/suppliesExpendedPage');
                          },
                          icon: const Icon(
                            // <-- Icon
                            Icons.cancel,
                            size: 24.0,
                          ),
                          label: const Text('Cancel'), // <-- Text
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            Supply supply = Supply(
                                type: _typeController.text,
                                number: _numberController.text,
                                createdBy: Vault.userName ?? "-");
                            ref
                                .read(patrolLogProvider.notifier)
                                .addSupply(supply);
                            context.go('/suppliesExpendedPage');
                          },
                          icon: const Icon(
                            // <-- Icon
                            Icons.save,
                            size: 24.0,
                          ),
                          label: const Text('Save'), // <-- Text
                        )
                      ],
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
