part of 'audios_bloc.dart';

sealed class AudiosState extends Equatable {
  const AudiosState();

  @override
  List<Object> get props => [];
}

final class AudiosInitial extends AudiosState {}

final class AudiosLoading extends AudiosState {}

final class AudiosSuccess extends AudiosState {
  final AudiosModel response;

  const AudiosSuccess({required this.response});
}

final class AudiosFail extends AudiosState {}
