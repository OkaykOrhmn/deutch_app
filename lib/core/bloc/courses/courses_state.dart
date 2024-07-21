part of 'courses_bloc.dart';

sealed class CoursesState {}

final class CoursesInitial extends CoursesState {}

final class CoursesLoading extends CoursesState {}

final class CoursesSuccess extends CoursesState {
  final CoursesModel response;

  CoursesSuccess({required this.response});
}

final class CoursesFail extends CoursesState {}
