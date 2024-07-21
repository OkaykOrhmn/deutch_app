part of 'books_bloc.dart';

sealed class BooksState {}

final class BooksInitial extends BooksState {}

final class BooksLoading extends BooksState {}

final class BooksSuccess extends BooksState {
  final List<BooksModel> response;

  BooksSuccess({required this.response});
}

final class BooksFail extends BooksState {}
