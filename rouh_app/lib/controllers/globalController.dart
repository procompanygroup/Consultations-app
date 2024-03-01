import '../constants/global.dart';
import '../models/expert_model.dart';
import '../models/point_model.dart';
import '../models/service_input_model.dart';
import '../models/service_model.dart';
import '../models/service_value_model.dart';

Point globalPoint = Point();


//#region Constant
List<String> globallistMaritalStatus = ["Single", "Married", "Divorced", "Widowed"];
List<String> globallistGender = ["Male", "Female"];
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

//#region Service Input and Value
List<ServiceInput> globalServiceInputsApplicationList = <ServiceInput>[];
List<ServiceValue> globalServiceValuesApplicationList = <ServiceValue>[];

Future<bool> fillServiceInputApplicationList(int serviceId) async {
  var serviceInput = await globalService.getServiceInputs(serviceId: serviceId);
  globalServiceInputsApplicationList = serviceInput!.serviceInputs!;

  ServiceValue serviceValue = ServiceValue();
  serviceValue
      .generateInputValues(serviceInputs: serviceInput.serviceInputs)
      .then((responce) => {
        globalServiceValuesApplicationList = responce,
       });

  return true;

}
//#endregion

//#region expert
Expert globalExpert = Expert();

List<Expert> globalExpertWithFavoriteList = <Expert>[];

Future<List<Expert>> getGlobalExpertWithFavoriteList(int clientId) async {
  if(globalExpertWithFavoriteList.isEmpty)
  {
    globalExpertWithFavoriteList = await globalExpert.GetWithFavorite(clientId:clientId);
  }
  return globalExpertWithFavoriteList;
}
//#endregion
