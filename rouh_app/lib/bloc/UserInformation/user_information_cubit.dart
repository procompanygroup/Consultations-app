import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../controllers/dio_manager_controller.dart';
import '../../models/user_model.dart';

part 'user_information_state.dart';

class UserInformationCubit extends Cubit<UserInformationState> {
  UserInformationCubit() : super(UserInformationInitial());
  DioManager dioManager = DioManager();
  Future<User?> getUser({
    required String mobile,
  }) async {
    var data = json.encode({"mobile": mobile});

    var response = await dioManager.dio.post(
      'client/getbymobile',
      data: data,
    );
    print(response.statusMessage);
    emit(UserInformationLoading());
    if (response.statusCode == 200) {
      emit(UserInformationSuccess());
      // return User.fromJson(json.decode(response.data));
      return User.fromJson(response.data);
    } else {
      emit(UserInformationFailure());
      return throw Exception();
    }
  }
}
