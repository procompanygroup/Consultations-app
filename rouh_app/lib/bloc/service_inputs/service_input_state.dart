part of 'service_input_cubit.dart';

@immutable
abstract class ServiceInputState {
  List<ServiceInput>? get serviceInputs => null;
 List<ServiceValue>? get serviceValues => null;
}


class ServiceInputInitial extends ServiceInputState {}

class ServiceInputLoding extends ServiceInputState {
  @override
  late final  List<ServiceInput>? serviceInputs;
  late final   List<ServiceValue>? serviceValues;
  ServiceInputLoding(this.serviceInputs,this.serviceValues);
  get inputs => serviceInputs;
  get values => serviceValues;
}
class ServiceInputFailure extends ServiceInputState {}
