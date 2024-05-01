import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

//import 'package:rouh_app_experts/models/user_model.dart';

import '../controllers/dio_manager_controller.dart';


class StatisticModel {
  //Instance variables
  double? answerSpeed;
  List<ServiceStatistics>? serviceStatistics;

  DioManager dioManager = DioManager();

  //Constructor
  StatisticModel(
      { this.answerSpeed,
        this.serviceStatistics,
      });
  factory StatisticModel.fromJson(Map<String, dynamic> parsedJson) {
    var tmpAnswerSpeed;
    var tmpserviceStatistics;
    if(parsedJson['answer_speed'] != null) {
      tmpAnswerSpeed = double.tryParse( parsedJson['answer_speed']);
    }
    if(parsedJson['service_statistics'] != null) {
      tmpserviceStatistics = convertListToModel(ServiceStatistics.fromJson, parsedJson['service_statistics']);
    }
    return StatisticModel(
      answerSpeed: tmpAnswerSpeed,
      serviceStatistics:tmpserviceStatistics,
    );
  }

  Future<StatisticModel> GetStatistics({
    required int expertId,
  }) async {
    var data = json.encode({
      "expert_id": expertId
    });

    var response = await dioManager.dio.post('expert/getstatistics',
      data: data,
    );
    if (response.statusCode == 200) {
      return StatisticModel.fromJson(json.decode(response.data));
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

class ServiceStatistics {
int? service_id;
String? name;
String? icon;
double? rate;
String? comment;

//Constructor
  ServiceStatistics(
    { this.service_id,
      this.name,
      this.icon,
      this.rate,
      this.comment,
  });
  factory ServiceStatistics.fromJson(dynamic parsedJson) {
    var rateTmp;
    if(parsedJson['rate'] != null) {
      rateTmp = double.tryParse( parsedJson['rate'].toString());
    }
    return ServiceStatistics(

      service_id: parsedJson['service_id'],
      name: parsedJson['name'],
      icon: parsedJson['icon'],
      rate: rateTmp,
      comment: parsedJson['comment'],
    );
  }
}