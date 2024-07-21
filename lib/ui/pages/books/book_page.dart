// ignore_for_file: library_private_types_in_public_api

import 'package:deutch_app/core/bloc/download/bloc/download_bloc.dart';
import 'package:deutch_app/core/cubit/book/book_cubit.dart';
import 'package:deutch_app/core/routes/route_paths.dart';
import 'package:deutch_app/core/services/storage_handler.dart';
import 'package:deutch_app/core/utils/tools.dart';
import 'package:deutch_app/data/api/api_endpoints.dart';
import 'package:deutch_app/data/model/books_model.dart';
import 'package:deutch_app/data/model/btn_model.dart';
import 'package:deutch_app/data/model/courses_args.dart';
import 'package:deutch_app/ui/theme/colors.dart';
import 'package:deutch_app/ui/theme/design_config.dart';
import 'package:deutch_app/ui/theme/text_styles.dart';
import 'package:deutch_app/ui/widgets/audio/player_navbar.dart';
import 'package:deutch_app/ui/widgets/image/primary_network_image.dart';
import 'package:deutch_app/ui/widgets/loading/primary_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookPage extends StatefulWidget {
  final int bookId;
  const BookPage({super.key, required this.bookId});

  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  static ValueNotifier<bool> showDesc = ValueNotifier<bool>(false);
  final ScrollController scrollController = ScrollController();
  final descKey = GlobalKey();
  final headerKey = GlobalKey();

  @override
  void initState() {
    context.read<BookCubit>().getBook(bookId: widget.bookId);

    super.initState();
  }

  List<BtnModel> btns = [
    BtnModel(
        name: 'Kursbuch',
        url:
            '${ApiEndPoints.baseStorageURL}deutch/a11-bucher/Menschen%20A1.1%20Kursbuch.pdf',
        icon: Icons.menu_book_rounded),
    BtnModel(
        name: 'Arbeitsbuch',
        url:
            '${ApiEndPoints.baseStorageURL}deutch/a11-bucher/Menschen%20A1.1%20Arbeitsbuch.pdf',
        icon: CupertinoIcons.book),
    BtnModel(
        name: 'Kursbuch Antwortblatt',
        url:
            '${ApiEndPoints.baseStorageURL}deutch/a11-bucher/Menschen%20A1.1%20Kursbuch%20Antwortblatt.pdf',
        icon: Icons.my_library_books),
    BtnModel(
        name: 'Arbeitsbuc. Antwortblatt',
        url:
            '${ApiEndPoints.baseStorageURL}deutch/a11-bucher/Menschen%20A1.1%20Arbeitsbuch%20Antwortblatt.pdf',
        icon: Icons.my_library_books_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: headerKey,
      body: BlocBuilder<BookCubit, BookState>(
        builder: (context, state) {
          if (state is BookSuccess) {
            final book = state.response;
            return AnnotatedRegion(
              value: Tools.customeStatusBar(
                  context: context,
                  backgroundColor: Color(int.parse(book.color.toString()))),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    header(book, context),
                    const SizedBox(
                      height: 18,
                    ),
                    Text(
                      book.name.toString(),
                      style: Theme.of(context).textTheme.titleBold,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                CupertinoIcons.book_fill,
                                size: 18,
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Text(
                                book.courses!.length.toString(),
                                style: Theme.of(context).textTheme.title,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 2,
                          height: 16,
                          color: Theme.of(context).descriptionColor(),
                        ),
                        Flexible(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                CupertinoIcons.chart_bar_alt_fill,
                                size: 18,
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Text(
                                book.level.toString(),
                                style: Theme.of(context).textTheme.title,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 2,
                          height: 16,
                          color: Theme.of(context).descriptionColor(),
                        ),
                        Flexible(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.language,
                                size: 18,
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Text(
                                "Deutch",
                                style: Theme.of(context).textTheme.title,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      key: descKey,
                      padding: const EdgeInsets.all(24),
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Description",
                              style: Theme.of(context).textTheme.descBold,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            AnimatedBuilder(
                              animation: showDesc,
                              builder: (context, child) => Stack(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        bottom: showDesc.value ? 46 : 0),
                                    constraints: BoxConstraints(
                                        maxHeight: showDesc.value
                                            ? double.infinity
                                            : 132),
                                    child: Text(
                                      state.response.description.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .desc
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .descriptionColor()),
                                    ),
                                  ),
                                  Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: Container(
                                        height: 46,
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor
                                            .withOpacity(0.9),
                                        alignment: Alignment.center,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            if (showDesc.value) {
                                              RenderBox box = headerKey
                                                      .currentContext
                                                      ?.findRenderObject()
                                                  as RenderBox;
                                              Offset position =
                                                  box.localToGlobal(Offset
                                                      .zero); //this is global position

                                              await scrollController.animateTo(
                                                  position.distance,
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.easeIn);
                                            }

                                            showDesc.value = !showDesc.value;
                                          },
                                          child: Text(
                                            showDesc.value ? "less" : "more",
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    BlocConsumer<DownloadBloc, DownloadState>(
                      listener: (context, state) {
                        if (state is DownloadSuccess) {
                          final file = state.file!;
                          Navigator.of(context)
                              .pushNamed(RoutePaths.pdf, arguments: file);
                        } else if (state is DownloadFail) {}
                      },
                      builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Flex(
                            direction: Axis.horizontal,
                            children: List.generate(
                              btns.length,
                              (index) => Flexible(
                                  flex: 1,
                                  child: AspectRatio(
                                    aspectRatio: 1 / 1,
                                    child: InkWell(
                                      onTap: state is DownloadLoading
                                          ? null
                                          : () async {
                                              context.read<DownloadBloc>().add(
                                                      DownloadMedia(
                                                          url: btns[index].url,
                                                          names: [
                                                        book.name.toString(),
                                                        Tools
                                                            .getDownloadedFileName(
                                                                btns[index].url)
                                                      ]));
                                            },
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        margin: const EdgeInsets.all(8),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Color(int.parse(
                                                book.color.toString())),
                                            borderRadius:
                                                DesignConfig.mediumBorderRadius,
                                            boxShadow:
                                                DesignConfig.defaultShadow(
                                                    context)),
                                        child: Stack(
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(btns[index].icon),
                                                Text(
                                                  btns[index].name,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .tiny,
                                                  textAlign: TextAlign.center,
                                                  maxLines: index >= 2 ? 2 : 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                            state is DownloadLoading &&
                                                    DownloadBloc.url ==
                                                        btns[index].url
                                                ? Positioned.fill(
                                                    child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Color(int.parse(
                                                                book.color
                                                                    .toString()))
                                                            .withOpacity(0.8)),
                                                    child: Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        value: state.pr,
                                                      ),
                                                    ),
                                                  ))
                                                : const SizedBox()
                                          ],
                                        ),
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Text(
                          "Audios",
                          style: Theme.of(context).textTheme.descBold,
                        ),
                      ),
                    ),
                    ListView.builder(
                        itemCount: book.courses!.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final course = book.courses![index];
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(RoutePaths.course,
                                  arguments: CoursesArgs(
                                      id: course.id!,
                                      bookId: course.bookId!,
                                      booksModel: book));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: DesignConfig.mediumBorderRadius,
                                color: Color(int.parse(book.color.toString())),
                              ),
                              margin: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 8)
                                  .copyWith(top: index == 0 ? 0 : 8),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 24),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${course.chapter.toString()} ${course.name.toString()}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .title
                                        .copyWith(color: Colors.white),
                                  ),
                                  const Icon(
                                    CupertinoIcons.forward,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                    const SizedBox(
                      height: 72,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return PrimaryLoading(
              size: 18,
              color: Theme.of(context).black(),
            );
          }
        },
      ),
      bottomSheet: const PlayerNavbar(),
    );
  }

  Container header(BooksModel book, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomLeft: DesignConfig.aVeryHighBorderRadius,
              bottomRight: DesignConfig.aVeryHighBorderRadius),
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(int.parse(book.color.toString())),
                Color(int.parse(book.color.toString())).withOpacity(0.6),
                Color(int.parse(book.color.toString())).withOpacity(0.3),
                Color(int.parse(book.color.toString())).withOpacity(0.1),
              ])),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: DesignConfig.defaultShadow(context),
                    color: Colors.white.withOpacity(0.2),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      CupertinoIcons.back,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                PopupMenuButton(
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: DesignConfig.defaultShadow(context),
                      color: Colors.white.withOpacity(0.2),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(
                      Icons.more_vert,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                  onSelected: (value) {
                    if (value == "profile") {
                      // add desired output
                    } else if (value == "settings") {
                      // add desired output
                    } else if (value == "logout") {
                      // add desired output
                    }
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                    const PopupMenuItem(
                      value: "profile",
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Icon(Icons.cabin),
                          ),
                          Text(
                            'Profile',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: "settings",
                      child: Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Icon(Icons.settings)),
                          Text(
                            'Settings',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: "logout",
                      child: Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Icon(Icons.logout)),
                          Text(
                            'Logout',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
              width: MediaQuery.sizeOf(context).width / 2,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: DesignConfig.defaultShadow(context),
                    borderRadius: DesignConfig.highBorderRadius),
                child: PrimaryNetworkImage(src: book.imageUrl.toString()),
              )),
          const SizedBox(
            height: 46,
          ),
        ],
      ),
    );
  }
}
