import 'package:flutter/material.dart';

class NormalUserPage extends StatefulWidget {
  const NormalUserPage({super.key});

  @override
  State<NormalUserPage> createState() {
    return _NormalUserPage();
  }
}

class _NormalUserPage extends State<NormalUserPage> {
  String checkInButton = 'Start Timer';
  bool buttonOn = false;

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
              padding: const EdgeInsets.all(2),
              child: ElevatedButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(20),
                  minimumSize: MaterialStateProperty.all(const Size(200, 200)),
                  shape: MaterialStateProperty.all(const CircleBorder()),
                ),
                onPressed: () {
                  setState(
                    () {
                      buttonOn = !buttonOn;
                    },
                  );
                },
                child: Text(
                  buttonOn ? 'Clock Out' : 'Clock In',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
