import 'dart:convert';
import 'package:dio/dio.dart';

import 'package:rouh_app_experts/models/user_model.dart';

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
  User? client;
  List<ServiceValue>? serviceValues;

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
      this.answerSpeed,
      this.client,
      this.serviceValues});


  factory ExpertOrder.fromJson(Map<String, dynamic> parsedJson) {

    var tmpOrderDate;
    var tmpRateDate;
    var tmpOrderAdminDate;
    var tmpAnswerSpeed;
    var tmpClient;
    var tmpServiceValues;

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
    if(parsedJson['client'] != null) {
      tmpClient = User.fromJson( parsedJson['client']);
    }
    if(parsedJson['valueservices'] != null) {
      tmpServiceValues = convertListToModel(ServiceValue.fromJson, parsedJson['valueservices']);
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
      client: tmpClient,
      serviceValues: tmpServiceValues,
    );
  }

  Future<List<ExpertOrder>> GetOrders({
    required int expertId,
  }) async {
    var data = json.encode({
      "expert_id": expertId
    });

    var response = await dioManager.dio.post('expert/getorders',
      data: data,
    );

    List<ExpertOrder> orders;

    if (response.statusCode == 200) {
      orders = convertListToModel<ExpertOrder>(ExpertOrder.fromJson,jsonDecode(response.data));

    }
    else {
      orders = List<ExpertOrder>.empty();
    }
    return orders;
  }

  Future<ExpertOrder> GetOrderById({
    required int selectedServiceId,
  }) async {
    var data = json.encode({
      "selectedservice_id": selectedServiceId
    });

    var response = await dioManager.dio.post('expert/getorderbyid',
      data: data,
    );

    if (response.statusCode == 200) {
      return ExpertOrder.fromJson(json.decode(response.data));

    }
    else {
      return throw Exception();
    }
  }

  Future<String?> GetWaitAnswer({
    required int selectedServiceId,

  }) async {

    var data = json.encode({
      "selectedservice_id": selectedServiceId
    });

    var response = await dioManager.dio.post('expert/uploadanswer',data: data );
    print(response.statusCode);
    if (response.statusCode == 200) {
     var jsonParsed = json.decode(response.data);

      return jsonParsed["record_path"];
    }
    else {
      return throw Exception();
    }

  }

  Future<int?> UploadAnswer({
    required int selectedServiceId,
    required String audioPath,

  }) async {

    var recordFile = await MultipartFile.fromFile(
      audioPath,
    );
    FormData formData = FormData.fromMap({
      "selectedservice_id" : selectedServiceId,
      'record': recordFile
    });

    var response = await dioManager.dio.post('expert/uploadanswer',data: formData );
    print(response.statusCode);
    if (response.statusCode == 200) {
      return 1;
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