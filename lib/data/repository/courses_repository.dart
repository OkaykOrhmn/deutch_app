import 'package:deutch_app/data/api/api_endpoints.dart';
import 'package:deutch_app/data/api/dio_helper.dart';
import 'package:deutch_app/data/model/courses_model.dart';
import 'package:dio/dio.dart';

final coursesRepository = CoursesRepository(DioHelper());

class CoursesRepository implements Book {
  final DioHelper dioHelper;
  CoursesRepository(this.dioHelper);

  @override
  Future<List<CoursesModel>> getAllCourses(int bookId) async {
    try {
      Response response = await dioHelper.sendRequest.get(
          "${ApiEndPoints.baseURL}${ApiEndPoints.books}/$bookId${ApiEndPoints.courses}");
      final List<dynamic> postMaps = response.data['courses'];
      return postMaps.map((e) => CoursesModel.fromJson(e)).toList();
    } catch (ex) {
      rethrow;
    }
  }

  @override
  Future<CoursesModel> getCourses(int bookId, int id) async {
    try {
      Response response = await dioHelper.sendRequest.get(
          "${ApiEndPoints.baseURL}${ApiEndPoints.books}/$bookId${ApiEndPoints.courses}/$id");
      final postMaps = response.data['course'];
      return CoursesModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }
}

abstract class Book {
  Future<List<CoursesModel>> getAllCourses(int bookId);
  Future<CoursesModel> getCourses(int bookId, int id);
}
