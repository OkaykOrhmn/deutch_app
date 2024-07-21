import 'package:deutch_app/data/model/courses_model.dart';
import 'package:deutch_app/data/repository/courses_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'courses_event.dart';
part 'courses_state.dart';

class CoursesBloc extends Bloc<CoursesEvent, CoursesState> {
  CoursesBloc() : super(CoursesInitial()) {
    on<CoursesEvent>((event, emit) async {
      if (event is GetCourse) {
        emit(CoursesLoading());
        try {
          CoursesModel response =
              await coursesRepository.getCourses(event.bookId, event.id);
          emit(CoursesSuccess(response: response));
          // ignore: deprecated_member_use
        } on DioError {
          emit(CoursesFail());
        }
      }
    });
  }
}
