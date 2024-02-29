part of 'service_input_cubit.dart';

@immutable
abstract class ServiceInputState {
  List<ServiceInput>? get serviceInputs => null;
 List<ServiceValue>? get serviceValues => null;

  int? get imageInputServiceId => null;
}


class ServiceInputInitial extends ServiceInputState {}

class ServiceInputLoding extends ServiceInputState {
  @override
  late final  List<ServiceInput>? serviceInputs;
  late final   List<ServiceValue>? serviceValues;
  late final   int? imageInputServiceId;
  ServiceInputLoding(this.serviceInputs,this.serviceValues,this.imageInputServiceId);
  get inputs => serviceInputs;
  get values => serviceValues;
  get inputServiceId => imageInputServiceId;
}
class ServiceInputFailure extends ServiceInputState {}
