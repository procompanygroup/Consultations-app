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

  Expert? expert;
  List<ServiceValue>? serviceValues;

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
    this.serviceValues});

  factory Order.fromJson(dynamic parsedJson) {
    var tmpOrderDate;
    var tmpOrderAdminDate;
    var tmpAnswerSpeed;
    var tmpServiceValues;
    if (parsedJson["order_date"] != null) {
      tmpOrderDate = DateTime.tryParse(parsedJson['order_date']);
    }
    if (parsedJson["order_admin_date"] != null) {
      tmpOrderAdminDate = DateTime.tryParse(parsedJson['order_admin_date']);
    }
    if (parsedJson['answer_speed'] != null) {
      tmpAnswerSpeed = double.tryParse(parsedJson['answer_speed']);
    }
    if(parsedJson['valueservices'] != null) {
      tmpServiceValues = convertListToModel(ServiceValue.fromJson, parsedJson['valueservices']);
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
      return Order.fromJson(json.decode(response.data));

    }
    else {
      return Order();
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