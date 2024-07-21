part of 'sort_cubit.dart';

sealed class SortState {}

final class SortInitial extends SortState {}

final class SortLoading extends SortState {}

final class SortSuccess extends SortState {
  final List<BooksModel> response;

  SortSuccess({required this.response});
}

final class SortEmpty extends SortState {}
