part of 'audio_file_cubit.dart';

@immutable
abstract class AudioFileState {
  List<ServiceInput>? get serviceInputs => null;
 List<ServiceValue>? get serviceValues => null;
}


class AudioFileInitial extends AudioFileState {}

class AudioFileLoading extends AudioFileState {
  @override

  late final File audioFile;
  AudioFileLoading(this.audioFile);

  get audio => audioFile;
}
class UserInformationFailure extends AudioFileState {}
