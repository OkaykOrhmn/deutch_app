// ignore_for_file: library_private_types_in_public_api

import 'package:deutch_app/core/bloc/audio/audio_bloc.dart';
import 'package:deutch_app/core/cubit/book/sort_cubit.dart';
import 'package:deutch_app/core/routes/route_paths.dart';
import 'package:deutch_app/core/utils/tools.dart';
import 'package:deutch_app/data/model/books_model.dart';
import 'package:deutch_app/ui/theme/bloc/theme_bloc.dart';
import 'package:deutch_app/ui/theme/colors.dart';
import 'package:deutch_app/ui/theme/design_config.dart';
import 'package:deutch_app/ui/theme/text_styles.dart';
import 'package:deutch_app/ui/widgets/audio/player_component.dart';
import 'package:deutch_app/ui/widgets/image/primary_network_image.dart';
import 'package:deutch_app/ui/widgets/loading/primary_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_button/group_button.dart';

class BooksScreen extends StatefulWidget {
  final List<BooksModel> response;
  const BooksScreen({super.key, required this.response});

  @override
  _BooksScreenState createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  final controller = GroupButtonController();

  final btns = ["A1", "A2", "B1", "B2", "C"];

  @override
  Widget build(BuildContext context) {
    final response = widget.response;
    return SafeArea(
      child: AnnotatedRegion(
        value: Tools.customeStatusBar(context: context),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              homeAppBar(context),
              BlocBuilder<AudioBloc, AudioState>(
                builder: (context, state) {
                  return const PlayerComponent();
                },
              ),
              sortButtonGroups(context, response),
              booksList(response),
              const SizedBox(
                height: 72,
              )
            ],
          ),
        ),
      ),
    );
  }

  BlocBuilder<SortCubit, SortState> booksList(List<BooksModel> response) {
    return BlocBuilder<SortCubit, SortState>(
      builder: (context, state) {
        if (state is SortEmpty) {
          return const Center(
            child: Text('EMPTY'),
          );
        } else if (state is SortLoading) {
          return PrimaryLoading(
            size: 18,
            color: Theme.of(context).black(),
          );
        } else {
          List<BooksModel> books = response;
          if (state is SortSuccess) {
            books = state.response;
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GridView.count(
              scrollDirection: Axis.vertical,
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 9 / 14,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: List.generate(books.length, (index) {
                return bookCard(books, index);
              }),
            ),
          );
        }
      },
    );
  }

  SingleChildScrollView sortButtonGroups(
      BuildContext context, List<BooksModel> response) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 24, 8, 24),
        child: GroupButton(
          controller: controller,
          options: GroupButtonOptions(
            borderRadius: DesignConfig.highBorderRadius,
            alignment: Alignment.center,
            buttonHeight: 32,
            crossGroupAlignment: CrossGroupAlignment.center,
            direction: Axis.horizontal,
            groupingType: GroupingType.row,
            runSpacing: 4,
            selectedColor: primaryColor,
            unselectedShadow: DesignConfig.defaultShadow(context),
            selectedTextStyle:
                Theme.of(context).textTheme.title.copyWith(color: Colors.white),
            unselectedColor: Theme.of(context).scaffoldBackgroundColor,
            unselectedTextStyle:
                Theme.of(context).textTheme.title.copyWith(color: primaryColor),
            textAlign: TextAlign.center,
            textPadding: const EdgeInsets.symmetric(horizontal: 16),
          ),
          isRadio: true,
          enableDeselect: true,
          onSelected: (_, index, isSelected) {
            context.read<SortCubit>().sortBooks(
                sortBy: isSelected ? btns[index] : null, books: response);
          },
          buttons: btns,
        ),
      ),
    );
  }

  Padding homeAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Books",
            style: Theme.of(context).textTheme.headerBold,
          ),
          BlocBuilder<ThemeBloc, ThemeData>(
            builder: (context, state) {
              return InkWell(
                  onTap: () {
                    context.read<ThemeBloc>().add(ThemeSwitchEvent());
                  },
                  child: state.brightness == Brightness.dark
                      ? const Icon(Icons.light_mode_rounded)
                      : const Icon(Icons.dark_mode_rounded));
            },
          ),
        ],
      ),
    );
  }

  Widget bookCard(List<BooksModel> response, int index) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(RoutePaths.book, arguments: response[index].id!);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(int.parse(response[index].color.toString()))
              .withOpacity(0.1),
          borderRadius: DesignConfig.highBorderRadius,
        ),
        padding: const EdgeInsets.all(4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: PrimaryNetworkImage(
                src: response[index].imageUrl.toString(),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(response[index].name.toString()),
          ],
        ),
      ),
    );
  }
}
