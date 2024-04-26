import 'dart:convert';

import 'package:rouh_app/models/expert_model.dart';

import '../controllers/dio_manager_controller.dart';

class Order {
  //Instance variables
  int? selectedServiceId;
  int? expert_id;
  int? service_id;
  int? client_id;
  int? rate;

  //String? comment;
  String? comment_state;
  String? orderNum;
  String? formState;
  DateTime? orderDate;
  DateTime? orderAdminDate;
  double? answerSpeed;
  String? answerState;
  String? comment;
  DateTime? comment_date;
  DateTime? rate_date;

  Expert? expert;
  List<ServiceValue>? serviceValues;
  List<AnswerModel>? answers;
  DioManager dioManager = DioManager();
  //Constructor
  Order({ this.selectedServiceId,
    this.expert_id,
    this.service_id,
    this.client_id,
    this.rate,
    this.comment_state,
    this.orderNum,
    this.formState,
    this.orderDate,
    this.orderAdminDate,
    this.answerSpeed,
    this.answerState,
    this.expert,
    this.serviceValues,
    this.comment,
    this.comment_date,
    this.rate_date,
    this.answers,
  });

  factory Order.fromJson(dynamic parsedJson) {
    // print('parsedJson' + parsedJson );

    print('start fromJson');

    var tmpOrderDate;
    var tmpOrderAdminDate;
    var tmpAnswerSpeed;
    var tmpServiceValues;
    var tmpcommentDate;
    var tmprateDate;
    var tmpAnswers;
    print('start fromJson 2');
    print(parsedJson['order_date'].toString());
    print('start fromJson 3');
    if (parsedJson['order_date'] != null) {
      tmpOrderDate = DateTime.tryParse(parsedJson['order_date']);
    }
    print('start fromJson 4');

    if (parsedJson['order_admin_date'] != null) {
      tmpOrderAdminDate = DateTime.tryParse(parsedJson['order_admin_date']);
    }
    if (parsedJson['answer_speed'] != null) {
      tmpAnswerSpeed = double.tryParse(parsedJson['answer_speed']);
    }
    if(parsedJson['valueservices'] != null) {
      tmpServiceValues = convertListToModel(ServiceValue.fromJson, parsedJson['valueservices']);
    }
    if (parsedJson['comment_date'] != null) {
      tmpcommentDate = DateTime.tryParse(parsedJson['comment_date']);
    }
    if (parsedJson['rate_date'] != null) {
      tmprateDate = DateTime.tryParse(parsedJson['rate_date']);
    }
    if(parsedJson['answers'] != null) {
      tmpAnswers = convertListToModel(AnswerModel.fromJson, parsedJson['answers']);
    }

    return Order(
      selectedServiceId: parsedJson['id'],
      expert_id: parsedJson['expert_id'],
      service_id: parsedJson['service_id'],
      client_id: parsedJson['client_id'],
      rate: parsedJson['rate'],
      comment_state: parsedJson['comment_state'],
      orderNum: parsedJson['order_num'],
      formState: parsedJson['form_state'],
      orderDate: tmpOrderDate,
      orderAdminDate: tmpOrderAdminDate,
      answerSpeed: tmpAnswerSpeed,
      answerState: parsedJson['answer_state'],
      expert: Expert.fromJson(parsedJson['expert']),
      serviceValues: tmpServiceValues,

      comment: parsedJson['comment'],
      comment_date: tmpcommentDate,
      rate_date:  tmprateDate ,
      answers: tmpAnswers,


    );
  }

  static List<T> convertListToModel<T>(
      T Function(Map<String, dynamic> map) fromJson, List data) {
    return data.map((e) => fromJson((e as Map).cast())).toList();
  }

  Future<Order> GetOrderWithAnswer({
    required int selectedServiceId,
  }) async {
    var data = json.encode({
      "selectedservice_id": selectedServiceId
    });

    var response = await dioManager.dio.post('client/expert/getorderwithanswer',
      data: data,
    );

    if (response.statusCode == 200) {
      print('parsedJson' + response.data.toString() );
      // print(json.decode(response.data['order_date'].toString()));

      // var services = convertListToModel<Service>(Service.fromJson,jsonDecode(response.data));
      // return Order.fromJson(json.decode(response.data));

      var order = convertListToModel<Order>(Order.fromJson,jsonDecode(response.data));
      return order.first;
    }
    else {
      return Order();
    }
  }

  Future<bool> AddComment({
    required int selectedServiceId,
    required String comment
  }) async {
    var data = json.encode({
      "selectedservice_id": selectedServiceId,
      "comment": comment,
    });
    var response = await dioManager.dio.post('client/addcomment',
      data: data,
    );

    if (response.statusCode == 200) {
      return true;

    }
    else {
      return false;
    }
  }

  Future<bool> AddRate({
    required int selectedServiceId,
    required  int rate
  }) async {
    var data = json.encode({
      "selectedservice_id": selectedServiceId,
      "rate": rate,
    });
    var response = await dioManager.dio.post('client/addrate',
      data: data,
    );

    if (response.statusCode == 200) {
      return true;

    }
    else {
      return false;
    }
  }

}

class ServiceValue {
  int? id;
  int? selectedServiceId;
  int? inputServiceId;
  String? name;
  String? type;
  String? tooltipe;
  bool? isPersonal;
  int? imageCount;
  String? svgPath;
  String? value;
  String? icon;

//Constructor
  ServiceValue(
      { this.id,
        this.selectedServiceId,
        this.inputServiceId,
        this.name,
        this.type,
        this.tooltipe,
        this.isPersonal,
        this.imageCount,
        this.svgPath,
        this.value,
        this.icon,
      });

  factory ServiceValue.fromJson(dynamic parsedJson) {

    var tmpIsPersonal;
    if (parsedJson['ispersonal'] == null)
      tmpIsPersonal = false;
    else
      tmpIsPersonal = parsedJson['ispersonal'] == 0 ? false : true;

    return ServiceValue(
      id: parsedJson['id'],
      selectedServiceId: parsedJson['selectedservice_id'],
      inputServiceId: parsedJson['inputservice_id'],
      isPersonal: tmpIsPersonal,
      tooltipe: parsedJson['tooltipe'],
      type: parsedJson['type'],
      name: parsedJson['name'],
      value: parsedJson['value_convert'],
      imageCount: parsedJson['image_count'],
      svgPath: parsedJson['svg_path'],
      icon: parsedJson['icon'],
    );
  }
}
  class AnswerModel {
  int? id;
  String? answer_state;
  int? selectedservice_id;
  DateTime? answer_admin_date;
  String? record_path;

//Constructor
  AnswerModel(
  { this.id,
  this.answer_state,
  this.selectedservice_id,
  this.answer_admin_date,
  this.record_path,
  });
  factory AnswerModel.fromJson(dynamic parsedJson) {
  var tmpAnswerAdminDate;
  if (parsedJson["answer_admin_date"] != null) {
  tmpAnswerAdminDate = DateTime.tryParse(parsedJson['answer_admin_date']);
  }
  return AnswerModel(
  id: parsedJson['id'],
  answer_state: parsedJson['answer_state'],
  selectedservice_id: parsedJson['selectedservice_id'],
  answer_admin_date:tmpAnswerAdminDate,
  record_path: parsedJson['record_path'],
  );
  }
  }