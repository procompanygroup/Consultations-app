import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rouh_app/models/service_value_model.dart';

// import 'package:record/record.dart';
// import 'package:audioplayers/audioplayers.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../controllers/globalController.dart';
import '../../models/service_model.dart';
import '../../mystyle/constantsColors.dart';
import 'service_application_screen.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({Key? key}) : super(key: key);

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  bool isLoadingServices = true;
  bool isLoadingServicesApplication = false;

  // final controller = PageController(viewportFraction: 0.8, keepPage: true);
  final pageController = PageController(viewportFraction: 0.8, keepPage: true);
  Service appService = Service();
  List<Service> serviceList = <Service>[];

  List<Service> starterServiceList = [
    Service(
        name: "",
        desc: "",
        image: ""),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fillServiceList();

  }

  Future<void> fillServiceList() async {

    getGlobalServiceList()
        .then((response) {
      setState(() {
         print(response);
        serviceList =response;
        isLoadingServices =false;
        // print("Test:" + isLoading.toString());

      });
    });
    // print(serviceList);
    // print("End:" + isLoading.toString());

  }

  Widget buildPages(List<Service> _serviceList)
  {
    List<Widget> pages = [];
    _serviceList.forEach((Service service) {
      pages.add(
       GestureDetector(
            onTap: ()  async {
              // print(service.id!.toString());

              if(service.name == "callservice")
              {
                 print(service.id!.toString());
              }
              else
                {

              setState(() {
                isLoadingServicesApplication = true;
              });
              var result = await fillServiceInputApplicationList(service.id!);
              setState(() {
                isLoadingServicesApplication = false;
              });
              if(result)
                {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      ServiceApplicationScreen(service: service),
                ),
              );
            }

                }
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white, width: 0.3),
                color: Colors.white,
              ),
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: Container(
                          width: double.maxFinite,
                          // height: height,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child:
                            // Image(
                            //   image: NetworkImage(service.image!),
                            //   fit: BoxFit.fitHeight,
                            // ),
                            Image(
                              image: NetworkImage(service.image!),
                              fit: BoxFit.fitHeight,
                              errorBuilder:
                                  (BuildContext context, Object exception, StackTrace? stackTrace) {
                                    return Image(
                                      image: AssetImage("assets/images/default_image.png"),
                                      fit: BoxFit.fitHeight,
                                    );
                              },
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          service.name!,
                          style: TextStyle(
                            fontSize: 18,
                            color: myprimercolor,
                            // fontWeight: FontWeight.bold
                          ),
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    right: 5,
                    bottom: 35,
                    child: Container(
                      //height: MediaQuery.of(context).size.height * 0.65,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade200),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Icon(Icons.favorite,
                          color: mysecondarycolor,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      );
    });

    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: PageView.builder(
              controller: pageController,
              // itemCount: pages.length,
              itemBuilder: (_, index) {
                return pages[index % pages.length];
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: SmoothPageIndicator(
            controller: pageController,
            count: pages.length,
            effect: const WormEffect(
              activeDotColor: mysecondarycolor,
              dotHeight: 10,
              dotWidth: 10,
              type: WormType.thinUnderground,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double bodyHeight = (MediaQuery.of(context).size.height //screen
            -MediaQuery.of(context).padding.top // safe area
            -AppBar().preferredSize.height //AppBar
        // - 20 // padding bottom
        );


    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Player Audio Screen"),
      // ),
      body: Stack(
        children: [
          Container(
            height: screenHeight ,
            width: screenWidth,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff022440),Color(0xff015DAC)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter  ,
                )
            ),
            child: Align(
              alignment: Alignment.topCenter,
              child: SvgPicture.asset(
                'assets/svg/logo.svg',
                width: screenWidth,
                fit: BoxFit.cover,
                color: Colors.black.withOpacity(0.05),
              ),

            ),

          ),
          SafeArea(
            child: Column(
              children: <Widget>[
                Container(
                  height: (bodyHeight * 0.25),
                  child: Stack(
                    children: [
                      // Top
                      Container(
                        width: screenWidth,
                        height: (bodyHeight * 0.25),
                        child: Padding(
                          padding:  EdgeInsets.only(left: 10,top: ((bodyHeight * 0.25) * 0.2 ),right: 10,bottom: 10),
                          child: Center(
                            child: Image(
                              image: AssetImage("assets/images/logo.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        left: 0,
                        right: 0,
                        child: Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Padding(
                            padding: EdgeInsetsDirectional.only( top: 20,end: 20,),
                            child: ElevatedButton(
                              child: Icon(
                                Icons.notifications,
                                color: myprimercolor,
                                size: 35,
                              ),
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                padding: EdgeInsets.all(5),
                                backgroundColor: Colors.white, // <-- Button color
                                // foregroundColor: Colors.red, // <-- Splash color
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                !isLoadingServices?
                Container(
                  height: (bodyHeight * 0.70),
                    child: buildPages(serviceList))
                :
                Container(
                    height: (bodyHeight * 0.70),
                    child: Stack(
                      children: [
                        buildPages(starterServiceList),
                        Center(child: CircularProgressIndicator()),
                      ],
                    )),

              ],
            ),
          ),
          if(isLoadingServicesApplication)
            Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}

// class Service {
//   String? name;
//   String? desc;
//   String? image;
//   bool? favorite;
//
//   Service({this.name, this.desc, this.image, this.favorite});
// }
