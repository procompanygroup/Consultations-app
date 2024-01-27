import 'dart:convert';

import 'package:rouh_app/models/service_input_model.dart';

import '../controllers/dio_manager_controller.dart';

class Service {
  //Instance variables
  String? name;
  String? desc;
  String? icon;
  int? is_active;
  String? image;
  List<ServiceInput>? serviceInputs;

  DioManager dioManager = DioManager();

  //Constructor
  Service(
      { this.name, this.desc, this.icon, this.is_active, this.image,this.serviceInputs}) {
    // name = name;
    // desc = desc;
    // icon = icon;
    // is_active = is_active;
    // image = image;
  }

  factory Service.fromJson(dynamic parsedJson) {
    return Service(
    name: parsedJson['name'],
    desc: parsedJson['desc'],
    icon: parsedJson['icon'],
    image: parsedJson['image'],
     is_active: parsedJson['is_active'],
     serviceInputs : convertListToModel(ServiceInput.fromJson, parsedJson["inputservices"]),
     );
  }

  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'desc': desc,
        'icon': icon,
        'is_active': is_active,
        'image': image,
      };

  Future<List<Service>> allServices() async {

    var response = await dioManager.dio.post('client/service/viewall', );
    print(response.data);
    if (response.statusCode == 200) {
      var services = convertListToModel<Service>(Service.fromJson,jsonDecode(response.data));
      return services;
    }
    else {
      return throw Exception();
    }

  }

  Future<Service?> getSrviceInputs({
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