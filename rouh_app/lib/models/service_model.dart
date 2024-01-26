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
      { this.name, this.desc, this.icon, this.is_active, this.image,}) {
    // name = name;
    // desc = desc;
    // icon = icon;
    // is_active = is_active;
    // image = image;
  }

  factory AppService.fromJson(dynamic parsedJson) {
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
      var services = convertListToModel<AppService>(AppService.fromJson,jsonDecode(response.data));
      return services;
    }
    else {
      return throw Exception();
    }

  }

// used  for convert a List of value
  List<T> convertListToModel<T>(
      T Function(Map<String, dynamic> map) fromJson, List data) {
    return data.map((e) => fromJson((e as Map).cast())).toList();
  }
}