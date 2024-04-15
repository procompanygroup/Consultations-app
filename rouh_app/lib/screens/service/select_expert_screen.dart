import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rouh_app/bloc/audio_file/audio_file_cubit.dart';
import 'package:rouh_app/bloc/service_inputs/service_input_cubit.dart';
import 'package:rouh_app/models/service_model.dart';
import '../../bloc/UserInformation/user_information_cubit.dart';
import '../../constants/global_variable.dart';
import '../../controllers/globalController.dart';
import '../../models/expert_model.dart';
import '../../models/expert_service_model.dart';
import '../../models/service_value_model.dart';
import '../../models/user_model.dart';
import '../../mystyle/constantsColors.dart';
import '../../components/rating_stars.dart';
import '../../components/show_dialog.dart';
import '../main_navigation_screen.dart';
import '../shop/purchase_shop_screen.dart';

class SelectExpert extends StatefulWidget {
  const SelectExpert({super.key,required this.serviceId});
final int serviceId;
  @override
  State<SelectExpert> createState() => _SelectExpertState();
}

class _SelectExpertState extends State<SelectExpert> {
  Service service = Service();
  User user = User();
  var balance;
  bool isLoadingExperts = false;
  List<Expert> expertList = <Expert>[];


  @override
  void initState() {
    // TODO: implement initState


    //serviceImages = [null,null,null,null];
      setState(() {
        user = context.read<UserInformationCubit>().state.fetchedPerson!;
        balance = user.balance;
        //print(user.balance);
      });

      fillExpertList();


    super.initState();
    //
  }
  Future<void> fillExpertList() async {
    setState(() {
      isLoadingExperts = true;
    });
    globalExpert.GetByServiceId(serviceId: widget.serviceId).then((response) {
      setState(() {
        print(response);
        expertList = response;
        isLoadingExperts = false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double bodyHeight = (MediaQuery.of(context).size.height //screen
            // -MediaQuery.of(context).padding.top // safe area
            // - AppBar().preferredSize.height //AppBar
        );
/*
    String _selectedExpert = "Expert_1";
    List<Expert> expertList = [
      Expert(
          expert_name: "Expert_1",
          id:1,
          desc: "desc",
          image: "https://picsum.photos/200/300?random=1",
          answer_speed: 0.00,
          rates: 0,
          isFavorite: false,
          expert_services: [ExpertService(points: 10)]),
      Expert(
          expert_name: "Expert_2",
          id:2,
          desc: "desc",
          image: "https://picsum.photos/200/300?random=2",
          answer_speed: 0.00,
          rates: 0.5,
          isFavorite: true,
          expert_services: [ExpertService(points: 10)]),
      Expert(
          expert_name: "Expert_3",
          id:3,
          desc: "desc",
          image: "https://picsum.photos/200/300?random=3",
          answer_speed: 0.00,
          rates: 1,
          isFavorite: false,
          expert_services: [ExpertService(points: 10)]),
      Expert(
          expert_name: "Expert_4",
          id:4,
          desc: "desc",
          image: "https://picsum.photos/200/300?random=4",
          answer_speed: 0.00,
          rates: 4,
          isFavorite: true,
          expert_services: [ExpertService(points: 10)]),
      Expert(
          expert_name: "Expert_5",
          id:5,
          desc: "desc",
          image: "https://picsum.photos/200/300?random=5",
          answer_speed: 0.00,
          rates: 3.5,
          isFavorite: false,
          expert_services: [ExpertService(points: 10)]),
      Expert(
          expert_name: "Expert_6",
          id:6,
          desc: "desc",
          image: "https://picsum.photos/200/300?random=6",
          answer_speed: 0.00,
          rates: 3.5,
          isFavorite: false,
          expert_services: [ExpertService(points: 10)]),
      Expert(
          expert_name: "Expert_7",
          id:7,
          desc: "desc",
          image: "https://picsum.photos/200/300?random=7",
          answer_speed: 0.00,
          rates: 3.5,
          isFavorite: true,
          expert_services: [ExpertService(points: 10)]),
      Expert(
          expert_name: "Expert_8",
          id:8,
          desc: "desc",
          image: "https://picsum.photos/200/300?random=8",
          answer_speed: 0.00,
          rates: 3.5,
          isFavorite: false,
          expert_services: [ExpertService(points: 10)]),
      Expert(
          expert_name: "Expert_9",
          id:9,
          desc: "desc",
          image: "https://picsum.photos/200/300?random=9",
          answer_speed: 0.00,
          rates: 3.5,
          isFavorite: true,
          expert_services: [ExpertService(points: 10)]),
      Expert(
          expert_name: "Expert_10",
          id:10,
          desc: "desc",
          image: "https://picsum.photos/200/300?random=10",
          answer_speed: 0.00,
          rates: 3.5,
          isFavorite: false,
          expert_services: [ExpertService(points: 10)]),
      Expert(
          expert_name: "Expert_11",
          id:11,
          desc: "desc",
          image: "https://picsum.photos/200/300?random=11",
          answer_speed: 0.00,
          rates: 3.5,
          isFavorite: false,
          expert_services: [ExpertService(points: 10)]),
      Expert(
          expert_name: "Expert_12",
          id:12,
          desc: "desc",
          image: "https://picsum.photos/200/300?random=12",
          answer_speed: 0.00,
          rates: 3.5,
          isFavorite: true,
          expert_services: [ExpertService(points: 10)]),
      Expert(
          expert_name: "Expert_13",
          id:13,
          desc: "desc",
          image: "https://picsum.photos/200/300?random=13",
          answer_speed: 0.00,
          rates: 3.5,
          isFavorite: false,
          expert_services: [ExpertService(points: 10)]),
      Expert(
          expert_name: "Expert_14",
          id:14,
          desc: "desc",
          image: "https://picsum.photos/200/300?random=14",
          answer_speed: 0.00,
          rates: 3.5,
          isFavorite: true,
          expert_services: [ExpertService(points: 10)]),
      Expert(
          expert_name: "Expert_15",
          id:15,
          desc: "desc",
          image: "https://picsum.photos/200/300?random=15",
          answer_speed: 0.00,
          rates: 3.5,
          isFavorite: false,
          expert_services: [ExpertService(points: 10)]),
    ];
    */
    _buildExperts(List<Expert> experts) {
      return StaggeredGrid.count(
          // padding: EdgeInsets.symmetric(horizontal: 10.0),
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: List.generate(experts.length, (index) {
            Expert expert = experts[index];

            return GestureDetector(
                onTap: () async {

                if (balance < expert.expert_services![0].points)
                  {
                    await ShowMessageDialog( context,
                        "Error",
                        "you dont have enough point");
                  }
                 else
                   {
                     var res = await service.saveWithValues(clientId: user.id as int,
                         expertId: expert.id as int,
                         serviceId: widget.serviceId,
                         imageInputServiceId:context.read<ServiceInputCubit>().state.imageInputServiceId ,
                         serviceValues:context.read<ServiceInputCubit>().state.serviceValues ,
                        audioFile: context.read<AudioFileCubit>().state.audioFile,
                         serviceImages: serviceImages
                     );
                     if(res?.message == "no balance")
                       {
                         await ShowMessageDialog( context,
                             "Error",
                             "you dont have enough point");
                       }
                     else
                       {
                         user = (await user.getUser(mobile: user!.mobile as String))!;
                         //global parameters
                         serviceImages = [null,null,null,null];
                         BlocProvider.of<AudioFileCubit>(context)
                             .loadAudioFile(null,null);
                         BlocProvider.of<ServiceInputCubit>(context)
                             .loadServiceValues(null,null,null);

                         Navigator.pushAndRemoveUntil(
                             context,
                             MaterialPageRoute(
                                 builder: (_) =>
                                     MainNavigationScreen()),
                                 (route) =>
                             route.settings.name ==
                                 '/mainNavigation');
                       }
                   }
                  setState(() {
                    balance = user.balance;
                    BlocProvider.of<UserInformationCubit>(context)
                        .addProfile(user);
                    // _selectedExpert = expert.expert_name!;
                    // print(_selectedExpert);
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
                          child:  Container(
                          height: (screenWidth - 65) / 2.5,
                          width: (screenWidth - 65) / 2,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child:Container(
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
                      // expert service point
                      PositionedDirectional(
                        top: 0,
                        end: 0,
                        child: ClipRRect(
                          borderRadius: BorderRadiusDirectional.only(
                              topEnd: Radius.circular(30.0),
                              bottomStart: Radius.circular(15.0)),
                          child: Container(
                            color: myprimercolor,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Text(
                                    expert.expert_services![0].points
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      // fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  SvgPicture.asset(
                                    "assets/svg/money.svg",
                                    color: Colors.white,
                                    width: 15,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      // expert info
                      PositionedDirectional(
                        top: 0,
                        start: 0,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: ((screenWidth - 65) / 2.5) - 15,
                          ),
                          child: GestureDetector(
                            onTap: () {},
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(90.0)),
                              child: Container(
                                height: 30,
                                width: 30,
                                color: mysecondarycolor,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: SvgPicture.asset(
                                    "assets/svg/info.svg",
                                    color: Colors.white,
                                    height: 30,
                                    width: 30,
                                    fit: BoxFit.fitHeight,
                                  ),
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
      //backgroundColor: const Color(0xff022440),
      body: Stack(children: [
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
                Row(
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
                      padding:  EdgeInsetsDirectional.only(start: 75),
                      child: Text(
                        "Experts",
                        style: TextStyle(
                          // fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.white),
                      ),
                    ),

                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(end: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(5),
                      backgroundColor: Colors.grey.shade50, // <-- Button color
                      // foregroundColor: Colors.red, // <-- Splash color
                    ),
                    onPressed: () {

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              PurchaseShop(),
                        ),
                      );

                    },
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
                        balance.toString(),
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
                  // expertList
                  !isLoadingExperts?
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                        child: _buildExperts(expertList!)),
                  ))
                  :Expanded(child: Center(child: CircularProgressIndicator())),

                  SizedBox(height: 10,)
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
