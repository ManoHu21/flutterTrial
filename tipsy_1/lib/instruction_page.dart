// instruction_page.dart
import 'package:flutter/material.dart';
import 'quiz_page.dart'; // Make sure to use the correct path to quiz_page.dart

class InstructionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Quiz Instructions',
              style: Theme.of(context).textTheme.headline4,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '1. Read the question carefully.\n'
                '2. Select your answer.\n'
                '3. Confirm your selection.\n'
                '4. View the result and proceed.',
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.left,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuizPage()),
                );
              },
              child: Text('Join the Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
