part of 'audio_file_cubit.dart';

@immutable
abstract class AudioFileState {
 AudioFile? get audioFile => null;
}


class AudioFileInitial extends AudioFileState {}

class AudioFileLoading extends AudioFileState {
  @override

  late final AudioFile? audioFile;
  AudioFileLoading(this.audioFile);

  get audio => audioFile;
}
class AudioFileFailure extends AudioFileState {}
