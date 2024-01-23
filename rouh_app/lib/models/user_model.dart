import 'dart:convert';

import '../controllers/dio_manager_controller.dart';
import 'auth_model.dart';

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
  User({ id,user_name,email,mobile,nationality,birthdate,gender,marital_status,is_active,image}) {
    id = id;
    user_name = user_name;
    email = email;
    mobile =mobile;
    nationality =nationality;
    birthdate = birthdate;
    gender = gender;
    marital_status = marital_status;
    is_active = is_active;
    image = image;
  }

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return User(
        id: parsedJson['id'],
        user_name: parsedJson['user_name'],
        mobile: parsedJson['mobile'],
        birthdate: parsedJson['birthdate'],
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

    var response = await dioManager.dio.post('loginclient', data: data);

    if (response.statusCode == 200) {
      return AuthModel.fromJson(response.data).token;
    }
    else {
      return throw Exception();
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
      return (new User.fromJson(response.data));
    }
    else {
      return throw Exception();
    }

  }
}