import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/service_input_model.dart';
import '../../models/service_value_model.dart';
import '../../models/user_model.dart';

part 'service_input_state.dart';

class ServiceInputCubit extends Cubit<ServiceInputState> {
  ServiceInputCubit() : super(ServiceInputInitial());

  //DioManager dioManager = DioManager();

  void loadServiceValues( List<ServiceInput> serviceInputs,List<ServiceValue> serviceValues)  {

    emit(ServiceInputLoding(serviceInputs,serviceValues));

  }
}
