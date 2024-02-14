import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rouh_app/models/expert_model.dart';
import 'package:rouh_app/widgets/rating_stars.dart';
import 'package:rouh_app/widgets/record_and_play_screen.dart';

import '../../controllers/globalController.dart';
import '../../models/service_model.dart';
import '../../mystyle/button_style.dart';
import '../../mystyle/constantsColors.dart';
import '../../widgets/custom_image.dart';
import '../../widgets/play_record_screen.dart';

class ExpertInfo extends StatefulWidget {
  const ExpertInfo({super.key, required this.expert});
  final Expert expert;

  @override
  State<ExpertInfo> createState() => _ExpertInfoState();
}

class _ExpertInfoState extends State<ExpertInfo> {
  int _selectedService = 0;
  List<Service> serviceList = <Service>[];

  int _selectedCommentTest = 0;
  List<CommentTest> commentTestList = <CommentTest>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fillServiceList();
    fillCommentTestList();

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
  Future<void> fillCommentTestList() async {
    commentTestList.add(
        CommentTest(name: "Commenter-1", date: "2022/2/2"
            , desc: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        ,url: "https://picsum.photos/200/300?random=1")
    );
    commentTestList.add(
        CommentTest(name: "Commenter-1", date: "2022/2/2"
            , desc: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. At augue eget arcu dictum varius duis at. Sit amet volutpat consequat mauris nunc congue."
            ,url: "https://picsum.photos/200/300?random=2")
    );
    commentTestList.add(
        CommentTest(name: "Commenter-1", date: "2022/2/2"
            , desc: "At augue eget arcu dictum varius duis at. Sit amet volutpat consequat mauris nunc congue."
            ,url: "https://picsum.photos/200/300?random=3")
    );


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
                              service.name!.toString(),
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey.shade400,
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
    _buildCommentTests(List<CommentTest> commentTests) {
      return Column(
          children: List.generate(commentTests.length, (index) {
            CommentTest commentTest = commentTests[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child:  Container(
                    width: screenWidth - 40,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                        children: [
                            // comment image
                            CustomImage(url: commentTest.url,
                              height: 40, width: 40,
                              radius: 10,
                              borderColor:  Colors.blue,
                              borderWidth:  0.5,
                            ),
                            SizedBox(height: 5,),
                            // comment name
                            Container(
                              width: 40,
                              child: Text(
                                commentTest.name! ,
                                style: TextStyle(
                                  fontSize: 8,
                                  color: mysecondarycolor,
                                ),
                              ),
                            ),
                            // comment date
                            Container(
                              width: 40,
                              child:Text(
                                commentTest.date!,
                                style: TextStyle(
                                  fontSize: 8,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // comment text
                        Padding(
                          padding:  EdgeInsetsDirectional.only(start: 20,),
                          child: Container(
                            width: screenWidth - 40 -10 - 40 - 35,
                            decoration: BoxDecoration(
                              border: Border.all(color: mysecondarycolor,width: 1),
                              borderRadius: BorderRadius.circular(20),
                              // color: Colors.grey.shade50,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              child: Text(
                                commentTest.desc! ,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                  // fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            );
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
                      padding: EdgeInsetsDirectional.only(end: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                          onTap: (){},
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(150),
                                  color: Colors.white),
                              child: Icon(
                                Icons.notifications_none_outlined,
                                size: 30,
                                color: myprimercolor,
                              ),
                            ),
                          ),
                          SizedBox(height: 5,),
                          Text("Folow",
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.white),
                          ),
                        ],
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
                      SizedBox(height:bodyHeight*0.095 ,),
                      // expert_name
                      Text(widget.expert.expert_name!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: mysecondarycolor),
                      ),
                      // RatingStars
                      Padding(
                    padding: const EdgeInsets.symmetric(vertical:5),
                    child: Container(
                      width: 125,
                        child: Center(
                            child: RatingStars(
                                rating: widget.expert.rates!, size: 20))),
                  ),
                      // PlayRecordScreen
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        child: PlayRecordScreen(audioUrl: "https://oras.orasweb.com/storage/images/values/records/15562135.mp3"),
                      ),
                      // Experts Title
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // expert description
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                                  child: Container(
                                    width: screenWidth - 60,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey.shade200,width: 1),
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.grey.shade50,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start ,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Text(
                                              "Information apout expert" ,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: mysecondarycolor,
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Text(
                                              widget.expert.desc! ,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey.shade600,
                                                // fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // comments title
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(25)),
                                          color: mysecondarycolor,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(7.5),
                                          child: SvgPicture.asset(
                                            "assets/svg/speech-bubble-black-icon.svg",
                                            width: 12.5,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 5),
                                        child: Text(
                                          "Comments" ,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: myprimercolor
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // comments
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: _buildCommentTests(commentTestList!)),
                                ),


                              ],
                            )
                        ),
                    ),
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
                    GestureDetector(
                      onTap: (){},
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(150),
                            border: Border.all(color: Colors.grey.shade300, width: 3),
                            color: Colors.white),
                        child:Icon( widget.expert.isFavorite!?  Icons.favorite :Icons.favorite_border  ,
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

class CommentTest{
  String? name;
  String? date;
  String? desc;
  String? url;

  CommentTest({this.name, this.date, this.desc, this.url});

}
