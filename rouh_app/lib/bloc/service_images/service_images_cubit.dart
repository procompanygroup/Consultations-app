import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/service_input_model.dart';
import '../../models/service_value_model.dart';

part 'service_images_state.dart';

class ServiceImagesCubit extends Cubit<ServiceImagesState> {
  ServiceImagesCubit() : super(ServiceImagesInitial());


  void loadServiceImages( File image1,File image2,File image3, File image4)  {

    emit(ServiceImagesLoading(image1,image2,image3,image4));

  }
}
