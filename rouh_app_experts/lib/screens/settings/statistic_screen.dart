import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../bloc/expert/expert_information_cubit.dart';
import '../../components/rating_stars.dart';
import '../../controllers/globalController.dart';
import '../../models/statistic_model.dart';
import '../../mystyle/constantsColors.dart';
import '../../components/custom_appbar.dart';

class StatisticScreen extends StatefulWidget {
  const StatisticScreen({super.key});

  @override
  State<StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  StatisticModel statistic = StatisticModel(answerSpeed: 0, serviceStatistics: <ServiceStatistics>[]);
  bool isLoadingStatistic = true;
  int expertId = 0;

  @override
  void initState() {

    // TODO: implement initState
    super.initState();

    print('Start initState');
    expertId = context.read<ExpertInformationCubit>().state.fetchedExpert!.id!;
    print('expertId');
    print(expertId);
    fillStatisticList();


  }

  Future<void> fillStatisticList() async {

    try{

      print('Start fillStatisticList');
      globalStatistic.GetStatistics(expertId: expertId )
          .then((response) {
        setState(() {
          isLoadingStatistic = true;
          print(response);
          statistic = response;

          isLoadingStatistic = false;
        });
      });

    } catch (err) {
      setState(() {
        isLoadingStatistic = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(err.toString()),
          )
      );
    }


  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double bodyHeight = (MediaQuery.of(context).size.height //screen
        // - MediaQuery.of(context).padding.top // safe area
        // - AppBar().preferredSize.height //AppBar
    );

    _buildServiceStatistics(List<ServiceStatistics> serviceStatistics) {
      return Column(
          children: List.generate(serviceStatistics.length, (index) {
            var _width = screenWidth - 85;
            ServiceStatistics serviceStatistic = serviceStatistics[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // crossAxisAlignment: CrossAxisAlignment.,
                  children: [
                    Container(
                      width: _width / 3 ,
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                        width: 60,
                        height: 45,
                        decoration: BoxDecoration(
                          border: Border.all(color: mysecondarycolor,width: 1),
                          borderRadius: BorderRadius.circular(15),
                          // color: mysecondarycolor,
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            children: [
                              serviceStatistic.icon != null?
                              Container(
                                width: 20,
                                height: 20,
                                child: SvgPicture.network(
                                  serviceStatistic.icon!,
                                  width: 20,
                                  height: 20,
                                  color: mysecondarycolor,
                                ),
                              )
                                  : Icon(
                                Icons.account_circle,
                                size: 20,
                                color: mysecondarycolor,
                              ),
                              Expanded(
                                child: Text(
                                  serviceStatistic.name!.toString(),
                                  style: TextStyle(
                                    fontSize: 8,
                                    color: Colors.grey.shade400,
                                    // fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                                        ),
                      ),
                    ),
                    Container(height: 25,
                        child: VerticalDivider(color:  Colors.grey.shade200,)),
                    Container(
                      width: _width / 3 ,
                      child: Align(
                        alignment: Alignment.center,
                        child: RatingStars(size: 15,
                          rating: serviceStatistic!.rate!,),
                      ),
                    ),
                    Container(height: 25,
                        child: VerticalDivider(color:  Colors.grey.shade200,)),
                    Container(
                      width: _width / 3 ,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          serviceStatistic.comment!,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade500,
                            // fontWeight: FontWeight.bold
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
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // top
          const CustomAppBar(title: "الإحصائيات"),
          // Body
          Padding(
            padding: EdgeInsets.only(top: bodyHeight * 0.20),
            child: Container(
              height: bodyHeight * 0.80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
                border: Border.all(color: Colors.grey),
                color: Colors.white,
              ),
              child: Padding(
                padding:
                EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: bodyHeight*0.1,
                    ),
                    // answerSpeed
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'معدل سرعة الرد: ',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey.shade500,
                              // fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            statistic!.answerSpeed!.toString(),
                            style: TextStyle(
                              fontSize: 18,
                              color: mysecondarycolor,
                              // fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only(left: 20,top: 20, right: 20, bottom: 0.0),
                      child: Divider(color: Colors.grey.shade200),
                    ),
                    // statistic header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // crossAxisAlignment: CrossAxisAlignment.,
                      children: [
                        Text(
                          'الخدمة',
                          style: TextStyle(
                            fontSize: 18,
                            color: myprimercolor,
                            // fontWeight: FontWeight.bold
                          ),
                        ),
                        Container(height: 25,
                            child: VerticalDivider(color:  Colors.grey.shade200,)),
                        Text(
                          'التقييم',
                          style: TextStyle(
                            fontSize: 18,
                            color: myprimercolor,
                            // fontWeight: FontWeight.bold
                          ),
                        ),
                        Container(height: 25,
                            child: VerticalDivider(color:  Colors.grey.shade200,)),
                        Text(
                          'التعليق',
                          style: TextStyle(
                            fontSize: 18,
                            color: myprimercolor,
                            // fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only(left: 20,top: 20, right: 20, bottom: 0.0),
                      child: Divider(color: Colors.grey.shade200),
                    ),
                    // ServiceStatistics
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: _buildServiceStatistics(statistic.serviceStatistics!)),
                      ),
                    ),
              
                  ],
                ),
              ),
            ),
          ),

          if ( isLoadingStatistic)
            Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
