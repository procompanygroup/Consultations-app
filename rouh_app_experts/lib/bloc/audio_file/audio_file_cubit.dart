import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';



part 'audio_file_state.dart';

class AudioFileCubit extends Cubit<AudioFileState> {
  AudioFileCubit() : super(AudioFileInitial());


  void loadAudioFile( File? audioFile)  {

    emit(AudioFileLoading( audioFile));

  }
}
