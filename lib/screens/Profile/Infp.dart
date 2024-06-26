import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  // Quiz-related variables
  int currentQuestionIndex = 0;
  List<Map<String, dynamic>> quizQuestions = [
    {
      'question': 'What is the capital of France?',
      'options': ['Paris', 'Berlin', 'London', 'Madrid'],
      'correctAnswer': 'Paris',
    },
    // Add more questions here...
  ];

  // Function to handle user's answer submission
  void checkAnswer(String selectedAnswer) {
    String correctAnswer = quizQuestions[currentQuestionIndex]['correctAnswer'];
    // Perform logic to check the answer
    // For example, update score, show feedback, etc.
    // You might also navigate to the next question or show results
    // For this example, I'll just move to the next question
    moveToNextQuestion();
  }

  // Function to move to the next question
  void moveToNextQuestion() {
    setState(() {
      if (currentQuestionIndex < quizQuestions.length - 1) {
        currentQuestionIndex++;
      } else {
        // Quiz completed, show results or navigate to a different screen
        // For this example, let's just reset the quiz
        currentQuestionIndex = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
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
            // Display options as buttons
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


