import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/expert_model.dart';

part 'expert_information_state.dart';

class ExpertInformationCubit extends Cubit<ExpertInformationState> {
  ExpertInformationCubit() : super(UserInformationInitial());

  //DioManager dioManager = DioManager();

  void addProfile(Expert? profileData)  {

    emit(ExpertInformationSuccess(profileData));

  }

  // Future<User?> getUserInformation({required mobile}) {
  //   User infoUser = User();
  //   emit(UserInformationLoading());
  //   var user = infoUser.getUser(mobile: mobile);
  //   if (user == Exception()) {
  //     emit(UserInformationFailure());
  //   } else {
  //     emit(UserInformationSuccess());
  //   }
  //   return user;
  // }
}
