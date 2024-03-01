import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../mystyle/constantsColors.dart';
import '../../widgets/custom_appbar.dart';

class PurchaseShop extends StatefulWidget {
  const PurchaseShop({super.key});

  @override
  State<PurchaseShop> createState() => _PurchaseShopState();
}

class _PurchaseShopState extends State<PurchaseShop> {


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double bodyHeight = (MediaQuery.of(context).size.height //screen
        // - MediaQuery.of(context).padding.top // safe area
        // - AppBar().preferredSize.height //AppBar
    );



    String _selectedPoint = "Point_1";
    List<ClassPoint> pointList = [
      ClassPoint(
        id:1,
          count: 1,
          price: 5,
          countbefor: 5,
          ),
      ClassPoint(
        id:2,
        count: 45,
        price: 5,
        countbefor: 0,
      ),
      ClassPoint(
        id:3,
        count: 85,
        price: 68,
        countbefor: 74,
      ),
      ClassPoint(
        id:4,
        count: 58,
        price: 56,
        countbefor: 0,
      ),
      ClassPoint(
        id:5,
        count: 1,
        price: 5,
        countbefor: 5,
      ),
      ClassPoint(
        id:6,
        count: 1,
        price: 5,
        countbefor: 5,
      ),
      ClassPoint(
        id:7,
        count: 1,
        price: 5,
        countbefor: 5,
      ),

    ];
    _buildPoints(List<ClassPoint> points) {
      return StaggeredGrid.count(
        // padding: EdgeInsets.symmetric(horizontal: 10.0),
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: List.generate(points.length, (index) {
            ClassPoint point = points[index];
            return GestureDetector(
                onTap: () {
                  setState(() {
                    // dina
                    _selectedPoint = point.price!.toString();
                    print(_selectedPoint);
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
                                image: AssetImage("assets/images/rouh-image-point-shop.png"),
                                // height: (screenWidth-20 ) /2,
                                // width: (screenWidth-20 ) /2,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              point.price!.toString() + '\$',
                              style: TextStyle(
                                fontSize: 18,
                                color: myprimercolor,
                                // fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ],
                      ),
                      // countbefor
                      if(point.countbefor!>0)
                      PositionedDirectional(
                        start: 0,
                        end: 0,
                        top: 0,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Stack(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    point.countbefor!.toString(),
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey.shade600,
                                      // fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(width: 5,),
                                  SvgPicture.asset(
                                    "assets/svg/money.svg",
                                    color: Colors.grey.shade600,
                                    width: 15,
                                  ),
                                ],
                              ),
                              PositionedDirectional(
                                top: 0,
                                bottom: 0,
                                start: 0,
                                end: 0,
                                child: Center(
                                  child: Container(
                                      height: 2,
                                      color: mysecondarycolor,
                                    child:  Container(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 15),
                                        child: Text(
                                          point.countbefor!.toString(),
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.grey.shade600,
                                            // fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // countbefor
                      PositionedDirectional(
                        start: 0,
                        end: 0,
                        top: 0,
                        child: Padding(
                          padding:  EdgeInsets.only(top: ((screenWidth - 65) / 2.5)/2.5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                point.count!.toString(),
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  // fontWeight: FontWeight.bold
                                ),
                              ),
                              SizedBox(width: 5,),
                              SvgPicture.asset(
                                "assets/svg/money.svg",
                                color: Color(0xffF5CC2A),
                                width: 25,
                              ),
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ));
          }));
    }


    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // top
          const CustomAppBar(title: "Purchase Shop"),
          // Body
          Padding(
            padding: EdgeInsets.only(top: bodyHeight * 0.20),
            child: Container(
              height: bodyHeight * 0.80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                border: Border.all(color: Colors.grey),
                color: Colors.white,
              ),
              child: Padding(
                padding:
                EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/svg/money.svg",
                          color: myprimercolor,
                          width: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            "Balance",
                            style: TextStyle(
                              fontSize: 18,
                              color: myprimercolor,
                              // fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Text(
                          "110",
                          style: TextStyle(
                            fontSize: 18,
                            color: mysecondarycolor,
                            // fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 25, top: 10, right: 25, bottom: 10.0),
                      child: Divider(color: Colors.grey.shade300),
                    ),
                    // pointList
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: _buildPoints(pointList!)),
                        )),
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


class ClassPoint{
  int? id;
  int? count;
  int? price;
  int? countbefor;

  //Constructor
  ClassPoint(
      { this.id, this.count, this.price, this.countbefor});
}