// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'dart:io';

import 'package:deutch_app/core/utils/tools.dart';
import 'package:deutch_app/main.dart';
import 'package:deutch_app/ui/theme/colors.dart';
import 'package:deutch_app/ui/theme/design_config.dart';
import 'package:deutch_app/ui/theme/text_styles.dart';
import 'package:deutch_app/ui/widgets/audio/player_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

class PdfPage extends StatefulWidget {
  final File file;
  const PdfPage({super.key, required this.file});

  @override
  State<PdfPage> createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  final ScrollController scrollController = ScrollController();
  int? pages = 1;
  bool isReady = false;
  String errorMessage = '';

  static ValueNotifier<int> currentPage = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Tools.getDownloadedFileName(
            widget.file.path.replaceAll(".pdf", ''))),
      ),
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                PDFView(
                  filePath: widget.file.path,
                  fitEachPage: false,
                  pageSnap: false,
                  enableSwipe: true,
                  swipeHorizontal: false,
                  autoSpacing: true,
                  pageFling: false,
                  onRender: (_pages) {
                    setState(() {
                      if (!isReady) {
                        pages = _pages;
                        isReady = true;
                      }
                    });
                  },
                  onError: (error) {
                    print(error.toString());
                  },
                  onPageError: (page, error) {
                    print('$page: ${error.toString()}');
                  },
                  onViewCreated: (PDFViewController pdfViewController) {
                    _controller.complete(pdfViewController);
                  },
                  onPageChanged: (int? page, int? total) {
                    currentPage.value = page!;
                  },
                ),
                isReady
                    ? AnimatedBuilder(
                        animation: isShowPlayer,
                        builder: (context, child) {
                          return Positioned(
                            right: 0,
                            top: 12,
                            bottom: 12 + (isShowPlayer.value ? 72 : 0),
                            child: AnimatedBuilder(
                              animation: currentPage,
                              builder: (context, child) => FlutterSlider(
                                axis: Axis.vertical,
                                values: [currentPage.value.toDouble()],
                                min: 0,
                                max: pages!.toDouble() + 1,
                                trackBar: FlutterSliderTrackBar(
                                    activeTrackBarHeight: 8,
                                    inactiveTrackBarHeight: 8,
                                    activeTrackBar: BoxDecoration(
                                        color: lightColor.withOpacity(0.5)),
                                    inactiveTrackBar: BoxDecoration(
                                      color: lightColor.withOpacity(0.5),
                                    )),
                                handlerWidth: 18,
                                handlerHeight: 18,
                                tooltip: FlutterSliderTooltip(
                                    direction:
                                        FlutterSliderTooltipDirection.left),
                                handler: FlutterSliderHandler(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black87,
                                        boxShadow: DesignConfig.defaultShadow(
                                            context)),
                                    child: Container()),
                                onDragging: (handlerIndex, lowerValue,
                                    upperValue) async {
                                  final PDFViewController pdfController =
                                      await _controller.future;
                                  final double val = lowerValue;
                                  pdfController.setPage(val.round());
                                  currentPage.value = val.round();
                                },
                              ),
                            ),
                          );
                        })
                    : const SizedBox(),
                AnimatedBuilder(
                  animation: isShowPlayer,
                  builder: (context, child) => Positioned(
                      bottom: 12 + (isShowPlayer.value ? 72 : 0),
                      left: 12,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black87.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: DesignConfig.defaultShadow(context)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 12),
                        child: AnimatedBuilder(
                          animation: currentPage,
                          builder: (context, child) => Text(
                            "${currentPage.value + 1} / $pages",
                            style: Theme.of(context)
                                .textTheme
                                .tiny
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      )),
                )
              ],
            ),
          ),
          errorMessage.isEmpty
              ? !isReady
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container()
              : Center(
                  child: Text(errorMessage),
                )
        ],
      ),
      bottomSheet: const PlayerNavbar(),
    );
  }
}
