import 'dart:convert';

import '../controllers/dio_manager_controller.dart';

class Service {
  //Instance variables
  String? name;
  String? desc;
  String? icon;
  int? is_active;
  String? image;

  DioManager dioManager = DioManager();

  //Constructor
  Service(
      { name, desc, icon, is_active, image,}) {
    name = name;
    desc = desc;
    icon = icon;
    is_active = is_active;
    image = image;
  }

  factory Service.fromJson(Map<String, dynamic> parsedJson) {
    return Service(
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
}