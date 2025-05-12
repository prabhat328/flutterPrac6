import 'package:flutter/material.dart';
import '../../models/leaderboard_entry.dart';

class LeaderboardTab extends StatelessWidget {
  const LeaderboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample leaderboard data
    final List<LeaderboardEntry> entries = [
      LeaderboardEntry(
        id: '1',
        name: 'Prabhat',
        score: 950,
        quizzesTaken: 12,
        avatarUrl: 'prabhat.jpeg',
      ),
      LeaderboardEntry(
        id: '2',
        name: 'Abhishek',
        score: 920,
        quizzesTaken: 10,
        avatarUrl: 'abhishek.jpeg',
      ),
      LeaderboardEntry(
        id: '3',
        name: 'Deepak',
        score: 880,
        quizzesTaken: 11,
        avatarUrl: 'deepak.jpeg',
      ),
      LeaderboardEntry(
        id: '4',
        name: 'Aditi',
        score: 850,
        quizzesTaken: 9,
        avatarUrl: 'aditi.jpeg',
      ),
      LeaderboardEntry(
        id: '5',
        name: 'Aditya',
        score: 820,
        quizzesTaken: 10,
        avatarUrl: 'aditya.jpeg',
      ),
      LeaderboardEntry(
        id: '6',
        name: 'Aryan',
        score: 790,
        quizzesTaken: 8,
        avatarUrl: 'prabhat.jpeg',
      ),
      LeaderboardEntry(
        id: '7',
        name: 'Kshitija',
        score: 760,
        quizzesTaken: 9,
        avatarUrl: 'prabhat.jpeg',
      ),
      LeaderboardEntry(
        id: '8',
        name: 'Tejas',
        score: 730,
        quizzesTaken: 7,
        avatarUrl: 'prabhat.jpeg',
      ),
      LeaderboardEntry(
        id: '9',
        name: 'Riddhi',
        score: 700,
        quizzesTaken: 8,
        avatarUrl: 'prabhat.jpeg',
      ),
      LeaderboardEntry(
        id: '10',
        name: 'Anjali',
        score: 670,
        quizzesTaken: 7,
        avatarUrl: 'prabhat.jpeg',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          _buildTopThree(entries.take(3).toList()),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Top Players',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: entries.length,
              itemBuilder: (context, index) {
                return _buildLeaderboardItem(entries[index], index + 1);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopThree(List<LeaderboardEntry> topThree) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (topThree.length > 1)
            _buildTopPlayer(topThree[1], 2, Colors.grey.shade400, 80),
          if (topThree.isNotEmpty)
            _buildTopPlayer(topThree[0], 1, Colors.amber, 100),
          if (topThree.length > 2)
            _buildTopPlayer(topThree[2], 3, Colors.brown.shade300, 60),
        ],
      ),
    );
  }

  Widget _buildTopPlayer(
      LeaderboardEntry entry, int position, Color color, double height) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Text(
            '$position',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8),
        CircleAvatar(
          radius: position == 1 ? 35 : 25,
          backgroundImage: AssetImage(entry.avatarUrl),
        ),
        const SizedBox(height: 8),
        Text(
          entry.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: position == 1 ? 18 : 16,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '${entry.score} pts',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLeaderboardItem(LeaderboardEntry entry, int position) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _getPositionColor(position),
                shape: BoxShape.circle,
              ),
              child: Text(
                '$position',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),
            CircleAvatar(
              backgroundImage: AssetImage(entry.avatarUrl),
              radius: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '${entry.quizzesTaken} quizzes completed',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${entry.score} pts',
                style: TextStyle(
                  color: Colors.green.shade800,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getPositionColor(int position) {
    switch (position) {
      case 1:
        return Colors.amber;
      case 2:
        return Colors.grey.shade400;
      case 3:
        return Colors.brown.shade300;
      default:
        return Colors.green;
    }
  }
}
