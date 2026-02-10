import 'package:equatable/equatable.dart';
import 'problem.dart';

class Topic extends Equatable {
  final String id;
  final String title;
  final String? description;
  final List<Problem> problems;
  final int totalProblems;
  final int completedProblems;

  const Topic({
    required this.id,
    required this.title,
    this.description,
    this.problems = const [],
    this.totalProblems = 0,
    this.completedProblems = 0,
  });

  double get progress =>
      totalProblems > 0 ? completedProblems / totalProblems : 0.0;

  Topic copyWith({
    String? id,
    String? title,
    String? description,
    List<Problem>? problems,
    int? totalProblems,
    int? completedProblems,
  }) {
    return Topic(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      problems: problems ?? this.problems,
      totalProblems: totalProblems ?? this.totalProblems,
      completedProblems: completedProblems ?? this.completedProblems,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    problems,
    totalProblems,
    completedProblems,
  ];
}
