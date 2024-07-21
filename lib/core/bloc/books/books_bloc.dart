import 'package:deutch_app/data/model/books_model.dart';
import 'package:deutch_app/data/repository/books_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'books_event.dart';
part 'books_state.dart';

class BooksBloc extends Bloc<BooksEvent, BooksState> {
  BooksBloc() : super(BooksInitial()) {
    on<BooksEvent>((event, emit) async {
      if (event is GetAllBooks) {
        emit(BooksLoading());
        try {
          List<BooksModel> response = await booksRepository.getAllBooks();
          emit(BooksSuccess(response: response));
          // ignore: deprecated_member_use
        } on DioError {
          emit(BooksFail());
        }
      }
    });
  }
}
