import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EntryPage extends StatefulWidget {
  const EntryPage({super.key});

  @override
  State<EntryPage> createState() {
    return _EntryPage();
  }
}

class _EntryPage extends State<EntryPage> {
  int dropValue = 1;

  SnackBar errorMessage(String str) {
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        height: 90,
        decoration: const BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Text(str),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        title: const Text(
          'Shark Valley Patrol Log',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: DropdownMenu(
                width: 250,
                label: const Text('Do you want to be the group leader?'),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                dropdownMenuEntries: const [
                  DropdownMenuEntry(value: 1, label: 'Yes'),
                  DropdownMenuEntry(value: 0, label: 'No'),
                ],
                onSelected: (int? val) {
                  dropValue = val!;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor: MaterialStateProperty.all(Colors.green)),
                onPressed: () {
                  if (dropValue == 1) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        errorMessage('You are the lead patroller'));
                    context.go('/completedFormPage');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        errorMessage('You are not the lead patroller'));
                    context.go('/normalUserPage');
                  }
                },
                child: const Text("Submit!"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
