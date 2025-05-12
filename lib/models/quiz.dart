import 'package:flutter/material.dart';

class Quiz {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final int questions;
  final int timeLimit; // in minutes

  Quiz({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.questions,
    required this.timeLimit,
  });
}

