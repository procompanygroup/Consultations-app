import 'dart:convert';
import 'dart:math';

import 'package:rouh_app/models/service_input_model.dart';
import 'package:rouh_app/models/service_value_model.dart';

import '../controllers/dio_manager_controller.dart';

class Service {
  //Instance variables
  int? id;
  String? name;
  String? desc;
  String? icon;
  int? is_active;
  String? image;
  String? message;
  List<ServiceInput>? serviceInputs;

  DioManager dioManager = DioManager();

  //Constructor
  Service(
      {this.id, this.name, this.desc, this.icon, this.is_active, this.image,this.message,this.serviceInputs}) ;

  factory Service.fromJson(dynamic parsedJson) {
    var tmpServiceInputs;
    if(parsedJson["inputservices"] != null)
      {
         tmpServiceInputs = convertListToModel(ServiceInput.fromJson, parsedJson["inputservices"]);
      }
    return Service(
    id: parsedJson['id'],
    name: parsedJson['name'],
    desc: parsedJson['desc'],
    icon: parsedJson['icon'],
    image: parsedJson['image'],
     is_active: parsedJson['is_active'],
    message: parsedJson['message'],
     serviceInputs : tmpServiceInputs,
     );
  }

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'name': name,
        'desc': desc,
        'icon': icon,
        'is_active': is_active,
        'image': image,
      };

  Future<List<Service>> allServices() async {

    var response = await dioManager.dio.post('client/service/viewall', );

    if (response.statusCode == 200) {
      var services = convertListToModel<Service>(Service.fromJson,jsonDecode(response.data));
      return services;
    }
    else {
      return throw Exception();
    }

  }

  Future<Service?> getServiceInputs({
    required int serviceId,
  }) async {

    var data = json.encode({
      "id": serviceId
    });

    var response = await dioManager.dio.post('client/service/getinputform',data: data );
    if (response.statusCode == 200) {
      var service = Service.fromJson(json.decode(response.data));

      return service;
    }
    else {
      return throw Exception();
    }

  }

Future<Service?> saveWithValues({
    required int clientId,
    required int expertId,
    required int serviceId,
  required List<ServiceValue> serviceValues,
  }) async {

     final  inputsValues =List<APIInputValue>.empty(growable: true);
    APIInputValue inputValue ;

  serviceValues.forEach((serviceVal) {
    inputValue = APIInputValue( inputservice_id: serviceVal.inputservice_id,value: serviceVal.value);
    inputsValues.add( inputValue);
      });

var jsonInputs = jsonEncode(inputsValues);
     var data = json.encode({
       "client_id": clientId,
       "expert_id": expertId,
       "service_id": serviceId,
       "valueServices":jsonInputs
     });

    var response = await dioManager.dio.post('client/service/savewithvalues',data: data );
    // print(response.statusCode);
    // print(response.data);
    if (response.statusCode == 200) {
      var service = Service.fromJson(json.decode(response.data));
      //message; no balance
      //or
      // message: id of selected service
      return service;
    }
    else {
      return throw Exception();
    }

  }

// used  for convert a List of value
 static List<T> convertListToModel<T>(
      T Function(Map<String, dynamic> map) fromJson, List data) {
    return data.map((e) => fromJson((e as Map).cast())).toList();
  }
}


class APIInputValue{
  int? inputservice_id;
  String? value;

  //Constructor
  APIInputValue({this.inputservice_id,this.value});

  Map<String, dynamic> toJson() =>
      {
        'inputservice_id': inputservice_id,
        'value': value,
      };


}