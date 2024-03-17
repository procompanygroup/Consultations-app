
//#region Constant
import '../models/key_value_model.dart';

List<String> converterListMaritalStatus = ["Single", "Married", "Divorced", "Widowed"];
List<String> converterListGender = ["Male", "Female"];
//#endregion

//#region OrderAnswerState

List<KeyValue> converterListOrderAnswerState = [
  new KeyValue(key: "all", value: "الكل"),
  new KeyValue(key: "no_answer", value: "الطلبات"),
  new KeyValue(key: "wait", value: "بانتظار الموافقة"),
  new KeyValue(key: "reject", value: "مرفوض"),
  new KeyValue(key: "agree", value: "مغلق"),
];

String OrderAnswerStateForCard(String state){
  if(state == "no_answer")
    return "بانتظار الرد";
  else if(state == "wait")
    return "بانتظار الموافقة";
  else if(state == "reject")
    return "مرفوض";
  else if(state == "agree")
    return "مغلق";
  else
    return state;
}

//#endregion
