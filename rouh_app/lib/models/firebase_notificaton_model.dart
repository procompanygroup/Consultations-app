
class FirebaseNotificatonModel{
  int? id;
  String? title;
  String? body;

  //Constructor
  FirebaseNotificatonModel({ this.id,this.title,this.body}) ;


  factory FirebaseNotificatonModel.fromJson(Map<String, dynamic> parsedJson) {
    print('FirebaseNotificatonModel.fromJson');
    print(parsedJson);
    return FirebaseNotificatonModel(
      id: int.parse(parsedJson['id']) ,
      title: parsedJson['title'],
      body: parsedJson['body'],
    );
  }
}