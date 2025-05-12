import 'package:flutter/material.dart';
import '../models/lesson.dart';
import 'package:flutter_tts/flutter_tts.dart';

class LessonDetailScreen extends StatefulWidget {
  final Lesson lesson;

  const LessonDetailScreen({super.key, required this.lesson});

  @override
  State<LessonDetailScreen> createState() => _LessonDetailScreenState();
}

class _LessonDetailScreenState extends State<LessonDetailScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController();
  final FlutterTts flutterTts = FlutterTts();

  Future<void> _speak(String letter) async {
    await flutterTts.speak(letter);
  }

  // Sample lesson content based on the lesson type
  List<Map<String, dynamic>> _getLessonContent() {
    if (widget.lesson.title.contains('A-F')) {
      return [
        {
          'letter': 'A',
          'image': 'assets/apple.png',
          'word': 'Apple',
          'description': 'A is for Apple',
        },
        {
          'letter': 'B',
          'image': 'assets/ball.png',
          'word': 'Ball',
          'description': 'B is for Ball',
        },
        {
          'letter': 'C',
          'image': 'assets/cat.png',
          'word': 'Cat',
          'description': 'C is for Cat',
        },
        {
          'letter': 'D',
          'image': 'assets/dog.png',
          'word': 'Dog',
          'description': 'D is for Dog',
        },
        {
          'letter': 'E',
          'image': 'assets/elephant.png',
          'word': 'Elephant',
          'description': 'E is for Elephant',
        },
        {
          'letter': 'F',
          'image': 'assets/frog.png',
          'word': 'Frog',
          'description': 'F is for Frog',
        },
      ];
    } else if (widget.lesson.title.contains('Numbers 1-5')) {
      return [
        {
          'number': '1',
          'image': 'assets/apple.png',
          'word': 'One',
          'description': 'This is the number 1',
        },
        {
          'number': '2',
          'image': 'assets/apple.png',
          'word': 'Two',
          'description': 'This is the number 2',
        },
        {
          'number': '3',
          'image': 'assets/apple.png',
          'word': 'Three',
          'description': 'This is the number 3',
        },
        {
          'number': '4',
          'image': 'assets/apple.png',
          'word': 'Four',
          'description': 'This is the number 4',
        },
        {
          'number': '5',
          'image': 'assets/apple.png',
          'word': 'Five',
          'description': 'This is the number 5',
        },
      ];
    } else {
      // Default content for other lessons
      return [
        {
          'title': 'Introduction',
          'image': 'assets/apple.png',
          'description': 'Welcome to ${widget.lesson.title}',
        },
        {
          'title': 'Lesson Content',
          'image': 'assets/apple.png',
          'description': 'This is the main content of the lesson',
        },
        {
          'title': 'Practice',
          'image': 'assets/apple.png',
          'description': 'Let\'s practice what we learned',
        },
        {
          'title': 'Summary',
          'image': 'assets/apple.png',
          'description': 'Great job completing this lesson!',
        },
      ];
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lessonContent = _getLessonContent();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lesson.title),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: _currentPage / (lessonContent.length - 1),
            backgroundColor: Colors.grey.shade200,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            minHeight: 10,
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: lessonContent.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                final content = lessonContent[index];
                return _buildLessonPage(content);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentPage > 0)
                  ElevatedButton.icon(
                    onPressed: () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Previous'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade300,
                      foregroundColor: Colors.black,
                    ),
                  )
                else
                  const SizedBox(width: 100),
                Text(
                  '${_currentPage + 1}/${lessonContent.length}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (_currentPage < lessonContent.length - 1)
                  ElevatedButton.icon(
                    onPressed: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text('Next'),
                  )
                else
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Lesson completed! Great job!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                    icon: const Icon(Icons.check),
                    label: const Text('Complete'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLessonPage(Map<String, dynamic> content) {
    if (content.containsKey('letter')) {
      // Alphabet lesson
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              content['letter'],
              style: const TextStyle(
                fontSize: 120,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 20),
            Image.asset(
              content['image'],
              height: 150,
              width: 150,
            ),
            const SizedBox(height: 20),
            Text(
              content['word'],
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              content['description'],
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                _speak(content['word']);
              },
              icon: const Icon(Icons.volume_up),
              label: const Text('Listen'),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
            ),
          ],
        ),
      );
    } else if (content.containsKey('number')) {
      // Number lesson
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              content['number'],
              style: const TextStyle(
                fontSize: 120,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 20),
            Image.asset(
              content['image'],
              height: 150,
              width: 150,
            ),
            const SizedBox(height: 20),
            Text(
              content['word'],
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              content['description'],
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    _speak(content['number']);
                  },
                  icon: const Icon(Icons.volume_up),
                  label: const Text('Listen'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else {
      // Generic lesson
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              content['title'],
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 30),
            Image.asset(
              content['image'],
              height: 200,
              width: 200,
            ),
            const SizedBox(height: 30),
            Text(
              content['description'],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      );
    }
  }
}
