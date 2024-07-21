part of 'books_bloc.dart';

sealed class BooksEvent {}

class GetAllBooks extends BooksEvent {}

class SortBooks extends BooksEvent {
  final String? sort;

  SortBooks({required this.sort});
}
