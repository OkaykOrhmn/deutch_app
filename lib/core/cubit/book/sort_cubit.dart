import 'package:deutch_app/data/model/books_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sort_state.dart';

class SortCubit extends Cubit<SortState> {
  SortCubit() : super(SortInitial());

  void sortBooks(
      {required final String? sortBy, required final List<BooksModel> books}) {
    emit(SortLoading());
    final List<BooksModel> response = [];
    if (sortBy == null) {
      emit(SortSuccess(response: books));
      return;
    }
    for (var element in books) {
      if (element.name.toString().contains(sortBy)) {
        response.add(element);
      }
    }
    if (response.isEmpty) {
      emit(SortEmpty());
    } else {
      emit(SortSuccess(response: response));
    }
  }
}
