import 'package:flutter/material.dart';
import '../../models/quiz.dart';
import '../quiz_detail_screen.dart';

class QuizTab extends StatelessWidget {
  const QuizTab({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Quiz> quizzes = [
      Quiz(
        id: '1',
        title: 'Alphabet Quiz',
        description: 'Test your knowledge of letters',
        icon: Icons.text_fields,
        color: Colors.purple.shade100,
        questions: 10,
        timeLimit: 5,
      ),
      Quiz(
        id: '2',
        title: 'Number Quiz',
        description: 'Test your counting skills',
        icon: Icons.numbers,
        color: Colors.blue.shade100,
        questions: 10,
        timeLimit: 5,
      ),
      Quiz(
        id: '3',
        title: 'Shapes Quiz',
        description: 'Identify different shapes',
        icon: Icons.category,
        color: Colors.green.shade100,
        questions: 8,
        timeLimit: 4,
      ),
      Quiz(
        id: '4',
        title: 'Colors Quiz',
        description: 'Recognize different colors',
        icon: Icons.color_lens,
        color: Colors.orange.shade100,
        questions: 8,
        timeLimit: 4,
      ),
      Quiz(
        id: '5',
        title: 'Mixed Quiz',
        description: 'Test all your knowledge',
        icon: Icons.quiz,
        color: Colors.red.shade100,
        questions: 15,
        timeLimit: 8,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Test Your Knowledge',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Select a quiz to start playing',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: quizzes.length,
              itemBuilder: (context, index) {
                return _buildQuizCard(context, quizzes[index]);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuizCard(BuildContext context, Quiz quiz) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QuizDetailScreen(quiz: quiz),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: quiz.color,
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                child: Icon(quiz.icon, size: 30, color: Colors.orange),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      quiz.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      quiz.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.help_outline, size: 16, color: Colors.grey.shade700),
                        const SizedBox(width: 4),
                        Text(
                          '${quiz.questions} questions',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Icon(Icons.timer_outlined, size: 16, color: Colors.grey.shade700),
                        const SizedBox(width: 4),
                        Text(
                          '${quiz.timeLimit} min',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Start',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

