import 'dart:convert';

import '../controllers/dio_manager_controller.dart';
import 'auth_model.dart';

class NotificationModel {
  //Instance variables

  int? id;
  int? notificationId;
  String? title;
  String? body;
  String? type;
  String?  side;
  int? selectedServiceId;
  int? clientId;
  int? isRead;
  DateTime?  readAt;
  DateTime?   createdAt;
  String? path;
  DioManager dioManager = DioManager();

  //Constructor
  NotificationModel(
      { this.id,
        this.notificationId,
        this.title,
        this.body,
        this.type,
        this.side,
        this.selectedServiceId,
        this.clientId,
        this.isRead,
        this.readAt,
        this.createdAt,
        this.path});

  factory NotificationModel.fromJson(Map<String, dynamic> parsedJson) {
    return NotificationModel(
        id: parsedJson['id'],
    notificationId : parsedJson['notification_id'],
        title: parsedJson['title'],
        body : parsedJson['body'],
    type : parsedJson['type'],
    side: parsedJson['side'],
    selectedServiceId : parsedJson['selectedservice_id'],
        clientId: parsedJson['client_id'],
        isRead : parsedJson['isread'],
    readAt : parsedJson['read_at'],
    createdAt: parsedJson['created_at'],
    path : parsedJson['path'],

       // price:double.tryParse( parsedJson['price']),
             );
  }

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'notification_id':notificationId  ,
        'title':title ,
        'body':body  ,
        'type':type ,
  'side':side ,
  'selectedservice_id':selectedServiceId  ,
  'client_id':clientId ,
  'isread':isRead  ,
  'read_at':readAt  ,
  'created_at':createdAt ,
  'path':path ,

      };

  Future<List<NotificationModel>> GetNotifylist({ required int clientId,}) async {
    var data = json.encode({
      "id": clientId
    });
    var response = await dioManager.dio.post('client/getnotifylist',
      data: data,);

    List<NotificationModel> notifications;
    print(response.statusCode);
    if (response.statusCode == 200) {
      notifications = convertListToModel<NotificationModel>(NotificationModel.fromJson,jsonDecode(response.data));
    }
    else {
      notifications = List<NotificationModel>.empty();
    }
    return notifications;
  }
  Future<bool> SetToRead({
    required int id
  }) async {
    var data = json.encode({
      "id": id,
    });
    var response = await dioManager.dio.post('client/settoread',
      data: data,
    );
    if (response.statusCode == 200) {
      return true;

    }
    else {
      return false;
    }
  }


  // used  for convert a List of value
  static List<T> convertListToModel<T>(
      T Function(Map<String, dynamic> map) fromJson, List data) {
    return data.map((e) => fromJson((e as Map).cast())).toList();
  }
}