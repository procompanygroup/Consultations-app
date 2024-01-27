import 'package:rouh_app/models/service_input_model.dart';

class ServiceValue {
  //Instance variables
  int? id;
  String? value;
  int? selectedservice_id;
  int? inputservice_id;


  //Constructor
  ServiceValue({ this.id, this.value, this.selectedservice_id, this.inputservice_id });

  Future<List<ServiceValue>> generateInputValues({required List<ServiceInput>? serviceInputs}) async {
   List<ServiceValue> serviceValues=[];
    for (var i = 0; i < serviceInputs!.length; i++) {
      serviceValues.add( ServiceValue( inputservice_id:serviceInputs[i].id,selectedservice_id: serviceInputs[i].service_id));
    }
  return serviceValues;
    
    }


}