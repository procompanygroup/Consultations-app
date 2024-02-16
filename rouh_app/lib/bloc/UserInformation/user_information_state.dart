part of 'user_information_cubit.dart';

@immutable
abstract class UserInformationState {
  User? get fetchedPerson => null;
}

class UserInformationInitial extends UserInformationState {}

class UserInformationLoading extends UserInformationState {}

class UserInformationSuccess extends UserInformationState {
  @override
  late final User fetchedPerson;
  UserInformationSuccess(this.fetchedPerson);
  get person => fetchedPerson;
}
class UserInformationFailure extends UserInformationState {}
