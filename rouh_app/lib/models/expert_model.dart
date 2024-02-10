import 'dart:convert';

import '../controllers/dio_manager_controller.dart';
import 'expert_service_model.dart';
import 'service_model.dart';

class Expert {
  //Instance variables
  int? id;
  String? expert_name;
  String? email;
  String? mobile;
  String? nationality;
  DateTime? birthdate;
  int? gender;
  String? marital_status;
  int? is_active;
  int? points_balance;
  double? cash_balance;
  double? cash_balance_todate;
  double? rates;
  String? record;
  String? desc;
  int? call_cost;
  double? answer_speed;
  String? image;
  bool? isFavorite;
List<ExpertService>? expert_services;
List<Service>? services;

  DioManager dioManager = DioManager();

  //Constructor
  Expert(
      { this.id, this.expert_name, this.email, this.mobile, this.nationality, this.birthdate, this.gender, this.marital_status,
        this.is_active,this.points_balance,this.cash_balance,this.cash_balance_todate,this.rates,this.record,this.desc,
        this.call_cost,this.answer_speed, this.image,this.isFavorite, this.expert_services,this.services});

  factory Expert.fromJson(Map<String, dynamic> parsedJson) {
    var tmpExpertServices;
    var tmpServices;
    if(parsedJson["experts_services"] != null)
    {
      tmpExpertServices = convertListToModel(ExpertService.fromJson, parsedJson["experts_services"]);
    }
    if(parsedJson["services"] != null)
    {
      tmpServices = convertListToModel(Service.fromJson, parsedJson["services"]);
    }
    return Expert(
        id: parsedJson['id'],
        expert_name: parsedJson['user_name'],
        mobile: parsedJson['mobile'],
        birthdate: DateTime.tryParse(parsedJson['birthdate']),
        email: parsedJson['email'],
        gender: parsedJson['gender'],
        image: parsedJson['image'],
        is_active: parsedJson['is_active'],
        marital_status: parsedJson['marital_status'],
        nationality: parsedJson['nationality'],
      call_cost: parsedJson['call_cost'],
      answer_speed: parsedJson['answer_speed'],
      cash_balance:double.tryParse( parsedJson['cash_balance']),
      cash_balance_todate: double.tryParse(parsedJson['cash_balance_todate']),
      desc:  parsedJson['desc'],
      record:  parsedJson['record'],
       points_balance:  parsedJson['points_balance'],
      rates:  double.tryParse(parsedJson['rates']),
      isFavorite:  bool.tryParse(parsedJson['is_favorite']),
      expert_services: tmpExpertServices,
      services: tmpServices,
    );
  }

  Future<List<Expert>> GetByServiceId({
    required int serviceId,
  }) async {
    var data = json.encode({
      "id": serviceId
    });

    var response = await dioManager.dio.post('client/expert/getexpertsbyserviceid',
      data: data,
    );

    List<Expert> experts;
    if (response.statusCode == 200) {
      experts = convertListToModel<Expert>(Expert.fromJson,jsonDecode(response.data));

    }
    else {
      experts = List<Expert>.empty();;
    }
    return experts;
  }



Future<List<Expert>> GetWithFavorite({
    required int clientId,
  }) async {
    var data = json.encode({
      "client_id": clientId
    });

    var response = await dioManager.dio.post('client/expert/getwithfav',
      data: data,
    );

    List<Expert> experts;
    if (response.statusCode == 200) {
      experts = convertListToModel<Expert>(Expert.fromJson,jsonDecode(response.data));

    }
    else {
      experts = List<Expert>.empty();;
    }
    return experts;
  }

  // used  for convert a List of value
  static List<T> convertListToModel<T>(
      T Function(Map<String, dynamic> map) fromJson, List data) {
    return data.map((e) => fromJson((e as Map).cast())).toList();
  }
}