import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/audio_file_model.dart';
import '../../models/service_input_model.dart';
import '../../models/service_value_model.dart';

part 'audio_file_state.dart';

class AudioFileCubit extends Cubit<AudioFileState> {
  AudioFileCubit() : super(AudioFileInitial());


  void loadAudioFile( File? audioFile, int? serviceInputId)  {

    emit(AudioFileLoading(new AudioFile( audioFile:audioFile,serviceInputId: serviceInputId)));

  }
}
