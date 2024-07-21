import 'package:deutch_app/data/model/books_model.dart';

class CoursesArgs {
  final int id;
  final int bookId;
  final BooksModel booksModel;

  CoursesArgs(
      {required this.id, required this.bookId, required this.booksModel});
}
