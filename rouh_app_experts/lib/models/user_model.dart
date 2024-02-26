import 'dart:convert';

import '../controllers/dio_manager_controller.dart';
// import 'auth_model.dart';

class User {
  //Instance variables
  int? id;
  String? user_name;
  String? email;
  String? mobile;
  String? nationality;
  DateTime? birthdate;
  int? gender;
  String? marital_status;
  int? is_active;
  String? image;

   DioManager dioManager= DioManager() ;
  //Constructor
  User({ this.id,this.user_name,this.email,this.mobile,this.nationality,this.birthdate,this.gender,this.marital_status,this.is_active,this.image}) ;
  // {
  //   id = id;
  //   user_name = user_name;
  //   email = email;
  //   mobile =mobile;
  //   nationality =nationality;
  //   birthdate = birthdate;
  //   gender = gender;
  //   marital_status = marital_status;
  //   is_active = is_active;
  //   image = image;
  // }

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    var tmpBirthDate = null;
    if(parsedJson['birthdate'] != null)
      tmpBirthDate = DateTime.tryParse(parsedJson['birthdate']);
    return User(
        id: parsedJson['id'],
        user_name: parsedJson['user_name'],
        mobile: parsedJson['mobile'],
        birthdate:tmpBirthDate ,
        email: parsedJson['email'],
        gender: parsedJson['gender'],
        image: parsedJson['image'],
        is_active: parsedJson['is_active'],
        marital_status: parsedJson['marital_status'],
        nationality: parsedJson['nationality']
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'user_name': user_name,
        'mobile': mobile,
        'birthdate': birthdate,
        'email': email,
        'gender': gender,
        'image': image,
        'is_active': is_active,
        'marital_status': marital_status,
        'nationality': nationality,
      };

  Future<String?> login({
    required String mobile,
  }) async {
    var data = json.encode({
      "mobile": mobile
    });

    var response = await dioManager.dio.post('loginclient',
        data: data,
       );

    // if (response.statusCode == 200) {
    //   return AuthModel.fromJson(json.decode(response.data)).token;
    // }
    // else
    {
      return "";
    }

  }

  Future<User?> getUser({
    required String mobile,
  }) async {
    var data = json.encode({
      "mobile": mobile
    });

    var response = await dioManager.dio.post('client/getbymobile', data: data,);
    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.data));
     // return User.fromJson(response.data);
    }
     else {
       return throw Exception();
     }

  }

  Future<String?> register({  Object? formData}) async {

    try {
      var response = await dioManager.dio.post(
        'registerclient',
        data: formData,
      );
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return "";
      }
    } catch (e) {
      print(e.toString());
    }
    return "";
  }

  Future<String?> Update({  Object? formData}) async {

      var response = await dioManager.dio.post(
        'client/updateprofile',
        data: formData,
      );
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return throw Exception();
      }
  }

  Future<String?> DeleteAccount({  required int clientId}) async {

    var data = json.encode({
      "id": clientId
    });
      var response = await dioManager.dio.post(
        'client/deleteaccount',
        data: data,
      );
      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return throw Exception();
      }
  }
}