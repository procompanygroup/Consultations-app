import '../constants/global.dart';
import '../models/service_input_model.dart';
import '../models/service_model.dart';
import '../models/service_value_model.dart';


// Service
Service globalService = Service();
List<Service> globalServiceList = <Service>[];
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


// Service Input and Value

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
