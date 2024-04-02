import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rouh_app/screens/experts/expert_info_screen.dart';

import '../../bloc/UserInformation/user_information_cubit.dart';
import '../../controllers/globalController.dart';
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
  // bool isLoading = false;
  bool isLoadingFavorite = false;
  bool isLoadingExperts = false;
  bool isLoadingService = false;
  bool isLoadingExpertInfo = false;

  bool isFavoriteSearch = false;

  int _selectedService = 0;
  List<Service> serviceList = <Service>[];
  int _selectedExpert = 0;
  List<Expert> expertList = <Expert>[];
  int clientId = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    clientId = context.read<UserInformationCubit>().state.fetchedPerson!.id!;

    fillServiceList();
    print("clientId: " + clientId.toString());
    fillExpertList(clientId!);
  }

  Future<void> fillServiceList() async {
    getGlobalServiceWithoutCallWithAllList().then((response) {
      setState(() {
        isLoadingService = true;
        print(response);
        serviceList = response;

        if (serviceList.isNotEmpty) _selectedService = serviceList[0].id!;

        isLoadingService = false;
      });
    });
  }

  Future<void> fillExpertList(int clientId) async {
    getGlobalExpertWithFavoriteList(clientId).then((response) {
      setState(() {
        isLoadingExperts = true;
        print(response);
        expertList = response;

        if (expertList.isNotEmpty) _selectedExpert = expertList[0].id!;

        isLoadingExperts = false;
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

    //GetByServiceId
    _buildServices(List<Service> services) {
      List<Widget> serviceWidgetList = [];
      services.forEach((Service service) {
        serviceWidgetList.add(
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedService = service.id!;
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
                            color: _selectedService == service.id
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
      var listWidget = <Widget>[];
      List.generate(experts.length, (index) {
        Expert expert = experts[index];
        if (_selectedService == 0 ||
            expert.services!
                    .where((element) => element.id == _selectedService)
                    .length >
                0)
          listWidget.add(
              GestureDetector(
              onTap: () async {

                setState(() {
                  isLoadingExpertInfo = true;
                });
                var expertInfo =  await globalExpert.GetExpertWithComments(expertId: expert.id!);
                print("expertInfo != null:" + (expertInfo != null).toString());
                setState(() {
                  isLoadingExpertInfo = false;
                });

                if(expertInfo != null)
                {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          ExpertInfo(expert: expertInfo),
                    ),
                  );
                }








              },
              child:
              Container(
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
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace) {
                                return Image(
                                  image: AssetImage(
                                      "assets/images/default_image.png"),
                                  fit: BoxFit.cover,
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
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(35),
                            bottomLeft: Radius.circular(35)),
                        child: Container(
                          height: (screenWidth - 65) / 2.5,
                          width: (screenWidth - 65) / 2,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              color: Colors.black.withOpacity(0.35),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "Response " +
                                          expert.answer_speed!.toString(),
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
                          if(!isLoadingFavorite)
                            {

                          setState(() {
                            isLoadingFavorite = true;
                          });
                          bool newfavoriteState =
                              expert.isFavorite! ? false : true;

                          globalExpert.SaveFavorite(
                            clientId: clientId,
                            expertId: expert.id!,
                            isFavorite: newfavoriteState,
                          ).then((value) => {
                                setState(() {
                                  expert.isFavorite = newfavoriteState;
                                  isLoadingFavorite = false;
                                })
                              });
                            }

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
              )
              ))
        ;
      });
      return StaggeredGrid.count(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: listWidget);
    }

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              // Top
              Container(
                height: bodyHeight * 0.20,
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
                          Container(
                            width: screenWidth,
                            height: (bodyHeight * 0.20) - 50, // service list,
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
                                    isFavoriteSearch
                                        ? Icons.favorite
                                        : Icons.favorite_border,
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
                                  onPressed: () {
                                    setState(() {
                                      isFavoriteSearch = !isFavoriteSearch;
                                    });
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
                    child: _buildExperts(isFavoriteSearch
                        ? expertList!
                            .where((element) => element.isFavorite!)
                            .toList()
                        : expertList!)),
              )),
              SizedBox(
                height: 10,
              ),
            ],
          ),
          if (isLoadingService || isLoadingExperts || isLoadingFavorite || isLoadingExpertInfo)
            Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
