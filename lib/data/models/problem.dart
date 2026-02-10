import 'package:equatable/equatable.dart';

enum Difficulty { easy, medium, hard }

class Problem extends Equatable {
  final String id;
  final String title;
  final Difficulty difficulty;
  final bool isCompleted;
  final String? articleUrl;
  final String? videoUrl;

  const Problem({
    required this.id,
    required this.title,
    required this.difficulty,
    this.isCompleted = false,
    this.articleUrl,
    this.videoUrl,
  });

  Problem copyWith({
    String? id,
    String? title,
    Difficulty? difficulty,
    bool? isCompleted,
    String? articleUrl,
    String? videoUrl,
  }) {
    return Problem(
      id: id ?? this.id,
      title: title ?? this.title,
      difficulty: difficulty ?? this.difficulty,
      isCompleted: isCompleted ?? this.isCompleted,
      articleUrl: articleUrl ?? this.articleUrl,
      videoUrl: videoUrl ?? this.videoUrl,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    difficulty,
    isCompleted,
    articleUrl,
    videoUrl,
  ];
}
