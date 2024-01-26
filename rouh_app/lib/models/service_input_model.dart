import 'dart:convert';

import '../controllers/dio_manager_controller.dart';

class ServiceInput {
  //Instance variables
  int? id;
  int? input_id;
  int? service_id;
  List<Input>? input;

  DioManager dioManager = DioManager();

  //Constructor
  ServiceInput({ this.id, this.input_id, this.service_id, this.input, }) {

  }
}

class Input {
  int? id;
  String? name;
  String? type;
  String? tooltipe;
  String? icon;
  int? ispersonal;
  List<InputValues>? inputValues;

  //Constructor
  Input({ this.id, this.name, this.type, this.tooltipe, this.icon,this.ispersonal,this.inputValues }) {

  }
}

class InputValues{
  int? id;
  String? value;
  int? input_id;

  //Constructor
  InputValues({ this.id, this.value, this.input_id, }) {

  }
}