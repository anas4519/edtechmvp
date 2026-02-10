import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/topic.dart';
import '../../../data/repositories/dsa_repository.dart';

// State
class DsaState extends Equatable {
  final List<Topic> steps;
  final bool isLoading;

  const DsaState({this.steps = const [], this.isLoading = true});

  DsaState copyWith({List<Topic>? steps, bool? isLoading}) {
    return DsaState(
      steps: steps ?? this.steps,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [steps, isLoading];
}

// Cubit
class DsaCubit extends Cubit<DsaState> {
  DsaCubit() : super(const DsaState());

  void loadSheetSteps() {
    final steps = DsaRepository.getSheetSteps();
    emit(state.copyWith(steps: steps, isLoading: false));
  }

  void toggleProblem(String topicId, String problemId) {
    final updatedSteps = state.steps.map((topic) {
      if (topic.id == topicId) {
        final updatedProblems = topic.problems.map((problem) {
          if (problem.id == problemId) {
            return problem.copyWith(isCompleted: !problem.isCompleted);
          }
          return problem;
        }).toList();

        final completedCount = updatedProblems
            .where((p) => p.isCompleted)
            .length;
        return topic.copyWith(
          problems: updatedProblems,
          completedProblems: completedCount,
        );
      }
      return topic;
    }).toList();

    emit(state.copyWith(steps: updatedSteps));
  }
}
