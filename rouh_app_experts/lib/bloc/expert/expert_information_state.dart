part of 'expert_information_cubit.dart';

@immutable
abstract class ExpertInformationState {
  Expert? get fetchedExpert => null;
}

class UserInformationInitial extends ExpertInformationState {}

class UserInformationLoading extends ExpertInformationState {}

class ExpertInformationSuccess extends ExpertInformationState {
  @override
  late final Expert? fetchedExpert;
  ExpertInformationSuccess(this.fetchedExpert);
  get person => fetchedExpert;
}
class ExpertInformationFailure extends ExpertInformationState {}
