import 'dart:convert';

import '../controllers/dio_manager_controller.dart';

class ServiceInput {
  //Instance variables
  int? id;
  int? input_id;
  int? service_id;
  Input? input;

  DioManager dioManager = DioManager();

  //Constructor
  ServiceInput({ this.id, this.input_id, this.service_id, this.input, }) {

  }

  static List<ServiceInput> decode(String tasks) {
    var data = (jsonDecode(tasks) as List<dynamic>?);
    if(data != null){
      return (jsonDecode(tasks) as List<dynamic>?)!.map<ServiceInput>((task) {
        return ServiceInput.fromJson(task);
      }).toList();
    } else {
      return <ServiceInput>[];
    }
  }
 factory ServiceInput.fromJson(dynamic parsedJson) {
   return ServiceInput(
      id: parsedJson['id'],
      input_id: parsedJson['input_id'],
      service_id: parsedJson['service_id'],
      input:  Input.fromJson(parsedJson["input"]),
   );
  }

  // used  for convert a List of value
  List<T> convertListToModel<T>(
      T Function(Map<String, dynamic> map) fromJson, List data) {
    return data.map((e) => fromJson((e as Map).cast())).toList();
  }
}

class Input {
  int? id;
  String? name;
  String? type;
  String? tooltipe;
  String? icon;
  int? ispersonal;
  int? imageCount;
  List<InputValues>? inputValues;

  //Constructor
  Input({ this.id, this.name, this.type, this.tooltipe, this.icon,this.ispersonal,this.imageCount,this.inputValues }) {

  }

  factory Input.fromJson(dynamic parsedJson) =>
      Input(id: parsedJson['id'],
        name: parsedJson['name'],
        type: parsedJson['type'],
        tooltipe: parsedJson['tooltipe'] ,
        icon: parsedJson['icon'] ,
        ispersonal: parsedJson['ispersonal'],
          imageCount: parsedJson['image_count'],
        inputValues : convertListToModel(InputValues.fromJson, parsedJson["inputvalues"],)
      );

  // used  for convert a List of value
  static List<T> convertListToModel<T>(
      T Function(Map<String, dynamic> map) fromJson, List data) {
    return data.map((e) => fromJson((e as Map).cast())).toList();
  }
}

class InputValues{
  int? id;
  String? value;
  int? input_id;

  //Constructor
  InputValues({ this.id, this.value, this.input_id, });

  factory InputValues.fromJson(dynamic parsedJson) {
  return InputValues(
    id: parsedJson['id'],
    value: parsedJson['value'],
    input_id: parsedJson['input_id'],
  );
  }
}
