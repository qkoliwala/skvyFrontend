import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shark_valley/services/logProvider.dart';

/// This class creates a new signature that each member will
/// have to complete, and add it to the other signatures of
/// the current patrol log.
class NewSignaturePage extends ConsumerStatefulWidget {
  const NewSignaturePage({super.key});

  @override
  ConsumerState<NewSignaturePage> createState() => _NewSignaturePageState();
}

class _NewSignaturePageState extends ConsumerState<NewSignaturePage> {
  final _formKey = GlobalKey<FormState>();
  final _signatureController = TextEditingController();

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
            context.go('/signaturesPage');
          },
          icon: const Icon(Icons.keyboard_backspace),
        ),
        title: const Text('New Signature'),
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
                        controller: _signatureController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: "Signature",
                          hintText: "Full Name",
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            context.go('/signaturesPage');
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
                            if (_signatureController.text.isNotEmpty) {
                              String signature = _signatureController.text;
                              ref
                                  .read(patrolLogProvider.notifier)
                                  .addSignature(signature);
                              context.go('/signaturesPage');
                            }
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
