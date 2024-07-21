part of 'audio_bloc.dart';

@immutable
sealed class AudioState {}

final class AudioInitial extends AudioState {}

final class AudioLoading extends AudioState {}

final class AudioSuccess extends AudioState {}

final class AudioFail extends AudioState {}

final class AudioStoped extends AudioState {}
