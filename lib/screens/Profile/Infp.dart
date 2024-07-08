import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  List<Map<String, dynamic>> quizQuestions = [
    {
      'question': 'What is the capital of France?',
      'options': ['Paris', 'Berlin', 'London', 'Madrid'],
      'correctAnswer': 'Paris',
    },
  ];

  // Function to handle user's answer submission
  void checkAnswer(String selectedAnswer) {
    String correctAnswer = quizQuestions[currentQuestionIndex]['correctAnswer'];

    moveToNextQuestion();
  }

  // Function to move to the next question
  void moveToNextQuestion() {
    setState(() {
      if (currentQuestionIndex < quizQuestions.length - 1) {
        currentQuestionIndex++;
      } else {
        currentQuestionIndex = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              quizQuestions[currentQuestionIndex]['question'],
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            ...((quizQuestions[currentQuestionIndex]['options'] as List<String>).map((option) {
              return ElevatedButton(
                onPressed: () {
                  checkAnswer(option);
                },
                child: Text(option),
              );
            })),
          ],
        ),
      ),
    );
  }
}


