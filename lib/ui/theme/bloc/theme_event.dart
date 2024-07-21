part of 'theme_bloc.dart';

@immutable
sealed class ThemeEvent {}

class InitialThemeSetEvent extends ThemeEvent {}

class ThemeSwitchEvent extends ThemeEvent {}
