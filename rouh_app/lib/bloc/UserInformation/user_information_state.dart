part of 'user_information_cubit.dart';

@immutable
abstract class UserInformationState {}

class UserInformationInitial extends UserInformationState {}

class UserInformationLoading extends UserInformationState {}

class UserInformationSuccess extends UserInformationState {}

class UserInformationFailure extends UserInformationState {}
