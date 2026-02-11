import 'package:equatable/equatable.dart';
import 'problem_content.dart';

enum Difficulty { easy, medium, hard }

class Problem extends Equatable {
  final String id;
  final String title;
  final Difficulty difficulty;
  final bool isCompleted;
  final String? articleUrl;
  final String? videoUrl;
  final String? description;
  final List<ProblemExample> examples;
  final List<String> hints;
  final List<String> companyTags;
  final List<PracticeOption> practiceOptions;
  final EditorialContent? editorial;

  const Problem({
    required this.id,
    required this.title,
    required this.difficulty,
    this.isCompleted = false,
    this.articleUrl,
    this.videoUrl,
    this.description,
    this.examples = const [],
    this.hints = const [],
    this.companyTags = const [],
    this.practiceOptions = const [],
    this.editorial,
  });

  Problem copyWith({
    String? id,
    String? title,
    Difficulty? difficulty,
    bool? isCompleted,
    String? articleUrl,
    String? videoUrl,
    String? description,
    List<ProblemExample>? examples,
    List<String>? hints,
    List<String>? companyTags,
    List<PracticeOption>? practiceOptions,
    EditorialContent? editorial,
  }) {
    return Problem(
      id: id ?? this.id,
      title: title ?? this.title,
      difficulty: difficulty ?? this.difficulty,
      isCompleted: isCompleted ?? this.isCompleted,
      articleUrl: articleUrl ?? this.articleUrl,
      videoUrl: videoUrl ?? this.videoUrl,
      description: description ?? this.description,
      examples: examples ?? this.examples,
      hints: hints ?? this.hints,
      companyTags: companyTags ?? this.companyTags,
      practiceOptions: practiceOptions ?? this.practiceOptions,
      editorial: editorial ?? this.editorial,
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
    description,
    examples,
    hints,
    companyTags,
    practiceOptions,
    editorial,
  ];
}
