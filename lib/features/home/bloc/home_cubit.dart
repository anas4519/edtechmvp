import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/course.dart';
import '../../../data/repositories/dsa_repository.dart';
import '../../../data/repositories/lld_repository.dart';

// State
class HomeState extends Equatable {
  final List<Course> featuredCourses;
  final List<Course> dsaCourses;
  final List<Course> designCourses;
  final bool isLoading;

  const HomeState({
    this.featuredCourses = const [],
    this.dsaCourses = const [],
    this.designCourses = const [],
    this.isLoading = true,
  });

  HomeState copyWith({
    List<Course>? featuredCourses,
    List<Course>? dsaCourses,
    List<Course>? designCourses,
    bool? isLoading,
  }) {
    return HomeState(
      featuredCourses: featuredCourses ?? this.featuredCourses,
      dsaCourses: dsaCourses ?? this.dsaCourses,
      designCourses: designCourses ?? this.designCourses,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
    featuredCourses,
    dsaCourses,
    designCourses,
    isLoading,
  ];
}

// Cubit
class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  void loadHome() {
    final dsaCourse = DsaRepository.getCourse();
    final lldCourse = LldRepository.getCourse();

    final allPremiumCourse = const Course(
      id: 'all_premium',
      title: 'All Premium',
      subtitle: 'Premium Access to All Courses',
      iconName: 'star',
      colorValue: 0xFF0F9D8E,
      progress: 0.0,
      totalTopics: 500,
      completedTopics: 0,
    );

    final sqlCourse = const Course(
      id: 'sql',
      title: 'SQL + Data Engineering',
      subtitle: 'Learn SQL + DE Foundations Basics to Advanced',
      iconName: 'storage',
      colorValue: 0xFF3B82F6,
      progress: 0.0,
      totalTopics: 80,
      completedTopics: 0,
    );

    final oopsCourse = const Course(
      id: 'oops',
      title: 'OOPs',
      subtitle: 'Learn Object Oriented Programming',
      iconName: 'category',
      colorValue: 0xFFA855F7,
      progress: 0.0,
      totalTopics: 30,
      completedTopics: 0,
    );

    emit(
      state.copyWith(
        featuredCourses: [dsaCourse, lldCourse, allPremiumCourse],
        dsaCourses: [dsaCourse, allPremiumCourse],
        designCourses: [sqlCourse, oopsCourse, lldCourse],
        isLoading: false,
      ),
    );
  }
}
