// correct_answer_page.dart
import 'package:flutter/material.dart';
import 'instruction_page.dart'; // Correct path to instruction_page.dart

class CorrectAnswerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You are correct!',
              style: Theme.of(context).textTheme.headline4,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => InstructionPage()),
                  (Route<dynamic> route) => false,
                );
              },
              child: Text('Back to Instruction'),
            ),
          ],
        ),
      ),
    );
  }
}
