import 'package:flutter/material.dart';
import '../../models/lesson.dart';
import '../lesson_detail_screen.dart';

class LessonsTab extends StatelessWidget {
  const LessonsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learn & Practice'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choose a Category',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 20),
            _buildCategoryCard(
              context,
              'Alphabets',
              'Learn all 26 letters',
              Colors.purple.shade100,
              Icons.text_fields,
              [
                Lesson(id: '1', title: 'A-F Letters', description: 'Learn the first 6 letters', icon: Icons.abc),
                Lesson(id: '2', title: 'G-L Letters', description: 'Learn the next 6 letters', icon: Icons.abc),
                Lesson(id: '3', title: 'M-R Letters', description: 'Learn the middle 6 letters', icon: Icons.abc),
                Lesson(id: '4', title: 'S-Z Letters', description: 'Learn the last 8 letters', icon: Icons.abc),
              ],
            ),
            const SizedBox(height: 16),
            _buildCategoryCard(
              context,
              'Numbers',
              'Learn numbers 1-20',
              Colors.blue.shade100,
              Icons.numbers,
              [
                Lesson(id: '5', title: 'Numbers 1-5', description: 'Learn to count from 1 to 5', icon: Icons.filter_1),
                Lesson(id: '6', title: 'Numbers 6-10', description: 'Learn to count from 6 to 10', icon: Icons.filter_5),
                Lesson(id: '7', title: 'Numbers 11-15', description: 'Learn to count from 11 to 15', icon: Icons.filter_9),
                Lesson(id: '8', title: 'Numbers 16-20', description: 'Learn to count from 16 to 20', icon: Icons.filter_9_plus),
              ],
            ),
            const SizedBox(height: 16),
            _buildCategoryCard(
              context,
              'Shapes',
              'Learn basic shapes',
              Colors.green.shade100,
              Icons.category,
              [
                Lesson(id: '9', title: 'Basic Shapes', description: 'Circle, Square, Triangle', icon: Icons.category),
                Lesson(id: '10', title: 'More Shapes', description: 'Rectangle, Oval, Diamond', icon: Icons.category),
              ],
            ),
            const SizedBox(height: 16),
            _buildCategoryCard(
              context,
              'Colors',
              'Learn primary colors',
              Colors.orange.shade100,
              Icons.color_lens,
              [
                Lesson(id: '11', title: 'Primary Colors', description: 'Red, Blue, Yellow', icon: Icons.color_lens),
                Lesson(id: '12', title: 'Secondary Colors', description: 'Green, Orange, Purple', icon: Icons.color_lens),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(
    BuildContext context,
    String title,
    String subtitle,
    Color color,
    IconData icon,
    List<Lesson> lessons,
  ) {
    return GestureDetector(
      onTap: () {
        _showLessonsBottomSheet(context, title, lessons);
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: color,
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(icon, size: 50, color: Colors.blue.shade800),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.blue),
            ],
          ),
        ),
      ),
    );
  }

  void _showLessonsBottomSheet(BuildContext context, String category, List<Lesson> lessons) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height * 0.7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$category Lessons',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: lessons.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue.shade100,
                          child: Icon(lessons[index].icon, color: Colors.blue),
                        ),
                        title: Text(
                          lessons[index].title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Text(lessons[index].description),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LessonDetailScreen(lesson: lessons[index]),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

