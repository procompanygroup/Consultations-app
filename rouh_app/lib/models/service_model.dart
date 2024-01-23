import 'dart:convert';

import '../controllers/dio_manager_controller.dart';

class AppService {
  //Instance variables
  String? name;
  String? desc;
  String? icon;
  int? is_active;
  String? image;

  DioManager dioManager = DioManager();

  //Constructor
  AppService(
      { name, desc, icon, is_active, image,}) {
    name = name;
    desc = desc;
    icon = icon;
    is_active = is_active;
    image = image;
  }

  factory AppService.fromJson(Map<String, dynamic> parsedJson) {
    return AppService(
        name: parsedJson['name'],
        desc: parsedJson['desc'],
        icon: parsedJson['icon'],
        image: parsedJson['image'],
        is_active: parsedJson['is_active'],
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

  Future<List<AppService>?> allServices() async {

    var response = await dioManager.dio.post('client/service/viewall', );
    if (response.statusCode == 200) {
      Iterable l = json.decode(response.data);
      List<AppService> services = List<AppService>.from(l.map((model)=> AppService.fromJson(model)));

      return services;
    }
    else {
      return throw Exception();
    }

  }
}