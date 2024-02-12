import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rouh_app/models/expert_model.dart';
import 'package:rouh_app/widgets/rating_stars.dart';
import 'package:rouh_app/widgets/record_and_play_screen.dart';

import '../../controllers/globalController.dart';
import '../../models/service_model.dart';
import '../../mystyle/button_style.dart';
import '../../mystyle/constantsColors.dart';

class ExpertInfo extends StatefulWidget {
  const ExpertInfo({super.key, required this.expert});
  final Expert expert;

  @override
  State<ExpertInfo> createState() => _ExpertInfoState();
}

class _ExpertInfoState extends State<ExpertInfo> {
  int _selectedService = 0;
  List<Service> serviceList = <Service>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fillServiceList();




  }
  Future<void> fillServiceList() async {

    getGlobalServiceWithoutCallWithAllList()
        .then((response) {
      setState(() {
        print(response);
        serviceList =response;

        if(serviceList.isNotEmpty)
          _selectedService = serviceList[0].id!;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double bodyHeight = (MediaQuery.of(context).size.height //screen
        // -MediaQuery.of(context).padding.top // safe area
        // -AppBar().preferredSize.height //AppBar
    );


    _buildServices(List<Service> services) {
      return Row(
          children: List.generate(services.length, (index) {
            Service service = services[index];
            return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedService = service.id!;
                    print(_selectedService);
                  });
                },
                child: Container(
                  width: 90,
                  height: 65,
                  decoration: BoxDecoration(
                    border: Border.all(color: mysecondarycolor,width: 1),
                    borderRadius: BorderRadius.circular(20),
                    // color: mysecondarycolor,
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        service.icon != null?
                        Container(
                          width: 35,
                          height: 35,
                          child: SvgPicture.network(
                            service.icon!,
                            width: 35,
                            height: 35,
                            color: mysecondarycolor,
                          ),
                        )
                        : Icon(
                          Icons.account_circle,
                          size: 35,
                          color: mysecondarycolor,
                        ),
                         Expanded(
                           child: Text(
                              service.name!.toString() + " Hello",
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                                // fontWeight: FontWeight.bold
                            ),
                             ),
                         ),
                      ],
                    ),
                  ),
                ));
          }));
    }

    return Scaffold(
      //backgroundColor: const Color(0xff022440),
      body: Stack(
          children: [
            //Top
            Container(
              height: bodyHeight * 0.30,
              width: screenWidth,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xff015DAC), Color(0xff022440)],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  )),
              child: Padding(
                padding: EdgeInsetsDirectional.only(bottom: bodyHeight * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Transform(
                      transform: Matrix4.identity().scaled(-1.0, 1.0, 1.0),
                      child: InkWell(
                          child: SvgPicture.asset(
                            "assets/svg/back-arrow.svg",
                            width: 35,
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          }),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(end: 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(5),
                          backgroundColor:
                          Colors.grey.shade50, // <-- Button color
                          // foregroundColor: Colors.red, // <-- Splash color
                        ),
                        onPressed: () {},
                        child: Icon(
                          Icons.shopping_cart,
                          size: 35,
                          color: myprimercolor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Body
            Padding(
              padding: EdgeInsets.only(top: bodyHeight * 0.20),
              child: Container(
                width: screenWidth,
                height: bodyHeight * 0.80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                  border: Border.all(color: Colors.grey),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
                  child: Column(
                    children: [
                      SizedBox(height:bodyHeight*0.1 ,),
                      Text(widget.expert.expert_name!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: mysecondarycolor),
                      ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical:5),
                    child: Container(
                      width: 125,
                        child: Center(
                            child: RatingStars(
                                rating: widget.expert.rates!, size: 20))),
                  ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: RecordAndPlayScreen(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text("Experts",
                            style: TextStyle(
                                fontSize: 16,
                                color: myprimercolor),
                          ),
                        ),
                      ),

                      // serviceList
                       Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: _buildServices(serviceList!)),
                          ),



                ],
                  ),
                ),
              ),
            ),

            //Image
            Container(
              height: bodyHeight * 0.30,
              width: screenWidth,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Stack(children: [
                  Container(
                    width: bodyHeight * 0.20,
                    height: bodyHeight * 0.20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80),
                        border: Border.all(color: Colors.white, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        color: Colors.blueGrey),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(80),
                      child: Image(
                        image: NetworkImage("https://picsum.photos/200/300?random=4"),
                        fit: BoxFit.cover,
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

                  Positioned(
                    right: 5,
                    bottom: 5,
                    child:
                    Container(
                      //height: MediaQuery.of(context).size.height * 0.65,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        border: Border.all(color: Colors.grey.shade300, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Icon(Icons.favorite,
                          color: mysecondarycolor,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ]
      ),
    );
  }
}
