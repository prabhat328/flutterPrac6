import 'package:flutter/material.dart';
import '../models/quiz.dart';
import '../models/quiz_question.dart';
import 'dart:async';

class QuizDetailScreen extends StatefulWidget {
  final Quiz quiz;

  const QuizDetailScreen({super.key, required this.quiz});

  @override
  State<QuizDetailScreen> createState() => _QuizDetailScreenState();
}

class _QuizDetailScreenState extends State<QuizDetailScreen> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _quizCompleted = false;
  bool _answerSelected = false;
  String? _selectedAnswer;
  late List<QuizQuestion> _questions;
  late Timer _timer;
  int _timeRemaining = 0;

  @override
  void initState() {
    super.initState();
    _questions = _getQuizQuestions();
    _timeRemaining = widget.quiz.timeLimit * 60; // Convert minutes to seconds
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeRemaining > 0) {
        setState(() {
          _timeRemaining--;
        });
      } else {
        _timer.cancel();
        _endQuiz();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  List<QuizQuestion> _getQuizQuestions() {
    if (widget.quiz.title.contains('Alphabet')) {
      return [
        QuizQuestion(
          id: '1',
          question: 'Which letter comes after A?',
          options: ['B', 'C', 'D', 'E'],
          correctAnswer: 'B',
          imageUrl: 'assets/ques_1.png',
        ),
        QuizQuestion(
          id: '2',
          question: 'Which letter makes the "mmm" sound?',
          options: ['N', 'M', 'W', 'P'],
          correctAnswer: 'M',
          imageUrl: 'assets/ques_2.png',
        ),
        QuizQuestion(
          id: '3',
          question: 'What letter does "Apple" start with?',
          options: ['B', 'A', 'P', 'O'],
          correctAnswer: 'A',
          imageUrl: 'assets/ques_3.png',
        ),
        QuizQuestion(
          id: '4',
          question: 'Which letter is a vowel?',
          options: ['T', 'D', 'E', 'R'],
          correctAnswer: 'E',
          imageUrl: 'assets/ques_4.png',
        ),
        QuizQuestion(
          id: '5',
          question: 'What letter does "Zoo" start with?',
          options: ['X', 'Y', 'Z', 'W'],
          correctAnswer: 'Z',
          imageUrl: 'assets/ques_5.png',
        ),
      ];
    } else if (widget.quiz.title.contains('Number')) {
      return [
        QuizQuestion(
          id: '1',
          question: 'What number comes after 3?',
          options: ['2', '4', '5', '6'],
          correctAnswer: '4',
          imageUrl: 'assets/ques_1.png',
        ),
        QuizQuestion(
          id: '2',
          question: 'How many fingers are on one hand?',
          options: ['4', '5', '6', '10'],
          correctAnswer: '5',
          imageUrl: 'assets/ques_2.png',
        ),
        QuizQuestion(
          id: '3',
          question: 'What is 2 + 2?',
          options: ['3', '4', '5', '6'],
          correctAnswer: '4',
          imageUrl: 'assets/ques_3.png',
        ),
        QuizQuestion(
          id: '4',
          question: 'Which number is greater: 7 or 9?',
          options: ['7', '9', 'They are equal', 'None'],
          correctAnswer: '9',
          imageUrl: 'assets/ques_4.png',
        ),
        QuizQuestion(
          id: '5',
          question: 'What is 5 - 2?',
          options: ['2', '3', '4', '7'],
          correctAnswer: '3',
          imageUrl: 'assets/ques_5.png',
        ),
      ];
    } else {
      // Default questions
      return [
        QuizQuestion(
          id: '1',
          question: 'Sample Question 1',
          options: ['Option A', 'Option B', 'Option C', 'Option D'],
          correctAnswer: 'Option A',
          imageUrl: 'assets/ques_1.png',
        ),
        QuizQuestion(
          id: '2',
          question: 'Sample Question 2',
          options: ['Option A', 'Option B', 'Option C', 'Option D'],
          correctAnswer: 'Option B',
          imageUrl: 'assets/ques_2.png',
        ),
        QuizQuestion(
          id: '3',
          question: 'Sample Question 3',
          options: ['Option A', 'Option B', 'Option C', 'Option D'],
          correctAnswer: 'Option C',
          imageUrl: 'assets/ques_3.png',
        ),
        QuizQuestion(
          id: '4',
          question: 'Sample Question 4',
          options: ['Option A', 'Option B', 'Option C', 'Option D'],
          correctAnswer: 'Option D',
          imageUrl: 'assets/ques_4.png',
        ),
        QuizQuestion(
          id: '5',
          question: 'Sample Question 5',
          options: ['Option A', 'Option B', 'Option C', 'Option D'],
          correctAnswer: 'Option A',
          imageUrl: 'assets/ques_5.png',
        ),
      ];
    }
  }

  void _checkAnswer(String answer) {
    if (_answerSelected) return;

    setState(() {
      _answerSelected = true;
      _selectedAnswer = answer;
    });

    final isCorrect = answer == _questions[_currentQuestionIndex].correctAnswer;

    if (isCorrect) {
      setState(() {
        _score++;
      });
    }

    // Wait before moving to next question
    Future.delayed(const Duration(seconds: 1), () {
      if (_currentQuestionIndex < _questions.length - 1) {
        setState(() {
          _currentQuestionIndex++;
          _answerSelected = false;
          _selectedAnswer = null;
        });
      } else {
        _endQuiz();
      }
    });
  }

  void _endQuiz() {
    _timer.cancel();
    setState(() {
      _quizCompleted = true;
    });
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.quiz.title),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: _quizCompleted ? _buildResultScreen() : _buildQuizScreen(),
    );
  }

  Widget _buildQuizScreen() {
    final currentQuestion = _questions[_currentQuestionIndex];

    return Column(
      children: [
        // Timer and progress bar
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.orange.shade50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Question ${_currentQuestionIndex + 1}/${_questions.length}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.timer, color: Colors.orange),
                  const SizedBox(width: 4),
                  Text(
                    _formatTime(_timeRemaining),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        LinearProgressIndicator(
          value: (_currentQuestionIndex + 1) / _questions.length,
          backgroundColor: Colors.grey.shade200,
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
          minHeight: 10,
        ),

        // Question content
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                if (currentQuestion.imageUrl != null)
                  Image.asset(
                    currentQuestion.imageUrl!,
                    height: 150,
                    width: 150,
                  ),
                const SizedBox(height: 30),
                Text(
                  currentQuestion.question,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                ...currentQuestion.options.map((option) {
                  final isSelected = _selectedAnswer == option;
                  final isCorrect = option == currentQuestion.correctAnswer;

                  Color backgroundColor = Colors.white;
                  Color borderColor = Colors.grey.shade300;

                  if (_answerSelected) {
                    if (isSelected && isCorrect) {
                      backgroundColor = Colors.green.shade100;
                      borderColor = Colors.green;
                    } else if (isSelected && !isCorrect) {
                      backgroundColor = Colors.red.shade100;
                      borderColor = Colors.red;
                    } else if (isCorrect) {
                      backgroundColor = Colors.green.shade100;
                      borderColor = Colors.green;
                    }
                  } else if (isSelected) {
                    backgroundColor = Colors.orange.shade100;
                    borderColor = Colors.orange;
                  }

                  return GestureDetector(
                    onTap: () => _answerSelected ? null : _checkAnswer(option),
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        border: Border.all(color: borderColor, width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        option,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResultScreen() {
    final percentage = (_score / _questions.length) * 100;
    final isPassed = percentage >= 70;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          Icon(
            isPassed ? Icons.emoji_events : Icons.sentiment_satisfied_alt,
            size: 100,
            color: isPassed ? Colors.amber : Colors.orange,
          ),
          const SizedBox(height: 20),
          Text(
            isPassed ? 'Great Job!' : 'Good Try!',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: isPassed ? Colors.green : Colors.orange,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Your Score',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '$_score/${_questions.length}',
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
          Text(
            '${percentage.toStringAsFixed(0)}%',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.home),
            label: const Text('Back to Quizzes'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
          ),
          const SizedBox(height: 20),
          TextButton.icon(
            onPressed: () {
              setState(() {
                _currentQuestionIndex = 0;
                _score = 0;
                _quizCompleted = false;
                _answerSelected = false;
                _selectedAnswer = null;
                _timeRemaining = widget.quiz.timeLimit * 60;
              });
              _startTimer();
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Try Again'),
          ),
        ],
      ),
    );
  }
}
