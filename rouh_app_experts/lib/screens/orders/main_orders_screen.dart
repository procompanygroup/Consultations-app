import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rouh_app_experts/bloc/expert/expert_information_cubit.dart';
import 'package:rouh_app_experts/screens/orders/order_info_screen.dart';
import 'package:rouh_app_experts/components/rating_stars.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controllers/converters.dart';
import '../../controllers/globalController.dart';
import '../../models/expert_model.dart';
import '../../models/expert_order_model.dart';
import '../../models/key_value_model.dart';
import '../../mystyle/constantsColors.dart';
import '../../components/custom_appbar.dart';
import '../notifications/notifications_screen.dart';

class MainOrdersScreen extends StatefulWidget {
  const MainOrdersScreen({super.key});

  @override
  State<MainOrdersScreen> createState() => _MainOrdersScreenState();
}

class _MainOrdersScreenState extends State<MainOrdersScreen> {
  bool isLoadingExpertOrders = true;
  bool isLoadingOrderInfo = false;
  String _selectedState = "all";

  // List<String> stateList = [
  //  "all", "no_answer", "wait" ,"reject" ,"agree"
  // ];



  List<ExpertOrder> expertOrderList = <ExpertOrder>[];

  late int expertId ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    expertId = context.read<ExpertInformationCubit>().state.fetchedExpert!.id!;
    // fillExpertOrderList();
    fillExpertOrderListAsync();

  }
/*
  Future<void> fillExpertOrderList() async {
    
    globalExpertOrder.GetOrders(expertId: expertId)
        .then((response) {
      setState(() {
        print(response);
        expertOrderList =response;
        isLoadingExpertOrders =false;
      });
    });
  }
*/
  Future<void> fillExpertOrderListAsync() async {

    var response  = await globalExpertOrder.GetOrders(expertId: expertId);
    setState(() {
      expertOrderList = response;
      isLoadingExpertOrders =false;
    });
  }



  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double bodyHeight = (MediaQuery.of(context).size.height //screen
        -MediaQuery.of(context).padding.top // safe area
        -AppBar().preferredSize.height //AppBar
    );


    Future<void> _refresh() async{
     await fillExpertOrderListAsync();
    }
    _buildStates(List<KeyValue> states) {
      List<Widget> statesWidgetList = [];
      states.forEach((KeyValue state) {
        statesWidgetList.add(
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedState = state.key;
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
                            color: _selectedState == state.key
                                ? mysecondarycolor
                                : Colors.transparent),
                      ),
                    ),
                    child: Text(
                      state.value,
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
              // order.answerState == "agree" ?
               print(order.answerState!);

               if(order.answerState != "agree")
                 {
              setState(() {
                isLoadingOrderInfo = true;
              });

              var resultOrder = await globalExpertOrder.GetOrderById(selectedServiceId: order.selectedServiceId!);

              setState(() {
                isLoadingOrderInfo = false;
              });
              if(resultOrder != null)
              {

                var answerRecordPath = "";
                if(order.answerState == "wait")
                {
                 var  expertAnswer= await globalExpertOrder.GetAnswer(selectedServiceId:   order.selectedServiceId!);
                      answerRecordPath = expertAnswer.recordPath!;
                }
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        OrderInfoScreen(expertOrder: resultOrder, answerRecordPath:answerRecordPath ),
                  ),
                );

              }

                 }


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
                                          order.title! ,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: myprimercolor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      order.orderDate!.toString().split(" ")[0],
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
                              order.answerState == "agree" ?
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "الحالة" ,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade500,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 5,),
                                      Text(
                                        OrderAnswerStateForCard(order.answerState!),
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
                                              "سرعة الرد:" ,
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
                              order.answerState == "wait" ?
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "الحالة" ,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade500,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 5,),
                                      Text(
                                        OrderAnswerStateForCard(order.answerState!),
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
                                        "مراجعة" ,
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
                                  :order.answerState == "reject" ?
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "الحالة" ,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade500,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 5,),
                                      Text(
                                        OrderAnswerStateForCard(order.answerState!),
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
                                        "رد جديد" ,
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
                                        "الحالة" ,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade500,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 5,),
                                      Text(
                                        OrderAnswerStateForCard(order.answerState!),
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
                                        "رد على الطلب" ,
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
                              order.answerState == "close" ?"assets/svg/done_check.svg":
                              order.answerState == "waitConfirm" ?"assets/svg/wiat_pointInCircle.svg":
                              order.answerState == "rejected" ?"assets/svg/rejected_close.svg":
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

      // return RefreshIndicator(
      //     onRefresh: _refresh,
      //       child: Column(
      //           children: orderWidgetList
      //   )
      // );
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
                                    "الرئيسية",
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
                                      try{
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                NotificationsScreen()
                                        ),
                                      );




                                      } catch (err) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(err.toString()),
                                            )
                                        );
                                      }
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
                    child: _buildStates(converterListOrderAnswerState),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                // expertList
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: RefreshIndicator(
                        onRefresh:_refresh,
                        child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            child: _buildOrders(
                                 _selectedState == "all" ||   _selectedState == ""
                                    ?  expertOrderList!
                                     : expertOrderList!
                                    .where((element) => element.answerState! == _selectedState)
                                    .toList()
                                )),
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
            if (isLoadingExpertOrders || isLoadingOrderInfo)
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