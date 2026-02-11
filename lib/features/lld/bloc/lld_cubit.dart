import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/topic.dart';
import '../../../data/repositories/lld_repository.dart';

// State
class LldState extends Equatable {
  final List<Topic> topics;
  final bool isLoading;

  const LldState({this.topics = const [], this.isLoading = true});

  LldState copyWith({List<Topic>? topics, bool? isLoading}) {
    return LldState(
      topics: topics ?? this.topics,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [topics, isLoading];
}

// Cubit
class LldCubit extends Cubit<LldState> {
  LldCubit() : super(const LldState());

  void loadTopics() {
    final topics = LldRepository.getTopics();
    emit(state.copyWith(topics: topics, isLoading: false));
  }

  void toggleConcept(String topicId, String conceptId) {
    final updatedTopics = state.topics.map((topic) {
      if (topic.id != topicId) return topic;
      final updatedProblems = topic.problems.map((p) {
        if (p.id != conceptId) return p;
        return p.copyWith(isCompleted: !p.isCompleted);
      }).toList();
      final completed = updatedProblems.where((p) => p.isCompleted).length;
      return topic.copyWith(
        problems: updatedProblems,
        completedProblems: completed,
      );
    }).toList();
    emit(state.copyWith(topics: updatedTopics));
  }
}
