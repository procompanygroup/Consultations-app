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
  int? expertId;
  // int? isRead;
  bool? isRead;
  DateTime?  readAt;
  DateTime?   createdAt;
  String? path;
  String? orderType;

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
        this.expertId,
        this.isRead,
        this.readAt,
        this.createdAt,
        this.path,
        this.orderType,
      });

  factory NotificationModel.fromJson(Map<String, dynamic> parsedJson) {
    var readAtTmp = null;
    if(parsedJson['read_at'] != null)
      readAtTmp = DateTime.tryParse(parsedJson['read_at']);

    var createdAtTmp = null;
    if(parsedJson['created_at'] != null)
      createdAtTmp = DateTime.tryParse(parsedJson['created_at']);


    var isReadTmp;
    if(parsedJson['isread'] == null)
      isReadTmp = false;
    else if(parsedJson['isread'] != null) {
      isReadTmp = parsedJson['isread'] == 0 ? false : true;
      //tmpFav = bool.tryParse( parsedJson['is_favorite'].toString());
    }

    return NotificationModel(
        id: parsedJson['id'],
    notificationId : parsedJson['notification_id'],
        title: parsedJson['title'],
        body : parsedJson['body'],
    type : parsedJson['type'],
    side: parsedJson['side'],
    selectedServiceId : parsedJson['selectedservice_id'],
      expertId: parsedJson['expert_id'],
        isRead : isReadTmp,
    readAt : readAtTmp,
    createdAt: createdAtTmp,
    path : parsedJson['path'],
      orderType : parsedJson['order_type'],

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
  'expert_id':expertId ,
  'isread':isRead  ,
  'read_at':readAt  ,
  'created_at':createdAt ,
  'path':path ,
        'order_type': orderType ,
      };

  Future<List<NotificationModel>> GetNotifylist({ required int expertId,}) async {
    var data = json.encode({
      "id": expertId
    });
    var response = await dioManager.dio.post('expert/getnotifylist',
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


  Future<NotificationModel?> GetNotifyById({ required int id,}) async {
    var data = json.encode({
      "id": id
    });
    var response = await dioManager.dio.post('expert/getnotifybyid',
      data: data,);
    NotificationModel notification;
    print(response.statusCode);
    if (response.statusCode == 200) {
      return NotificationModel.fromJson(json.decode(response.data));
    }
    else {
      return throw Exception();
    }
  }


  Future<bool> SetToRead({
    required int id
  }) async {
    var data = json.encode({
      "id": id,
    });
    var response = await dioManager.dio.post('expert/settoread',
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