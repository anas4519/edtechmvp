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
}
