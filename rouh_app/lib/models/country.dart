
import 'dart:convert';
import 'package:flutter/services.dart';

class Country {
  String? code;
  String? name;
  String? dialCode;

  Country.fromJson(Map json)
      : code = json['code'],
        name = json['name'],
        dialCode = json['dialCode'];

  Map toJson() {
    return {'code': code,
      'name': name,
      'dialCode': dialCode};
  }


  // Future<void> readJson() async {
  //   final String response = await rootBundle.loadString('assets/sample.json');
  //   final data = await json.decode(response);
  // }

  // static Future<List<Country>> readJson() async {
  //   final String response = await rootBundle.loadString('assets/data/countries.json');
  //   final data = await json.decode(response);
  //   return data;
  //
  // }
  static Future<List<Country>> readJson() async {

    final String response = await rootBundle.loadString('assets/data/countries.json');
    // //final data = await json.decode(response);
    // // Iterable l = json.decode(response.body);
    // print(response);
    // final data = await json.decode(response);
    // List<Country> posts = List<Country>.from(data.map((model)=> Country.fromJson(model)));
    // return posts;

    // // print(response);
    //  var jsonResponse =await json.decode(response);
    //  // print(jsonResponse);
    // var data = jsonResponse['countries'];
    // print(data);
    // // List<Country> list = data
    // //     .map((countries) => new Country.fromJson(countries))
    // //     .toList();
    // List<Country> list2 = data.map((model) => Country.fromJson(model)).toList();

    var jsonResponse =await json.decode(response); //Map dictionary
    Iterable data = jsonResponse['countries'];
    // print('print:');
    // print(data);
     List<Country> list2 = data.map((model) => Country.fromJson(model)).toList();
    // List<Country> list2 = data.map((model) =>
    // print(model)
    // ).toList();
      //print(list2);
    //List<Country> list1 =<Country>[];
    return  list2;

    // Iterable list = payloadMap['scopes'];
    // print('print:');
    // print(list);
    // return list.map((model) => User.fromJson(model)).toList();
  }
}