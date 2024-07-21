import 'dart:io';

import 'package:deutch_app/core/bloc/audios/audios_bloc.dart';
import 'package:deutch_app/core/bloc/books/books_bloc.dart';
import 'package:deutch_app/core/bloc/courses/courses_bloc.dart';
import 'package:deutch_app/core/cubit/book/book_cubit.dart';
import 'package:deutch_app/core/cubit/book/sort_cubit.dart';
import 'package:deutch_app/core/routes/route_paths.dart';
import 'package:deutch_app/data/model/courses_args.dart';
import 'package:deutch_app/ui/pages/books/book_page.dart';
import 'package:deutch_app/ui/pages/books/pdf_page.dart';
import 'package:deutch_app/ui/pages/course/course_page.dart';
import 'package:deutch_app/ui/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouteGenerator {
  static Route<dynamic> destination(RouteSettings routeSettings) {
    switch (routeSettings.name.toString()) {
      case RoutePaths.home:
        return _createRoute(MultiBlocProvider(providers: [
          BlocProvider(
            create: (context) => SortCubit(),
          ),
          BlocProvider(create: (context) => BooksBloc()),
        ], child: const HomePage()));
      case RoutePaths.book:
        return _createRoute(MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => BookCubit()),
          ],
          child: BookPage(
            bookId: routeSettings.arguments as int,
          ),
        ));
      case RoutePaths.course:
        CoursesArgs coursesArgs = routeSettings.arguments as CoursesArgs;
        return _createRoute(MultiBlocProvider(
          providers: [
            BlocProvider<CoursesBloc>(create: (context) {
              CoursesBloc coursesBloc = CoursesBloc();
              coursesBloc.add(
                  GetCourse(bookId: coursesArgs.bookId, id: coursesArgs.id));
              return coursesBloc;
            }),
            BlocProvider<AudiosBloc>(create: (context) {
              AudiosBloc coursesBloc = AudiosBloc();
              return coursesBloc;
            })
          ],
          child: CoursePage(
            booksModel: coursesArgs.booksModel,
          ),
        ));
      case RoutePaths.pdf:
        return _createRoute(PdfPage(file: routeSettings.arguments as File));
      default:
        return _createRoute(const SizedBox());
    }
  }

  static Route _createRoute(dynamic page) {
    return MaterialPageRoute(builder: (context) {
      return page;
    });
  }
}
