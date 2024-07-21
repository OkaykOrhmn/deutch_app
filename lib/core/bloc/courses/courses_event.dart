part of 'courses_bloc.dart';

sealed class CoursesEvent {}

class GetCourse extends CoursesEvent {
  final int bookId;
  final int id;

  GetCourse({required this.bookId, required this.id});
}
