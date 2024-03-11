import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:rouh_app/models/audio_file_model.dart';

import 'package:rouh_app/models/service_input_model.dart';
import 'package:rouh_app/models/service_value_model.dart';

import '../controllers/dio_manager_controller.dart';

class Service {
  //Instance variables
  int? id;
  String? name;
  String? desc;
  String? icon;
  int? is_active;
  String? image;
  String? message;
  List<ServiceInput>? serviceInputs;

  DioManager dioManager = DioManager();

  //Constructor
  Service(
      {this.id, this.name, this.desc, this.icon, this.is_active, this.image,this.message,this.serviceInputs}) ;

  factory Service.fromJson(dynamic parsedJson) {
    var tmpServiceInputs;
    if(parsedJson["inputservices"] != null)
      {
         tmpServiceInputs = convertListToModel(ServiceInput.fromJson, parsedJson["inputservices"]);
      }
    return Service(
    id: parsedJson['id'],
    name: parsedJson['name'],
    desc: parsedJson['desc'],
    icon: parsedJson['icon'],
    image: parsedJson['image'],
     is_active: parsedJson['is_active'],
    message: parsedJson['message'].toString(),
     serviceInputs : tmpServiceInputs,
     );
  }

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'name': name,
        'desc': desc,
        'icon': icon,
        'is_active': is_active,
        'image': image,
      };

  Future<List<Service>> allServices() async {

    var response = await dioManager.dio.post('client/service/viewall', );

    if (response.statusCode == 200) {
      var services = convertListToModel<Service>(Service.fromJson,jsonDecode(response.data));
      return services;
    }
    else {
      return throw Exception();
    }

  }

  Future<Service?> getServiceInputs({
    required int serviceId,
  }) async {

    var data = json.encode({
      "id": serviceId
    });

    var response = await dioManager.dio.post('client/service/getinputform',data: data );
    if (response.statusCode == 200) {
      var service = Service.fromJson(json.decode(response.data));

      return service;
    }
    else {
      return throw Exception();
    }

  }

Future<Service?> saveWithValues({
    required int clientId,
    required int expertId,
    required int serviceId,
  required int? imageInputServiceId,
  required List<ServiceValue>? serviceValues,
  AudioFile? audioFile,
  List<String?>? serviceImages
  // File? image1,
  // File? image2,
  // File? image3,
  // File? image4,

  }) async {

     final  inputsValues =List<APIInputValue>.empty(growable: true);
    APIInputValue inputValue ;

    if(serviceValues != null)
  serviceValues.forEach((serviceVal) {
    if(serviceVal.value != null) {
      inputValue = APIInputValue(
          inputservice_id: serviceVal.inputservice_id, value: serviceVal.value);
      inputsValues.add(inputValue);
    }
      });

     var data = json.encode({
       "client_id": clientId,
       "expert_id": expertId,
       "service_id": serviceId,
       "valueServices":inputsValues
     });

    var response = await dioManager.dio.post('client/service/savewithvalues',data: data );

    if (response.statusCode == 200) {
      var service = Service.fromJson(json.decode(response.data));
      if(service.message == "no balance")
        {

        }
      else if(int.parse(service.message as String) > 0)
        {

          final map = <String, dynamic>{};
          map['selectedservice_id'] = service.message;

          if(audioFile != null)
            {
              var recordInputId= audioFile.serviceInputId;
              var recordFile = audioFile?.audioFile ==null? null : await MultipartFile.fromFile(
                  audioFile!.audioFile!.path,filename: "record.mp3"
                );

              map['record_inputservice_id'] = recordInputId;
              map['record'] = recordFile;
            }
          if(serviceImages![0] !=null || serviceImages![1] !=null || serviceImages![2] !=null ||serviceImages![3] !=null )
            {
              map['inputservice_id'] = imageInputServiceId;

              if(serviceImages![0] !=null)
                {
                  var imageFile1 = await MultipartFile.fromFile(
                    serviceImages![0]!,
                  );
                  map['image_1'] = imageFile1;

                }
              if(serviceImages![1] !=null)
                {
                  var imageFile2 = await MultipartFile.fromFile(
                    serviceImages![1]!,
                  );
                  map['image_2'] = imageFile2;

                }
              if(serviceImages![2] !=null)
                {
                  var imageFile3 = await MultipartFile.fromFile(
                    serviceImages![2]!,
                  );
                  map['image_3'] = imageFile3;
                }
              if(serviceImages![3] !=null)
                {
                  var imageFile4 = await MultipartFile.fromFile(
                    serviceImages![3]!,
                  );
                  map['image_4'] = imageFile4;
                }
            }

         var formData = FormData.fromMap(map);
             response = await dioManager.dio.post('client/service/uploadfilesvalue',data: formData );
             print(response.statusCode);
        }
      //message; no balance
      //or
      // message: id of selected service
      return service;
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


class APIInputValue{
  int? inputservice_id;
  String? value;

  //Constructor
  APIInputValue({this.inputservice_id,this.value});

  Map<String, dynamic> toJson() =>
      {
        'inputservice_id': inputservice_id,
        'value': value,
      };


}
