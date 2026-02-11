import 'package:equatable/equatable.dart';

class ProblemExample extends Equatable {
  final String input;
  final String output;
  final String? explanation;

  const ProblemExample({
    required this.input,
    required this.output,
    this.explanation,
  });

  @override
  List<Object?> get props => [input, output, explanation];
}

class Approach extends Equatable {
  final String name;
  final String intuition;
  final String code;
  final String timeComplexity;
  final String spaceComplexity;

  const Approach({
    required this.name,
    required this.intuition,
    required this.code,
    required this.timeComplexity,
    required this.spaceComplexity,
  });

  @override
  List<Object?> get props => [
    name,
    intuition,
    code,
    timeComplexity,
    spaceComplexity,
  ];
}

class EditorialContent extends Equatable {
  final String? videoUrl;
  final List<Approach> approaches;

  const EditorialContent({this.videoUrl, this.approaches = const []});

  @override
  List<Object?> get props => [videoUrl, approaches];
}

class PracticeOption extends Equatable {
  final String label;
  final bool isCorrect;

  const PracticeOption({required this.label, this.isCorrect = false});

  @override
  List<Object?> get props => [label, isCorrect];
}
