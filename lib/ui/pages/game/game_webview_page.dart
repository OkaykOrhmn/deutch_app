// ignore_for_file: library_private_types_in_public_api

import 'package:deutch_app/ui/theme/text_styles.dart';
import 'package:deutch_app/ui/widgets/loading/primary_loading.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GameWebviewPage extends StatefulWidget {
  final String src;
  const GameWebviewPage({super.key, required this.src});

  @override
  _GameWebviewPageState createState() => _GameWebviewPageState();
}

class _GameWebviewPageState extends State<GameWebviewPage> {
  late final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(
      Uri.parse(widget.src),
    );

  int loadingPercentage = 0;

  @override
  void initState() {
    controller.setNavigationDelegate(NavigationDelegate(
      onPageStarted: (url) {
        setState(() {
          loadingPercentage = 0;
        });
      },
      onProgress: (progress) {
        setState(() {
          loadingPercentage = progress;
        });
      },
      onPageFinished: (url) {
        setState(() {
          loadingPercentage = 100;
        });
      },
// Keeping track of navigation uisng NavigationDelegate
      //     onNavigationRequest: (navigation) {
      //   final host = Uri.parse(navigation.url).host;
      //   if (host.contains('youtube.com')) {
      //     ScaffoldMessenger.of(context).showSnackBar(
      //       SnackBar(
      //         content: Text(
      //           'Blocking navigation to $host',
      //         ),
      //       ),
      //     );
      //     return NavigationDecision.prevent;
      //   }
      //   return NavigationDecision.navigate;
      // }
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await controller.canGoBack()) {
          await controller.goBack();
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Game'),
        ),
        body: loadingPercentage != 100
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const PrimaryLoading(size: 18),
                  Text(
                    "$loadingPercentage%",
                    style: Theme.of(context).textTheme.titleBold,
                  )
                ],
              )
            : WebViewWidget(
                controller: controller,
              ),
      ),
    );
  }
}
