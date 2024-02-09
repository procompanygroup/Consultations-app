import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../models/expert_model.dart';
import '../../models/service_model.dart';
import '../../mystyle/constantsColors.dart';
import '../../widgets/rating_stars.dart';

class ExpertsScreen extends StatefulWidget {
  const ExpertsScreen({Key? key}) : super(key: key);

  @override
  State<ExpertsScreen> createState() => _ExpertsScreenState();
}

class _ExpertsScreenState extends State<ExpertsScreen> {
  String _selectedService = "Service_1";
  List<Service> serviceList = [
    Service(
        name: "Service_1",
        desc: "desc",
        image: "https://picsum.photos/200/300?random=1"),
    Service(
        name: "Service_2",
        desc: "desc",
        image: "https://picsum.photos/200/300?random=2"),
    Service(
        name: "Service_3",
        desc: "desc",
        image: "https://picsum.photos/200/300?random=3"),
    Service(
        name: "Service_4",
        desc: "desc",
        image: "https://picsum.photos/200/300?random=4"),
    Service(
        name: "Service_5",
        desc: "desc",
        image: "https://picsum.photos/200/300?random=5"),
  ];
  String _selectedExpert = "Expert_1";
  List<Expert> expertList = [
    Expert(
        expert_name: "Expert_1",
        desc: "desc",
        image: "https://picsum.photos/200/300?random=1",
        answer_speed: 0.00,
        rates: 0,
        isFavorite: false),
    Expert(
        expert_name: "Expert_2",
        desc: "desc",
        image: "https://picsum.photos/200/300?random=2",
        answer_speed: 0.00,
        rates: 0.5,
        isFavorite: true),
    Expert(
        expert_name: "Expert_3",
        desc: "desc",
        image: "https://picsum.photos/200/300?random=3",
        answer_speed: 0.00,
        rates: 1,
        isFavorite: false),
    Expert(
        expert_name: "Expert_4",
        desc: "desc",
        image: "https://picsum.photos/200/300?random=4",
        answer_speed: 0.00,
        rates: 4,
        isFavorite: true),
    Expert(
        expert_name: "Expert_5",
        desc: "desc",
        image: "https://picsum.photos/200/300?random=5",
        answer_speed: 0.00,
        rates: 3.5,
        isFavorite: false),
    Expert(
        expert_name: "Expert_6",
        desc: "desc",
        image: "https://picsum.photos/200/300?random=6",
        answer_speed: 0.00,
        rates: 3.5,
        isFavorite: false),
    Expert(
        expert_name: "Expert_7",
        desc: "desc",
        image: "https://picsum.photos/200/300?random=7",
        answer_speed: 0.00,
        rates: 3.5,
        isFavorite: true),
    Expert(
        expert_name: "Expert_8",
        desc: "desc",
        image: "https://picsum.photos/200/300?random=8",
        answer_speed: 0.00,
        rates: 3.5,
        isFavorite: false),
    Expert(
        expert_name: "Expert_9",
        desc: "desc",
        image: "https://picsum.photos/200/300?random=9",
        answer_speed: 0.00,
        rates: 3.5,
        isFavorite: true),
    Expert(
        expert_name: "Expert_10",
        desc: "desc",
        image: "https://picsum.photos/200/300?random=10",
        answer_speed: 0.00,
        rates: 3.5,
        isFavorite: false),
    Expert(
        expert_name: "Expert_11",
        desc: "desc",
        image: "https://picsum.photos/200/300?random=11",
        answer_speed: 0.00,
        rates: 3.5,
        isFavorite: false),
    Expert(
        expert_name: "Expert_12",
        desc: "desc",
        image: "https://picsum.photos/200/300?random=12",
        answer_speed: 0.00,
        rates: 3.5,
        isFavorite: true),
    Expert(
        expert_name: "Expert_13",
        desc: "desc",
        image: "https://picsum.photos/200/300?random=13",
        answer_speed: 0.00,
        rates: 3.5,
        isFavorite: false),
    Expert(
        expert_name: "Expert_14",
        desc: "desc",
        image: "https://picsum.photos/200/300?random=14",
        answer_speed: 0.00,
        rates: 3.5,
        isFavorite: true),
    Expert(
        expert_name: "Expert_15",
        desc: "desc",
        image: "https://picsum.photos/200/300?random=15",
        answer_speed: 0.00,
        rates: 3.5,
        isFavorite: false),
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double bodyHeight = (MediaQuery.of(context).size.height //screen
            -
            MediaQuery.of(context).padding.top // safe area
            -
            AppBar().preferredSize.height //AppBar
        );

    //GetByServiceId
    _buildServices(List<Service> services) {
      List<Widget> serviceWidgetList = [];
      services.forEach((Service service) {
        serviceWidgetList.add(
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedService = service.name!;
                print(_selectedService);
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            width: 3,
                            color: _selectedService == service.name
                                ? mysecondarycolor
                                : Colors.transparent),
                      ),
                    ),
                    child: Text(
                      service.name!,
                      style: TextStyle(
                          fontSize: 14,
                          color: myprimercolor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
      return Row(
        children: serviceWidgetList,
      );
    }

    _buildExperts(List<Expert> experts) {
      return StaggeredGrid.count(
          // padding: EdgeInsets.symmetric(horizontal: 10.0),
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: List.generate(experts.length, (index) {
            Expert expert = experts[index];
            return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedExpert = expert.expert_name!;
                    print(_selectedExpert);
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    // border: Border.all(color: myprimercolor,width: 2),
                    borderRadius: BorderRadius.circular(35),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: (screenWidth - 65) / 2.5,
                            width: (screenWidth - 65) / 2,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(35),
                              child: Image(
                                image: NetworkImage(expert.image!),
                                // height: (screenWidth-20 ) /2,
                                // width: (screenWidth-20 ) /2,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          // expert name
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              expert.expert_name!,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                // fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          // rating
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              RatingStars(
                                rating: expert.rates!,
                                size: 20,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                      // Response speed
                      ClipRRect(
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(35),bottomLeft: Radius.circular(35)),
                          child: Container(
                          height: (screenWidth - 65) / 2.5,
                          width: (screenWidth - 65) / 2,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child:  Container(
                                color: Colors.black.withOpacity(0.35),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "Response "+expert.answer_speed!.toString(),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )),
                      // isFavorite
                      Positioned(
                        top: 0,
                        left: 0,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              expert.isFavorite =
                                  expert.isFavorite! ? false : true;
                              print(expert.isFavorite);
                            });
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                bottomRight: Radius.circular(15.0)),
                            child: Container(
                              color: mysecondarycolor,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Icon(
                                  expert.isFavorite!
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ));
          }));
    }

    return Scaffold(
      body: Column(
        children: [
          Container(
            width: screenWidth,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25)),
                // border: Border.all(color: Colors.grey),
                gradient: LinearGradient(
                  colors: [Color(0xff023056), myprimercolor],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )),
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  Stack(
                    children: [
                      // Top
                      Container(
                        width: screenWidth,
                        height: (bodyHeight * 0.20) - 45, // service list,
                        child: Align(
                          alignment: AlignmentDirectional.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              "Experts",
                              style: TextStyle(
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  color: mysecondarycolor),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        child: Align(
                          alignment: AlignmentDirectional.topEnd,
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(
                              top: 20,
                              end: 20,
                            ),
                            child: ElevatedButton(
                              child: Icon(
                                Icons.favorite_border,
                                color: mysecondarycolor,
                                size: 35,
                              ),
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                padding: EdgeInsets.all(5),
                                backgroundColor:
                                    Colors.white, // <-- Button color
                                // foregroundColor: Colors.red, // <-- Splash color
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          // serviceList
          Padding(
            padding:
                const EdgeInsets.only(left: 10, top: 0, right: 10, bottom: 0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: _buildServices(serviceList),
            ),
          ),
          SizedBox(
            height: 10,
          ),

          // expertList
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: _buildExperts(expertList!)),
          )),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
