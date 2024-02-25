import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

//import '../../controllers/dio_manager_controller.dart';
import '../../models/user_model.dart';

part 'user_information_state.dart';

class UserInformationCubit extends Cubit<UserInformationState> {
  UserInformationCubit() : super(UserInformationInitial());

  //DioManager dioManager = DioManager();

  void addProfile(User? profileData)  {

    emit(UserInformationSuccess(profileData));

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
