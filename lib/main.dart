import 'package:deutch_app/core/bloc/audio/audio_bloc.dart';
import 'package:deutch_app/core/bloc/download/bloc/download_bloc.dart';
import 'package:deutch_app/core/routes/route_generator.dart';
import 'package:deutch_app/core/routes/route_paths.dart';
import 'package:deutch_app/ui/theme/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final ValueNotifier<bool> isShowPlayer = ValueNotifier<bool>(false);

bool isDarkTheme =
    SchedulerBinding.instance.platformDispatcher.platformBrightness ==
        Brightness.dark;
void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light));
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<ThemeBloc>(
        create: (context) {
          ThemeBloc themeBloc = ThemeBloc();
          themeBloc.add(InitialThemeSetEvent());
          return themeBloc;
        },
      ),
      BlocProvider<AudioBloc>(
        create: (context) => AudioBloc(),
      ),
      BlocProvider<DownloadBloc>(
        create: (context) => DownloadBloc(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeData>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              useMaterial3: true,
              brightness: state.brightness,
              sliderTheme: SliderThemeData(
                  thumbShape: SliderComponentShape.noThumb, trackHeight: 4)),
          initialRoute: RoutePaths.home,
          onGenerateRoute: (settings) => RouteGenerator.destination(settings),
        );
      },
    );
  }
}
