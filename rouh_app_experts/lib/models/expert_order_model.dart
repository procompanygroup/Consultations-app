import 'dart:convert';

import '../controllers/dio_manager_controller.dart';

class ExpertOrder {
  //Instance variables
  int? selectedServiceId;
  int? clientId;
  int? expertId;
  int? serviceId;
  int? rate;
  String? orderNum;
  String? formState;
  DateTime? orderDate;
  DateTime? orderAdminDate;
  DateTime? rateDate;
  double? answerSpeed;
  String? title;
  String? answerState;


  DioManager dioManager = DioManager();

  //Constructor
  ExpertOrder(
      { this.selectedServiceId,
        this.serviceId,
        this.expertId,
        this.clientId,
        this.answerState,
        this.formState,
        this.orderAdminDate,
        this.orderDate,
        this.orderNum,
        this.rate,
        this.rateDate,
        this.title,
      this.answerSpeed});


  factory ExpertOrder.fromJson(Map<String, dynamic> parsedJson) {
    // var tmpExpertServices;
    // var tmpServices;
    // var tmpSelectedServices;
    var tmpOrderDate;
    var tmpRateDate;
    var tmpOrderAdminDate;
    var tmpCashBalanceTodate;
    var tmpRates;
    var tmpAnswerSpeed;

    // if(parsedJson["experts_services"] != null)
    // {
    //   tmpExpertServices = convertListToModel(ExpertService.fromJson, parsedJson["experts_services"]);
    // }
    // if(parsedJson["services"] != null)
    // {
    //   tmpServices = convertListToModel(Service.fromJson, parsedJson["services"]);
    // }
    // if(parsedJson["selectedservices"] != null)
    // {
    //   tmpSelectedServices = convertListToModel(ExpertComment.fromJson, parsedJson["selectedservices"]);
    // }
    if(parsedJson["order_date"] != null)
    {
      tmpOrderDate = DateTime.tryParse(parsedJson['order_date']);
    }
    if(parsedJson["rate_date"] != null)
    {
      tmpRateDate = DateTime.tryParse(parsedJson['rate_date']);
    }
    if(parsedJson["order_admin_date"] != null)
    {
      tmpOrderAdminDate = DateTime.tryParse(parsedJson['order_admin_date']);
    }
    if(parsedJson['answer_speed'] != null) {
      tmpAnswerSpeed = double.tryParse( parsedJson['answer_speed']);
    }


    return ExpertOrder(
      selectedServiceId: parsedJson['id'],
      clientId: parsedJson['client_id'],
      expertId: parsedJson['expert_id'],
      serviceId: parsedJson['service_id'],
      rate: parsedJson['rate'],
      orderNum: parsedJson['order_num'],
      orderDate: tmpOrderDate,
      formState: parsedJson['form_state'],
      orderAdminDate: tmpOrderAdminDate,
      rateDate: tmpRateDate,
      answerSpeed: tmpAnswerSpeed,
      title: parsedJson['title'],
      answerState: parsedJson['answer_state'],
    );
  }
}