import '../constants/global.dart';
import '../models/service_model.dart';


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