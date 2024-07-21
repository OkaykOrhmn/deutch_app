import 'package:deutch_app/data/api/api_endpoints.dart';
import 'package:deutch_app/data/api/dio_helper.dart';
import 'package:deutch_app/data/model/books_model.dart';
import 'package:dio/dio.dart';

final booksRepository = BooksRepository(DioHelper());

class BooksRepository implements Book {
  final DioHelper dioHelper;
  BooksRepository(this.dioHelper);

  @override
  Future<List<BooksModel>> getAllBooks() async {
    try {
      Response response = await dioHelper.sendRequest
          .get(ApiEndPoints.baseURL + ApiEndPoints.books);
      final List<dynamic> postMaps = response.data['books'];
      return postMaps.map((e) => BooksModel.fromJson(e)).toList();
    } catch (ex) {
      rethrow;
    }
  }

  @override
  Future<BooksModel> getBook(int id) async {
    try {
      Response response = await dioHelper.sendRequest
          .get('${ApiEndPoints.baseURL}${ApiEndPoints.books}/$id');
      final postMaps = response.data['book'];
      return BooksModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }
}

abstract class Book {
  Future<List<BooksModel>> getAllBooks();
  Future<BooksModel> getBook(int id);
}
