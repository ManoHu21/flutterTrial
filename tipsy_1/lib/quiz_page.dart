// quiz_page.dart
import 'package:flutter/material.dart';
import 'correct_answer_page.dart'; // Correct path to correct_answer_page.dart
import 'wrong_answer_page.dart'; // Correct path to wrong_answer_page.dart

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final String correctAnswer = 'Paris'; // Example correct answer

  // Example question and options
  final String quizQuestion = "What's the capital of France?";
  final List<String> quizOptions = ['Paris', 'Berlin', 'Madrid', 'Rome'];

  // Example of others' selections. This should be fetched from your backend or state management
  final List<String> othersSelections = ['Berlin', 'Paris', 'Paris', 'Madrid', 'Berlin', 'Rome'];

  void answerQuestion(String selectedOption) {
    if (selectedOption == correctAnswer) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CorrectAnswerPage()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WrongAnswerPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Displaying others' selections
              Text(
                'Other selection: ' + othersSelections.join(', '),
                style: Theme.of(context).textTheme.subtitle1,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                quizQuestion,
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Column(
                children: quizOptions.map((option) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: ElevatedButton(
                    onPressed: () => answerQuestion(option),
                    child: Text(option),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50), // Makes the button width size to fill its parent
                    ),
                  ),
                )).toList(),
              ),
              SizedBox(height: 20),
              // Reminder or tips section
              Text(
                'Remember: Make your choice wisely!',
                style: Theme.of(context).textTheme.subtitle1,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
