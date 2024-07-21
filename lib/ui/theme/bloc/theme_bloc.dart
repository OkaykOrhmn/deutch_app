import 'package:deutch_app/ui/theme/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_event.dart';

part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeData> {
  ThemeBloc() : super(ThemeData(brightness: Brightness.light)) {
    on<ThemeEvent>((event, emit) async {
      if (event is InitialThemeSetEvent) {
        final bool hasDarkTheme = await isDark();

        if (hasDarkTheme) {
          emit(ThemeData(brightness: Brightness.dark));
        } else {
          emit(ThemeData(brightness: Brightness.light));
        }
      }

      if (event is ThemeSwitchEvent) {
        final dark = await isDark();
        if (dark) {
          emit(ThemeData(brightness: Brightness.light));
        } else {
          emit(ThemeData(brightness: Brightness.dark));
        }
        await setTheme(state.brightness == Brightness.dark);
      }
    });
  }
}
