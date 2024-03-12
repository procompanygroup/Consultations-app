import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rouh_app_experts/widgets/play_record_screen.dart';
import 'package:rouh_app_experts/widgets/view_image.dart';

import '../../bloc/audio_file/audio_file_cubit.dart';
import '../../controllers/globalController.dart';
import '../../models/expert_order_model.dart';
import '../../mystyle/button_style.dart';
import '../../mystyle/constantsColors.dart';
import '../../widgets/custom_image.dart';
import '../../widgets/record_and_play_screen.dart';

class OrderInfoScreen extends StatefulWidget {
  const OrderInfoScreen({super.key, required this.expertOrder});

  final ExpertOrder? expertOrder;

  @override
  State<OrderInfoScreen> createState() => _OrderInfoScreenState();
}

class _OrderInfoScreenState extends State<OrderInfoScreen> {
  bool hasRecordFile = false;
  String RecordPath = "";
  bool hasImageFile = false;
  int ImageCount = 0;
  List<String> serviceImages = ["", "", "", ""];

  // int RecordInputServiceId = 0;
  // int ImageInputServiceId = 0;

  // Service service = Service();
  // List<ServiceInput> serviceInputs = <ServiceInput>[];
  // List<ServiceValue> serviceValues = <ServiceValue>[];
  // User user = User();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /*
        fillServiceInputList();
    */
  }

/*
  Future<void> fillServiceInputList() async {
    setState(() {
      serviceInputs = globalServiceInputsApplicationList;
      serviceValues = globalServiceValuesApplicationList;
      // isLoading = false;
    });
  }
*/

  Widget buildForm(List<ServiceValue> _serviceValues) {
    List<Widget> iconWidgetList = [];
    List<Widget> titleWidgetList = [];
    List<Widget> valueWidgetList = [];
    _serviceValues.forEach((ServiceValue serviceValue) {
      if (serviceValue.type == 'record') {
        setState(() {
          hasRecordFile = true;
          RecordPath = serviceValue.value!;
        });
      } else if (serviceValue.type == 'image') {
        setState(() {
          hasImageFile = true;
          serviceImages[ImageCount] = serviceValue.value!;
          if(ImageCount<3)
            ImageCount++;
        });
      }
      iconWidgetList.add(
        Builder(
          builder: (context) {
            if (serviceValue.type == 'text' ||
                serviceValue.type == 'date' ||
                serviceValue.type == 'list' ||
                serviceValue.type == 'bool')
              return Container(
                height: 40,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: serviceValue.svgPath  != null
                      ? Container(
                          width: 30,
                          height: 30,
                          child: SvgPicture.network(
                            serviceValue.svgPath!,
                            width: 30,
                            height: 30,
                            color: Colors.grey.shade400,
                          ),
                        )
                      : Icon(
                          Icons.account_circle,
                          size: 30,
                          color: Colors.grey.shade400,
                        ),
                ),
              );
            else
              return SizedBox();
          },
        ),
      );
      titleWidgetList.add(
        Builder(
          builder: (context) {
            if (serviceValue.type == 'text' ||
                serviceValue.type == 'date' ||
                serviceValue.type == 'list' ||
                serviceValue.type == 'bool')
              return Container(
                height: 40,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    serviceValue.name!,
                    style: TextStyle(
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
              );
            else
              return SizedBox();
          },
        ),
      );
      valueWidgetList.add(
        Builder(
          builder: (context) {
            // print("serviceValue.type: " +  serviceValue.type!);
            // print("serviceValue.name: " +  serviceValue.name!);
            // print("serviceValue.value: " +  serviceValue.value!);
            // print(boolToTextConverter(bool.parse(serviceValue.value!)));
            if (serviceValue.type == 'text' ||
                serviceValue.type == 'date' ||
                serviceValue.type == 'list')
              return Container(
                height: 40,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    serviceValue.value!,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              );
            else if (serviceValue.type == 'bool')
              return Container(
                height: 40,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  // boolToTextConverter(bool.parse(serviceValue.value!)
                  child: Text(
                    boolToTextConverter(serviceValue.value!),
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              );
            else
              return SizedBox();
          },
        ),
      );
    });
    // return Column(
    //   children: inputsWidgetList,
    // );

    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: iconWidgetList,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: titleWidgetList,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: valueWidgetList,
        ),
      ],
    );
  }

  Widget buildFormLongtext(List<ServiceValue> _serviceValues, double _width) {
    List<Widget> inputsWidgetList = [];
    _serviceValues.forEach((ServiceValue serviceValue) {
      inputsWidgetList.add(
        Builder(
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Container(
                width: _width,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade200, width: 1),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey.shade50,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      serviceValue.value!,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
    return Column(
      children: inputsWidgetList,
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
                children: [
                  SizedBox(
                    height: bodyHeight * 0.1,
                  ),
                  Text(
                    widget.expertOrder!.client!.user_name!,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: mysecondarycolor),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child:
                            // !isLoading?
                            Column(
                          children: [
                            hasRecordFile
                                ? Column(
                                    children: [
                                      // record title
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 5),
                                        child: Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(25)),
                                                color: mysecondarycolor,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(7.5),
                                                child: SvgPicture.asset(
                                                  "assets/svg/microphone-icon.svg",
                                                  width: 12.5,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5, vertical: 5),
                                              child: Text(
                                                "الرسالة الصوتية",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: myprimercolor),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30.0, vertical: 5.0),
                                        child: PlayRecordScreen(
                                            audioUrl: RecordPath),
                                      ),
                                    ],
                                  )
                                : SizedBox(),

                            // Form title
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25)),
                                          color: mysecondarycolor,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(7.5),
                                          child: SvgPicture.asset(
                                            "assets/svg/mail-icon.svg",
                                            width: 12.5,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 5),
                                        child: Text(
                                          "معلومات الطلب",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: myprimercolor),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Text(
                                      widget.expertOrder!.orderDate!
                                          .toString()
                                          .split(" ")[0],
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // form
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Container(
                                width: screenWidth - 70,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey.shade200, width: 1),
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey.shade50,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: buildForm(
                                      widget.expertOrder!.serviceValues!),
                                ),
                              ),
                            ),

                            // form longtext
                            buildFormLongtext(
                                widget.expertOrder!.serviceValues!
                                    .where(
                                        (element) => element.type == 'longtext')
                                    .toList(),
                                (screenWidth - 70)),

                            hasImageFile
                                ? Column(
                                    children: [
                                      // image title
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 5),
                                        child: Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.all(Radius.circular(25)),
                                                color: mysecondarycolor,
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(7.5),
                                                child: SvgPicture.asset(
                                                  "assets/svg/camera-icon.svg",
                                                  width: 12.5,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 5, vertical: 5),
                                              child: Text(
                                                "الصور",
                                                style: TextStyle(
                                                    fontSize: 16, color: myprimercolor),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 25.0, vertical: 5.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: () async {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ViewImage( imagePath: serviceImages[0],),
                                                    ),
                                                  );
                                              },
                                              child: Container(
                                                width: (screenWidth - 130) / 4,
                                                height: (screenWidth - 130) / 4,
                                                child:
                                                CustomImage(url: serviceImages[0],
                                                  height: (screenWidth - 130) / 4, width: (screenWidth - 130) / 4,
                                                  radius: 20,
                                                  borderColor:  Colors.grey.shade200,
                                                  borderWidth:  1,
                                                ),

                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ViewImage( imagePath: serviceImages[1],),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                width: (screenWidth - 130) / 4,
                                                height: (screenWidth - 130) / 4,
                                                child:
                                                CustomImage(url: serviceImages[1],
                                                  height: (screenWidth - 130) / 4, width: (screenWidth - 130) / 4,
                                                  radius: 20,
                                                  borderColor:  Colors.grey.shade200,
                                                  borderWidth:  1,
                                                ),

                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ViewImage( imagePath: serviceImages[2],),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                width: (screenWidth - 130) / 4,
                                                height: (screenWidth - 130) / 4,
                                                child:
                                                CustomImage(url: serviceImages[2],
                                                  height: (screenWidth - 130) / 4, width: (screenWidth - 130) / 4,
                                                  radius: 20,
                                                  borderColor:  Colors.grey.shade200,
                                                  borderWidth:  1,
                                                ),

                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ViewImage( imagePath: serviceImages[3],),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                width: (screenWidth - 130) / 4,
                                                height: (screenWidth - 130) / 4,
                                                child:
                                                CustomImage(url: serviceImages[3],
                                                  height: (screenWidth - 130) / 4, width: (screenWidth - 130) / 4,
                                                  radius: 20,
                                                  borderColor:  Colors.grey.shade200,
                                                  borderWidth:  1,
                                                ),

                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                : SizedBox(),

                          ],
                        )
                        // :Center(child: CircularProgressIndicator()),
                        ),
                  ),
                  // record response title
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 5),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.circular(25)),
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          child: Text(
                            "رد الخبير",
                            style: TextStyle(
                                fontSize: 16, color: myprimercolor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 5.0),
                    child: RecordAndPlayScreen(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50.0, vertical: 10.0),
                    child: Container(
                        width: double.infinity,
                        height: 50,
                        child: TextButton(
                          child: Text(
                            'إرسال',
                            style: TextStyle(fontSize: 18),
                          ),
                          style: bs_flatFill(context, myprimercolor),
                          onPressed: () async {
                            var order = ExpertOrder();
                              var res = await order.UploadAnswer(selectedServiceId: widget.expertOrder!.selectedServiceId!,
                                  audioFile: context.read<AudioFileCubit>().state.audioFile!);
                            //after save
                            if(res == 1) {
                              BlocProvider.of<AudioFileCubit>(context)
                                  .loadAudioFile(null);
                              //yasin
                            }
                          },
                        )),
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
                    image: NetworkImage(widget.expertOrder!.client!.image!),
                    fit: BoxFit.cover,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return Image(
                        image: AssetImage("assets/images/default_image.png"),
                        fit: BoxFit.fitHeight,
                      );
                    },
                  ),
                ),
              ),
            ]),
          ),
        ),
      ]),
    );
  }
}
