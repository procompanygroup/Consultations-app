import '../models/key_value_model.dart';
import 'globalController.dart';


//#region Gender
String converterGender(String txt){
    try{
      return globalListGender.firstWhere((element) => element.key == txt).value;
    }
    catch(ex)
    {
      return "";
    }
}
//#endregion
//#region MaritalStatus



String converterMaritalStatus(String txt){
  try{
  return globalListMaritalStatus.firstWhere((element) => element.key == txt).value;
  }
  catch(ex)
  {
    return "";
  }
}

//#endregion

//#region OrderAnswerState
/*
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
*/
//#endregion
