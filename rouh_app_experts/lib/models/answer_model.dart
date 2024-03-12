class Answer{
  int? id;
  int? selectedServiceId;
  String? recordName;
  String? answerState;
  String? recordPath;

  Answer({
    this.id,
    this.recordName,
    this.answerState,
    this.selectedServiceId,
    this.recordPath
  });

  factory Answer.fromJson(Map<String,dynamic> json){
    return Answer(
      id:json['id'] ,
      recordName:json['record'] ,
      answerState:json['answer_state'] ,
      selectedServiceId:json['selectedservice_id'] ,
      recordPath:json['record_path'] ,
    );
  }
}