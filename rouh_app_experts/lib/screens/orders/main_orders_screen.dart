import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rouh_app_experts/widgets/rating_stars.dart';

import '../../mystyle/constantsColors.dart';
import '../../widgets/custom_appbar.dart';

class MainOrdersScreen extends StatefulWidget {
  const MainOrdersScreen({super.key});

  @override
  State<MainOrdersScreen> createState() => _MainOrdersScreenState();
}

class _MainOrdersScreenState extends State<MainOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double bodyHeight = (MediaQuery.of(context).size.height //screen
        // - MediaQuery.of(context).padding.top // safe area
        // - AppBar().preferredSize.height //AppBar
    );

    String _selectedOrder = "Order_1";
    List<ClassOrder> orderList = [
      // close - waitConfirm -rejected - waitResponce
      ClassOrder(
        id: 1,
        title: "Duis aute irure dolor",
        state: "close",
        created_at: DateTime.now(),
        answer_speed: 45.6,
        rate: 12,
      ),
      ClassOrder(
        id: 2,
        title: "Duis aute irure dolor",
        state: "waitConfirm",
        created_at: DateTime.now(),
        answer_speed: 0,
        rate: 0,
      ),
      ClassOrder(
        id: 3,
        title: "Duis aute irure dolor",
        state: "rejected",
        created_at: DateTime.now(),
        answer_speed: 0,
        rate: 0,
      ),
      ClassOrder(
        id: 4,
        title: "Duis aute irure dolor",
        state: "waitResponce",
        created_at: DateTime.now(),
        answer_speed: 0,
        rate: 0,
      ),



    ];

    _buildOrders(List<ClassOrder> orders) {
      List<Widget> orderWidgetList = [];
      orders.forEach((ClassOrder order) {
        orderWidgetList.add(
          Column(
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
                            order.state == "close" ?
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
                                      order.state ,
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
                                            order.answer_speed.toString(),
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: mysecondarycolor,
                                              // fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ],
                                      ),
                                      RatingStars(rating: order.rate, size: 12)
                                    ],
                                  ),
                                ),
                              ],
                            ):
                            order.state == "waitConfirm" ?
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
                                      order.state ,
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
                            :order.state == "rejected" ?
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
                                      order.state ,
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
                                      order.state ,
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

                        SvgPicture.asset(
                          // close - waitConfirm -rejected - waitResponce
                          order.state == "close" ?"assets/svg/done_check.svg":
                          order.state == "waitConfirm" ?"assets/svg/wiat_pointInCircle.svg":
                          order.state == "rejected" ?"assets/svg/rejected_close.svg":
                          "assets/svg/wait_circle.svg",
                          width: 15,
                          color: mysecondarycolor,
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      });

      return Column(
        children: orderWidgetList,
      );
    }


    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // top
          const CustomAppBar(title: "Orders"),
          // Body
          Padding(
            padding: EdgeInsets.only(top: bodyHeight * 0.20),
            child: Container(
              height: bodyHeight * 0.80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                // border: Border.all(color: Colors.grey),
                color: Colors.grey[100],
              ),
              child: Padding(
                padding:
                EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),

                    // ordersList
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: _buildOrders(orderList)),
                        )),
                    // Padding(
                    //   padding:
                    //   const EdgeInsets.only(left: 10, top: 0, right: 10, bottom: 0),
                    //   child: SingleChildScrollView(
                    //     scrollDirection: Axis.horizontal,
                    //     child: _buildServices(serviceList),
                    //   ),
                    // ),


                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ClassOrder{
  int id;
  String title;
  String state;
  DateTime created_at;
  double answer_speed;
  double rate;

  ClassOrder({ required this.id, required this.title, required this.state, required this.created_at,required this.answer_speed,required this.rate});
}