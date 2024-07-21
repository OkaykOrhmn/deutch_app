// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:deutch_app/data/model/books_model.dart';
import 'package:deutch_app/data/repository/books_repository.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'book_state.dart';

class BookCubit extends Cubit<BookState> {
  BookCubit() : super(BookInitial());

  void getBook({required final int bookId}) async {
    emit(BookLoading());
    try {
      BooksModel response = await booksRepository.getBook(bookId);
      emit(BookSuccess(response: response));
    } on DioException {
      emit(BookFail());
    }
  }
}
