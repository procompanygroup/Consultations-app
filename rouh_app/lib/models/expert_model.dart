import 'dart:convert';

import '../controllers/dio_manager_controller.dart';
import 'expert_service_model.dart';
import 'service_model.dart';
import 'comment_model.dart';

class Expert {
  //Instance variables
  int? id;
  String? expert_name;
  String? first_name;
  String? last_name;
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
  List<ExpertComment>? selectedServices;
  DioManager dioManager = DioManager();

  //Constructor
  Expert(
      { this.id, this.expert_name,
        this.first_name,
        this.last_name,
        this.email, this.mobile, this.nationality, this.birthdate, this.gender, this.marital_status,
        this.is_active,this.points_balance,this.cash_balance,this.cash_balance_todate,this.rates,this.record,this.desc,
        this.call_cost,this.answer_speed, this.image,this.isFavorite, this.expert_services,this.services,this.selectedServices});

  factory Expert.fromJson(Map<String, dynamic> parsedJson) {
    var tmpExpertServices;
    var tmpServices;
    var tmpSelectedServices;
    var tmpBirthDate;
    var tmpCashBalance;
    var tmpCashBalanceTodate;
    var tmpRates;
    var tmpAnswerSpeed;
    var tmpFav;
print("dina +$parsedJson['is_favorite']");
    if(parsedJson["experts_services"] != null)
    {
      tmpExpertServices = convertListToModel(ExpertService.fromJson, parsedJson["experts_services"]);
    }
    if(parsedJson["services"] != null)
    {
      tmpServices = convertListToModel(Service.fromJson, parsedJson["services"]);
    }
    if(parsedJson["selectedservices"] != null)
    {
      tmpSelectedServices = convertListToModel(ExpertComment.fromJson, parsedJson["selectedservices"]);
    }
    if(parsedJson["birthdate"] != null)
    {
      tmpBirthDate = DateTime.tryParse(parsedJson['birthdate']);
    }
    if(parsedJson['cash_balance'] != null) {
      tmpCashBalance = double.tryParse( parsedJson['cash_balance']);
    }
    if(parsedJson['cash_balance_todate'] != null) {
      tmpCashBalanceTodate = double.tryParse( parsedJson['cash_balance_todate']);
    }
    if(parsedJson['rates'] != null) {
      tmpRates = double.tryParse( parsedJson['rates']);
    }
    if(parsedJson['answer_speed'] != null) {
      tmpAnswerSpeed = double.tryParse( parsedJson['answer_speed']);
    }
    if(parsedJson['is_favorite'] != null)
      tmpFav = false;
     else if(parsedJson['is_favorite'] != null) {
      tmpFav = parsedJson['is_favorite'] == 0 ? false : true;
      //tmpFav = bool.tryParse( parsedJson['is_favorite'].toString());
    }

    return Expert(
      id: parsedJson['id'],
      expert_name: parsedJson['user_name'],
      first_name: parsedJson['first_name'],
      last_name: parsedJson['last_name'],
      mobile: parsedJson['mobile'],
      birthdate: tmpBirthDate,
      email: parsedJson['email'],
      gender: parsedJson['gender'],
      image: parsedJson['image'],
      is_active: parsedJson['is_active'],
      marital_status: parsedJson['marital_status'],
      nationality: parsedJson['nationality'],
      call_cost: parsedJson['call_cost'],
      answer_speed: tmpAnswerSpeed,
      cash_balance:tmpCashBalance,
      cash_balance_todate: tmpCashBalanceTodate,
      desc:  parsedJson['desc'],
      record:  parsedJson['record'],
      points_balance:  parsedJson['points_balance'],
      rates:  tmpRates,
      isFavorite: tmpFav,
      expert_services: tmpExpertServices,
      services: tmpServices,
      selectedServices: tmpSelectedServices,
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
      experts = List<Expert>.empty();
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
    print(response.statusCode);
    if (response.statusCode == 200) {
      print((response.data));
      experts = convertListToModel<Expert>(Expert.fromJson,jsonDecode(response.data));

    }
    else {
      experts = List<Expert>.empty();;
    }
    return experts;
  }

  Future<bool> SaveFavorite({
    required int clientId,
    required int expertId,
    required bool isFavorite
  }) async {
    var data = json.encode({
      "client_id": clientId,
      "expert_id": expertId,
      "is_favorite": isFavorite,
    });

    var response = await dioManager.dio.post('client/expert/savefav',
      data: data,
    );

    if (response.statusCode == 200) {
      return true;

    }
    else {
      return false;
    }
  }

  Future<Expert> GetExpertWithComments({
    required int expertId,
  }) async {
    var data = json.encode({
      "id": expertId
    });

    var response = await dioManager.dio.post('client/expert/getwithcomments',
      data: data,
    );

    List<Expert> experts;
    if (response.statusCode == 200) {
      return Expert.fromJson(jsonDecode(response.data));

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