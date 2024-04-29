import 'dart:convert';
import 'dart:math';

// import 'package:rouh_app/models/service_input_model.dart';
// import 'package:rouh_app/models/service_value_model.dart';

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
  int? is_callservice;
  // List<ServiceInput>? serviceInputs;

  DioManager dioManager = DioManager();

  //Constructor
  Service(
      {this.id, this.name, this.desc, this.icon, this.is_active, this.image,this.message,this.is_callservice,}) ;

  factory Service.fromJson(dynamic parsedJson) {
    var tmpServiceInputs;

    return Service(
    id: parsedJson['id'],
    name: parsedJson['name'],
    desc: parsedJson['desc'],
    icon: parsedJson['icon'],
    image: parsedJson['image'],
     is_active: parsedJson['is_active'],
    message: parsedJson['message'],
      is_callservice: parsedJson['is_callservice'],
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
        'is_callservice':is_callservice,
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