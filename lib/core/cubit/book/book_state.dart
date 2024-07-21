part of 'book_cubit.dart';

@immutable
sealed class BookState {}

final class BookInitial extends BookState {}

final class BookLoading extends BookState {}

final class BookSuccess extends BookState {
  final BooksModel response;

  BookSuccess({required this.response});
}

final class BookFail extends BookState {}
