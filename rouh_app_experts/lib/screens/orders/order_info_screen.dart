import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/expert_order_model.dart';
import '../../mystyle/button_style.dart';
import '../../mystyle/constantsColors.dart';

class OrderInfoScreen extends StatefulWidget {
  const OrderInfoScreen({super.key, required this.expertOrder});

  final ExpertOrder expertOrder;

  @override
  State<OrderInfoScreen> createState() => _OrderInfoScreenState();
}

class _OrderInfoScreenState extends State<OrderInfoScreen> {
  bool hasRecordFile = false;
  bool hasImageFile = false;
  int ImageCount = 0;

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
    List<Widget> inputsWidgetList = [];
    _serviceValues.forEach((ServiceValue serviceValue) {
      // var serviceInput = serviceInputs
      //     .firstWhere((element) => element.id == serviceValue.inputservice_id);
   /*
      if (serviceValue.type == 'record') {
        setState(() {
          hasRecordFile = true;
          RecordInputServiceId = serviceValue.inputservice_id!;
        });
      } else if (serviceValue.type == 'image') {
        setState(() {
          hasImageFile = true;
          ImageInputServiceId = serviceValue.inputservice_id!;
          ImageCount = serviceInput.input!.imageCount!;
          print(ImageCount);
        });
      }
*/
      inputsWidgetList.add(
        Builder(
          builder: (context) {
          /*
            if (serviceValue.type == 'date' && serviceValue.value == "") {
              serviceValue.value =
                  "${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}";
            }

            if (serviceValue.type == 'bool' && serviceValue.value == "")
              serviceValue.value = "False";
            if (serviceInput.input!.name! == "nationality")
              _selectedCountry = globalCountryList.first;

            if (serviceInput.input!.ispersonal!) {
              if (serviceInput.input!.name! == "user_name")
                serviceValue.value = user.user_name;
              else if (serviceInput.input!.name! == "mobile")
                serviceValue.value = user.mobile;
              else if (serviceInput.input!.name! == "nationality") {
                serviceValue.value = user.nationality;
                _selectedCountry = globalCountryList
                    .where((element) => element.name == serviceValue.value)
                    .first;
              } else if (serviceInput.input!.name! == "birthdate")
                serviceValue.value = user.birthdate.toString();
              else if (serviceInput.input!.name! == "gender")
                serviceValue.value = user.gender.toString();
              else if (serviceInput.input!.name! == "marital_status")
                serviceValue.value = user.marital_status;
            }
            */

            print(serviceValue.value);

            if(serviceValue.type == 'text' || serviceValue.type == 'date' ||serviceValue.type == 'list'  )
              return Container();
            /*
            if (serviceValue.type == 'bool')
              return CheckboxListTile(
                title: Text(serviceInput.input!.name!,
                    style: TextStyle(
                        fontSize: 14,
                        color: serviceValue.value != null
                            ? Colors.black54
                            : Colors.grey)),
                value: serviceValue.value != null && serviceValue.value != ""
                    ? bool.parse(serviceValue.value!)
                    : false,
                onChanged: (newValue) {
                  setState(() {
                    serviceValue.value = newValue.toString();
                  });
                },
                controlAffinity:
                    ListTileControlAffinity.leading, //  <-- leading Checkbox
              );
            */
            // else if (serviceValue.type == 'longtext')
            else
              return SizedBox();
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
                    widget.expertOrder.client!.user_name!,
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
                            buildForm(widget.expertOrder.serviceValues!),

                          ],
                        )
                        // :Center(child: CircularProgressIndicator()),
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50.0, vertical: 10.0),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      child:  TextButton(
                            child: Text(
                              'Confirm',
                              style: TextStyle(fontSize: 18),
                            ),
                            style: bs_flatFill(context, myprimercolor),
                            onPressed: () {

                            },
                          )
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
                    image:
                        NetworkImage(widget.expertOrder.client!.image!),
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
              Positioned(
                right: 5,
                bottom: 5,
                child: Container(
                  //height: MediaQuery.of(context).size.height * 0.65,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    border: Border.all(color: Colors.grey.shade300, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Icon(
                      Icons.favorite,
                      color: mysecondarycolor,
                      size: 25,
                    ),
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
