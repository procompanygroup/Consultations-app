import 'package:rouh_app/models/service_value_model.dart';

class SelectedService {
  //Instance variables
  int? id;
  int? client_id;
  int? expert_id;
  int? service_id;
  int? points;
  double? rate;
  String? answer;
  String? answer2;
  String? comment;
  bool? iscommentconfirmd;
  bool? issendconfirmd;
  bool? isanswerconfirmd;
  DateTime? created_at;
  DateTime? updated_at;
  String? status;
  int? comment_rate;
  List<ServiceValue>? serviceValues;

  //Constructor
  SelectedService({ this.id,this.client_id,this.expert_id,this.service_id,this.points,this.rate,this.answer,this.answer2,this.comment,
    this.iscommentconfirmd, this.issendconfirmd, this.isanswerconfirmd,this.created_at,this.updated_at,this.status,this.comment_rate,
  this.serviceValues}) ;
}