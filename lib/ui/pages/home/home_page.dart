// ignore_for_file: library_private_types_in_public_api

import 'package:deutch_app/core/bloc/books/books_bloc.dart';
import 'package:deutch_app/ui/pages/home/books_screen.dart';
import 'package:deutch_app/ui/theme/colors.dart';
import 'package:deutch_app/ui/widgets/loading/primary_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<BooksBloc>().add(GetAllBooks());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: 0,
        sizing: StackFit.expand,
        children: [
          BlocBuilder<BooksBloc, BooksState>(
            builder: (context, state) {
              if (state is BooksSuccess) {
                return BooksScreen(
                  response: state.response,
                );
              } else {
                return PrimaryLoading(
                  size: 18,
                  color: Theme.of(context).black(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
