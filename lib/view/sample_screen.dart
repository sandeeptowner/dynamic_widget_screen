import 'package:dynamic_textformfield/fields/aadhar_screen.dart';
import 'package:flutter/material.dart';

class SampleScreen extends StatelessWidget {
  const SampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AadharField(),
                    ));
              },
              child: const Text('Aadhar'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Pan Card'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Voter\'s Id'),
            ),
          ],
        ),
      ),
    );
  }
}
