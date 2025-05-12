import 'package:flutter/material.dart';
import '../../models/achievement.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _nameController =
      TextEditingController(text: 'Prabhat');
  final TextEditingController _ageController = TextEditingController(text: '7');
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit),
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
              });
              if (!_isEditing) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Profile updated successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'Profile'),
            Tab(text: 'Progress'),
            Tab(text: 'Achievements'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildProfileTab(),
          _buildProgressTab(),
          _buildAchievementsTab(),
        ],
      ),
    );
  }

  Widget _buildProfileTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Stack(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('prabhat.jpeg'),
              ),
              if (_isEditing)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.purple,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 20),
          _isEditing
              ? TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : Text(
                  _nameController.text,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          const SizedBox(height: 10),
          _isEditing
              ? TextField(
                  controller: _ageController,
                  decoration: const InputDecoration(
                    labelText: 'Age',
                    border: OutlineInputBorder(),
                  ),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                )
              : Text(
                  '${_ageController.text} years old',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),
                ),
          const SizedBox(height: 30),
          const Divider(),
          const SizedBox(height: 20),
          _buildInfoCard('Total Points', '750', Icons.stars, Colors.amber),
          const SizedBox(height: 16),
          _buildInfoCard('Quizzes Completed', '15', Icons.quiz, Colors.orange),
          const SizedBox(height: 16),
          _buildInfoCard('Lessons Completed', '22', Icons.book, Colors.blue),
          const SizedBox(height: 16),
          _buildInfoCard(
              'Achievements', '8/20', Icons.emoji_events, Colors.purple),
        ],
      ),
    );
  }

  Widget _buildProgressTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Learning Progress',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
          const SizedBox(height: 20),
          _buildProgressCard('Alphabets', 0.85, '85%', Colors.blue),
          const SizedBox(height: 16),
          _buildProgressCard('Numbers', 0.7, '70%', Colors.orange),
          const SizedBox(height: 16),
          _buildProgressCard('Shapes', 0.6, '60%', Colors.green),
          const SizedBox(height: 16),
          _buildProgressCard('Colors', 0.9, '90%', Colors.red),
          const SizedBox(height: 30),
          const Text(
            'Recent Activities',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
          const SizedBox(height: 20),
          _buildActivityItem(
            'Completed "Numbers 1-5" lesson',
            '2 hours ago',
            Icons.book,
            Colors.blue,
          ),
          _buildActivityItem(
            'Scored 90% in Alphabet Quiz',
            'Yesterday',
            Icons.quiz,
            Colors.orange,
          ),
          _buildActivityItem(
            'Earned "Number Master" badge',
            '2 days ago',
            Icons.emoji_events,
            Colors.purple,
          ),
          _buildActivityItem(
            'Completed "Colors" lesson',
            '3 days ago',
            Icons.book,
            Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementsTab() {
    final List<Achievement> achievements = [
      Achievement(
        id: '1',
        title: 'First Steps',
        description: 'Complete your first lesson',
        icon: Icons.emoji_events,
        color: Colors.blue,
        isUnlocked: true,
      ),
      Achievement(
        id: '2',
        title: 'Quiz Whiz',
        description: 'Score 100% on any quiz',
        icon: Icons.emoji_events,
        color: Colors.orange,
        isUnlocked: true,
      ),
      Achievement(
        id: '3',
        title: 'Alphabet Master',
        description: 'Complete all alphabet lessons',
        icon: Icons.emoji_events,
        color: Colors.purple,
        isUnlocked: true,
      ),
      Achievement(
        id: '4',
        title: 'Number Genius',
        description: 'Complete all number lessons',
        icon: Icons.emoji_events,
        color: Colors.green,
        isUnlocked: false,
      ),
      Achievement(
        id: '5',
        title: 'Perfect Streak',
        description: 'Complete 5 quizzes with 100% score',
        icon: Icons.emoji_events,
        color: Colors.red,
        isUnlocked: false,
      ),
      Achievement(
        id: '6',
        title: 'Learning Explorer',
        description: 'Complete at least one lesson in each category',
        icon: Icons.emoji_events,
        color: Colors.teal,
        isUnlocked: true,
      ),
      Achievement(
        id: '7',
        title: 'Quiz Champion',
        description: 'Score in the top 3 of the leaderboard',
        icon: Icons.emoji_events,
        color: Colors.amber,
        isUnlocked: true,
      ),
      Achievement(
        id: '8',
        title: 'Dedicated Learner',
        description: 'Complete 20 lessons',
        icon: Icons.emoji_events,
        color: Colors.indigo,
        isUnlocked: false,
      ),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'My Achievements',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'You have unlocked ${achievements.where((a) => a.isUnlocked).length}/${achievements.length} achievements',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.85,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: achievements.length,
            itemBuilder: (context, index) {
              return _buildAchievementCard(achievements[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
      String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.2),
              radius: 25,
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressCard(
      String title, double progress, String percentage, Color color) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  percentage,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 10,
              borderRadius: BorderRadius.circular(5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(
      String title, String time, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.2),
            radius: 20,
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementCard(Achievement achievement) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: achievement.isUnlocked ? Colors.white : Colors.grey.shade200,
        ),
        padding: const EdgeInsets.all(8),
        child: LayoutBuilder(builder: (context, constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: achievement.isUnlocked
                    ? achievement.color.withOpacity(0.2)
                    : Colors.grey.shade300,
                radius: 22,
                child: Icon(
                  achievement.icon,
                  color:
                      achievement.isUnlocked ? achievement.color : Colors.grey,
                  size: 22,
                ),
              ),
              const SizedBox(height: 6),
              SizedBox(
                width: constraints.maxWidth,
                child: Text(
                  achievement.title,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: achievement.isUnlocked ? Colors.black : Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              SizedBox(
                width: constraints.maxWidth,
                height: 28,
                child: Text(
                  achievement.description,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 10,
                    height: 1.2,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: achievement.isUnlocked
                      ? achievement.color.withOpacity(0.2)
                      : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  achievement.isUnlocked ? 'Unlocked' : 'Locked',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: achievement.isUnlocked
                        ? achievement.color
                        : Colors.grey,
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
