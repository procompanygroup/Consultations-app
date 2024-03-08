import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rouh_app_experts/bloc/expert/expert_information_cubit.dart';
import 'package:rouh_app_experts/screens/orders/order_info_screen.dart';
import 'package:rouh_app_experts/widgets/rating_stars.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controllers/globalController.dart';
import '../../models/expert_model.dart';
import '../../models/expert_order_model.dart';
import '../../mystyle/constantsColors.dart';
import '../../widgets/custom_appbar.dart';

class MainOrdersScreen extends StatefulWidget {
  const MainOrdersScreen({super.key});

  @override
  State<MainOrdersScreen> createState() => _MainOrdersScreenState();
}

class _MainOrdersScreenState extends State<MainOrdersScreen> {
  bool isLoadingExpertOrders = true;
  String _selectedState = "all";

  List<String> stateList = [
   "all", "no_answer", "wait" ,"reject" ,"agree"
  ];

  List<ExpertOrder> expertOrderList = <ExpertOrder>[];

  late int expertId ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    expertId = context.read<ExpertInformationCubit>().state.fetchedExpert!.id!;
    fillExpertOrderList();

  }

  Future<void> fillExpertOrderList() async {
    
    globalExpertOrder.GetOrders(expertId: expertId)
        .then((response) {
      setState(() {
        print(response);
        expertOrderList =response;
        isLoadingExpertOrders =false;
        // print("Test:" + isLoading.toString());

      });
    });
  }



  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double bodyHeight = (MediaQuery.of(context).size.height //screen
        -MediaQuery.of(context).padding.top // safe area
        -AppBar().preferredSize.height //AppBar
    );


/*
    String _selectedOrder = "Order_1";
    List<ClassOrder> orderList = [
      // close - waitConfirm -rejected - waitResponce
      ClassOrder(
        id: 1,
        title: "Duis aute irure dolor",
        state: "close",
        created_date: DateTime.now(),
        answer_speed: 45.6,
        rate: 12,
      ),
      ClassOrder(
        id: 2,
        title: "Duis aute irure dolor",
        state: "waitConfirm",
        created_date: DateTime.now(),
        answer_speed: 0,
        rate: 0,
      ),
      ClassOrder(
        id: 3,
        title: "Duis aute irure dolor",
        state: "rejected",
        created_date: DateTime.now(),
        answer_speed: 0,
        rate: 0,
      ),
      ClassOrder(
        id: 4,
        title: "Duis aute irure dolor",
        state: "waitResponce",
        created_date: DateTime.now(),
        answer_speed: 0,
        rate: 0,
      ),



    ];
*/
    _buildStates(List<String> states) {
      List<Widget> statesWidgetList = [];
      states.forEach((String state) {
        statesWidgetList.add(
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedState = state;
                print(_selectedState);



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
                            color: _selectedState == state
                                ? mysecondarycolor
                                : Colors.transparent),
                      ),
                    ),
                    child: Text(
                      state,
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
        children: statesWidgetList,
      );
    }
    _buildOrders(List<ExpertOrder> orders) {
      List<Widget> orderWidgetList = [];
      orders.forEach((ExpertOrder order) {
        orderWidgetList.add(
          GestureDetector(
            onTap: () async {
              print(order.formState);
              print(order.serviceValues);

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      OrderInfoScreen(expertOrder:order),
                ),
              );
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Container(
                    width: screenWidth - 20 ,
                    decoration: BoxDecoration(
                      // border: Border.all(color: mysecondarycolor,width: 1),
                      borderRadius: BorderRadius.circular(20),
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              //Row 1
                              Container(
                                height: 20,
                                child: Row(
                                  children: [
                                    // title
                                    Expanded(
                                      child: Padding(
                                        padding:  EdgeInsetsDirectional.only(start: 25),
                                        child: Text(
                                          "Duis aute irure dolor in reprehenderit" ,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: myprimercolor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "2022/22/22" ,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade600,
                                        // fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10,),
                              // Row 2
                              // close State
                              order.formState == "close" ?
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Status" ,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade500,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 5,),
                                      Text(
                                        order.formState! ,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade300,
                                          // fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 10,),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Respond Answer:" ,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey.shade500,
                                                // fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(width: 5,),
                                            Text(
                                              order.answerSpeed.toString(),
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: mysecondarycolor,
                                                // fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ],
                                        ),
                                        RatingStars(rating:double.parse(order.rate.toString()) , size: 12)
                                      ],
                                    ),
                                  ),
                                ],
                              ):
                              order.formState == "waitConfirm" ?
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Status" ,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade500,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 5,),
                                      Text(
                                        order.formState! ,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: myprimercolor,
                                          // fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Review" ,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade500,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 5,),
                                      SvgPicture.asset(
                                        "assets/svg/enter_icon.svg",
                                        width: 12,
                                        color: mysecondarycolor,
                                      ),
                                    ],
                                  ),
                                ],
                              )
                                  :order.formState == "rejected" ?
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Status" ,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade500,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 5,),
                                      Text(
                                        order.formState! ,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: mysecondarycolor,
                                          // fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "New Reply" ,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade500,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 5,),
                                      SvgPicture.asset(
                                        "assets/svg/enter_icon.svg",
                                        width: 12,
                                        color: mysecondarycolor,
                                      ),
                                    ],
                                  ),
                                ],
                              )
                                  :Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Status" ,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade500,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 5,),
                                      Text(
                                        order.formState! ,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: myprimercolor,
                                          // fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Respond" ,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade500,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 5,),
                                      SvgPicture.asset(
                                        "assets/svg/enter_icon.svg",
                                        width: 12,
                                        color: mysecondarycolor,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 5,),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 2.5),
                            child: SvgPicture.asset(
                              // close - waitConfirm -rejected - waitResponce
                              order.formState == "close" ?"assets/svg/done_check.svg":
                              order.formState == "waitConfirm" ?"assets/svg/wiat_pointInCircle.svg":
                              order.formState == "rejected" ?"assets/svg/rejected_close.svg":
                              "assets/svg/wait_circle.svg",
                              width: 15,
                              color: mysecondarycolor,
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });

      return Column(
        children: orderWidgetList,
      );
    }


    return Scaffold(
      body: Stack(
        children: [
          Column(
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
                                     Icons.notifications,
                                    color: myprimercolor,
                                    size: 35,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    shape: CircleBorder(),
                                    padding: EdgeInsets.all(5),
                                    backgroundColor:
                                    Colors.white, // <-- Button color
                                    // foregroundColor: Colors.red, // <-- Splash color
                                  ),
                                  onPressed: () {

                                  },
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
                padding: const EdgeInsets.only(
                    left: 10, top: 0, right: 10, bottom: 0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: _buildStates(stateList),
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
                        child: _buildOrders(
                             _selectedState == "all" ||   _selectedState == ""
                                ?  expertOrderList!
                                 : expertOrderList!
                                .where((element) => element.formState! == _selectedState)
                                .toList()
                            )),
                  )),
              SizedBox(
                height: 10,
              ),
            ],
          ),
          if (isLoadingExpertOrders)
            Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}

/*
class ClassOrder{
  int id;
  String title;
  String state;
  DateTime created_date;
  double answer_speed;
  double rate;

  ClassOrder({ required this.id, required this.title, required this.state, required this.created_date,required this.answer_speed,required this.rate});
}
*/