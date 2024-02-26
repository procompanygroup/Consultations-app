import 'dart:convert';
import 'user_model.dart';

class ExpertComment {
  //Instance variables
  int? id;
  int? expert_id;
  int? service_id;
  int? client_id;
  String? comment;
  String? comment_state;
  DateTime? comment_date;
  String? answer_state;
  String? answer_state_conv;
  User? client;
  List<Answer>? answers;


  //Constructor
  ExpertComment(
      { this.id,
        this.expert_id,
        this.service_id,
        this.client_id,
        this.comment,
        this.comment_state,
        this.comment_date,
        this.answer_state,
        this.answer_state_conv,
        this.client,
      this.answers});

  factory ExpertComment.fromJson(dynamic parsedJson) {
    var tmpAnswers;
    if(parsedJson["answers"] != null)
    {
      tmpAnswers = convertListToModel(Answer.fromJson, parsedJson["answers"]);
    }
    return ExpertComment(
      id: parsedJson['id'],
      expert_id: parsedJson['expert_id'],
      service_id: parsedJson['service_id'],
      client_id: parsedJson['client_id'],
      comment: parsedJson['comment'],
      comment_state: parsedJson['comment_state'],
      answer_state: parsedJson['answer_state'],
      answer_state_conv: parsedJson['answer_state_conv'],
      comment_date : DateTime.tryParse(parsedJson['comment_date']),
      client: User.fromJson(parsedJson['client']),
      answers : tmpAnswers,
    );
  }

  static List<T> convertListToModel<T>(
      T Function(Map<String, dynamic> map) fromJson, List data) {
    return data.map((e) => fromJson((e as Map).cast())).toList();
  }
}

class Answer {
  //Instance variables
  int? id;
  String? record;
  String? content;
  String? answer_reject_reason;
  String? answer_state;
  int? selectedservice_id;
  int? updateuser_id;
  DateTime? created_at;
  DateTime? updated_at;


  //Constructor
  Answer(
      { this.id,
        this.record,
        this.content,
        this.answer_reject_reason,
        this.answer_state,
        this.selectedservice_id,
        this.updateuser_id,
        this.created_at,
        this.updated_at
      });

  factory Answer.fromJson(dynamic parsedJson) {
    var tmpUpdatedAt = null ;
  if(parsedJson['updated_at'] != null)
      tmpUpdatedAt = DateTime.tryParse(parsedJson['updated_at']);
    return Answer(
      id: parsedJson['id'],
      record: parsedJson['record'],
      content: parsedJson['content'],
      answer_reject_reason: parsedJson['answer_reject_reason'],
      answer_state: parsedJson['answer_state'],
      selectedservice_id: parsedJson['selectedservice_id'],
      updateuser_id: parsedJson['updateuser_id'],
      created_at: DateTime.tryParse(parsedJson['created_at']),
      updated_at : tmpUpdatedAt,
    );
  }


}