import 'dart:convert';

import '../controllers/dio_manager_controller.dart';
import 'auth_model.dart';

class Point {
  //Instance variables
  int? id;
  int? count;
  double? price;
  int? countbefor;

  DioManager dioManager = DioManager();

  //Constructor
  Point(
      { this.id, this.count, this.price, this.countbefor});

  factory Point.fromJson(Map<String, dynamic> parsedJson) {
    return Point(
        id: parsedJson['id'],
        count: parsedJson['count'],
        price:double.tryParse( parsedJson['price']),
        countbefor: parsedJson['countbefor'],
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'count': count,
        'price': price,
        'countbefor': countbefor,
      };

  Future<List<Point>?> GetAll() async {

    var response = await dioManager.dio.post('client/point/getall',
      data: [],);

    List<Point> points;
    print(response.statusCode);
    if (response.statusCode == 200) {
      points = convertListToModel<Point>(Point.fromJson,jsonDecode(response.data));

    }
    else {
      points = List<Point>.empty();
    }
    return points;
  }

  // used  for convert a List of value
  static List<T> convertListToModel<T>(
      T Function(Map<String, dynamic> map) fromJson, List data) {
    return data.map((e) => fromJson((e as Map).cast())).toList();
  }
}