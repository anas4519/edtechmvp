import 'package:equatable/equatable.dart';

class Course extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final String iconName;
  final int colorValue;
  final double progress;
  final int totalTopics;
  final int completedTopics;

  const Course({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.iconName,
    required this.colorValue,
    this.progress = 0.0,
    this.totalTopics = 0,
    this.completedTopics = 0,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    subtitle,
    iconName,
    colorValue,
    progress,
    totalTopics,
    completedTopics,
  ];
}
