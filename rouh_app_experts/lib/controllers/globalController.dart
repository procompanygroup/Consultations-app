import '../constants/global.dart';
import '../models/expert_model.dart';
import '../models/expert_order_model.dart';
import '../models/key_value_model.dart';
import '../models/service_model.dart';



ExpertOrder globalExpertOrder = ExpertOrder();



//#region Constant

String boolToTextConverter(String state)
{
  if(state=="True" || state == "1")
    return "نعم";
  else
    return "لا";
}
//#endregion

//#region Service
Service globalService = Service();
List<Service> globalServiceList = <Service>[];
List<Service> globalServiceWithoutCallList = <Service>[];
List<Service> globalServiceWithoutCallWithAllList = <Service>[];
// List<Service> starterServiceList = [
//  Service(
//      name: "",
//      desc: "",
//      image: ""),
// ];
Future<List<Service>> getGlobalServiceList() async {

  if(globalServiceList.isEmpty)
    {
      /*
      globalService.allServices()
          .then((response) {
        print(response);
        globalServiceList =response;
        globalServiceList.forEach((element) {
          print(element.name);
          print(element.desc);
          print(element.icon);
          print(element.is_active);
          print(element.image);
          // print(serviceList[0].ServiceInput[0].name);
        });
      });
      */
      print("start loading");
      globalServiceList =   await globalService.allServices();
      print("end loading");

      globalServiceList.forEach((element) {
          print(element.name);
          print(element.desc);
          print(element.icon);
          print(element.is_active);
          print(element.image);
          // print(serviceList[0].ServiceInput[0].name);
        });
    }
     return globalServiceList;

}
Future<List<Service>> getGlobalServiceWithoutCallList() async {
  if(globalServiceWithoutCallList.isEmpty)
  {
    globalServiceWithoutCallList = await getGlobalServiceList();
    globalServiceWithoutCallList
    = globalServiceWithoutCallList.where((element) => element.name != "callservice").toList();
  }
  return globalServiceWithoutCallList;
}
Future<List<Service>> getGlobalServiceWithoutCallWithAllList() async {
  if(globalServiceWithoutCallWithAllList.isEmpty)
    {
  globalServiceWithoutCallWithAllList.clear();
  globalServiceWithoutCallWithAllList.add(
      Service(id: 0, name: "All", image: "")
  );
    await getGlobalServiceWithoutCallList();
    globalServiceWithoutCallWithAllList.addAll(globalServiceWithoutCallList);
    }
  return globalServiceWithoutCallWithAllList;
}


//#endregion


//#region expert
Expert globalExpert = Expert();


//#endregion
