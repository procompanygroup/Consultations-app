import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rouh_app/models/service_input_model.dart';

import '../../controllers/globalController.dart';
import '../../models/service_model.dart';
import '../../models/service_value_model.dart';
import '../../mystyle/button_style.dart';
import '../../mystyle/constantsColors.dart';
import '../../widgets/record_and_play_screen.dart';


class ServiceApplicationScreen extends StatefulWidget {

  const ServiceApplicationScreen({super.key, required this.serviceId});
  final int serviceId;

  @override
  State<ServiceApplicationScreen> createState() => _ServiceApplicationScreenState();
}

class _ServiceApplicationScreenState extends State<ServiceApplicationScreen> {
  bool isLoading = true;
  bool hasRecordFile = false;
  bool hasImageFile = false;
  Service service = Service();
  List<ServiceInput> serviceInputs = <ServiceInput>[];
  List<ServiceValue> serviceValues = <ServiceValue>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fillServiceInputList();

  }

  Future<void> fillServiceInputList() async {
    print("start");
    await fillServiceInputApplicationList(widget.serviceId);
    print("end");
    setState(() {
      serviceInputs = globalServiceInputsApplicationList;
      serviceValues = globalServiceValuesApplicationList;
      isLoading = false;
    });
    /*
    var serviceInput = await service.getServiceInputs(serviceId: 1);
    serviceInputs = serviceInput!.serviceInputs!;
    // print(serviceInputs![0].id);

    ServiceValue serviceValue = ServiceValue();
    // var serviceValues = await serviceValue.generateInputValues(serviceInputs:serviceInput.serviceInputs);
    serviceValue
        .generateInputValues(serviceInputs: serviceInput.serviceInputs)
        .then((responce) => {
              setState(() {
                serviceValues = responce;
                isLoading = false;
                print("Test:" + isLoading.toString());
              })
            });

    print(serviceValues![0].inputservice_id);
*/
  }
  // Widget buildForm(List<ServiceInput> _serviceInputs, List<ServiceValue> _serviceValues)
  Widget buildForm(List<ServiceValue> _serviceValues)
  {
    List<Widget> inputsWidgetList = [];
    _serviceValues.forEach((ServiceValue serviceValue) {
      var serviceInput = serviceInputs.firstWhere((element) => element.id ==serviceValue.inputservice_id);
      if(serviceInput.input?.type == 'record') {
        setState(() {
          hasRecordFile = true;
        });
      } else if(serviceInput.input?.type == 'image') {
        setState(() {
          hasImageFile = true;
        });
      }

      inputsWidgetList.add(
        Builder(
          builder: (context) {

            if(serviceInput.input?.type == 'text')
              return  Stack(
          children: [
            Padding(
              padding:
              EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child:TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ) {
                      return '';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    serviceValue.value = value;
                    // print(serviceValue.value);
                  },
                  decoration: InputDecoration(
                      errorStyle: TextStyle(fontSize: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                          // width: 2.0,
                        ),
                      ),
                      filled: true,
                      // contentPadding: EdgeInsetsDirectional.only( start: 60, top: 15, end: 15, bottom: 15,),
                      contentPadding: EdgeInsetsDirectional.only(
                          start: 60, top: 5, end: 10, bottom: 5),
                      hintStyle: TextStyle(color: Colors.grey),
                      // labelText: "Country",
                      hintText: serviceInput.input?.name,
                      fillColor: Colors.grey.shade50),

                ),
            ),
            Positioned(
              bottom: 0,
              top: 0,
              child: Padding(
                padding: EdgeInsetsDirectional.only(
                  start: 25,
                ),
                child: Row(
                  children: <Widget>[
                    serviceInput.input?.icon != null?
                    Container(
                      width: 30,
                      height: 30,
                      child: SvgPicture.network(
                        serviceInput.input!.icon!,
                        width: 30,
                        height: 30,
                        color: Colors.grey.shade300,
                      ),
                    )
                   :Icon(
                  Icons.account_circle,
                      size: 30,
                      color: Colors.grey.shade300,
                  ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: VerticalDivider(
                        // color: Colors.grey
                          color: Colors.grey.shade300),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
            else if(serviceInput.input?.type == 'date')
              return Stack(
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      child: Container(
                        height: 45,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                                color: Colors.grey.shade300)),
                        child: InkWell(
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100),
                            ).then((selectedDate) {
                              if (selectedDate != null) {
                                setState(() {
                                  final dateOnly =
                                      "${selectedDate.year}/${selectedDate.month}/${selectedDate.day}";
                                  serviceValue.value =
                                      dateOnly.toString();
                                });
                              }
                            });
                          },
                          child: Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Padding(
                              padding: const EdgeInsetsDirectional.only(start: 60, end: 10),
                              child: Text(serviceValue.value != null?
                                  serviceValue.value.toString()
                                  :serviceInput.input!.name! ,
                              style: TextStyle(
                                fontSize: 14,
                                 color:serviceValue.value != null? Colors.black54:Colors.grey
                              ),
                              ),
                            ),
                          ),
                        ),
                      )),
                  Positioned(
                    bottom: 0,
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(
                          end: 20,
                        ),
                        child: Icon(
                          Icons.arrow_drop_down,
                          size: 25,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    top: 0,
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(
                        start: 25,
                      ),
                      child: Row(
                        children: <Widget>[
                          serviceInput.input?.icon != null?
                          Container(
                            width: 30,
                            height: 30,
                            child: SvgPicture.network(
                              serviceInput.input!.icon!,
                              width: 30,
                              height: 30,
                              color: Colors.grey.shade300,
                            ),
                          )
                              :Icon(
                            Icons.account_circle,
                            size: 30,
                            color: Colors.grey.shade300,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: VerticalDivider(
                              // color: Colors.grey
                                color: Colors.grey.shade300),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            else if(serviceInput.input?.type == 'list')
              return Stack(
                children: [
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: DropdownButtonFormField<InputValues>(
                      validator: (value) => value == null ? '' : null,
                      //isDense: true,
                      hint: Text('Choose'),
                      // value: _selectedCountry,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      isExpanded: true,
                      style: TextStyle(color: Colors.grey),
                      // underline: Container(
                      //   height: 2,
                      //   color: Colors.grey,
                      // ),
                      onChanged: (InputValues? newValue) {
                        setState(() {
                          serviceValue.value = newValue!.value;
                        });
                      },
                      decoration: InputDecoration(
                          errorStyle: TextStyle(fontSize: 0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                              // width: 2.0,
                            ),
                          ),
                          filled: true,
                          // contentPadding: EdgeInsetsDirectional.only( start: 60, top: 15, end: 15, bottom: 15,),
                          contentPadding: EdgeInsetsDirectional.only(
                              start: 60, top: 5, end: 10, bottom: 5),
                          hintStyle: TextStyle(color: Colors.grey),
                          hintText: "Country",
                          fillColor: Colors.grey.shade50),
                      items: serviceInput.input!.inputValues!
                          .map<DropdownMenuItem<InputValues>>((InputValues inputValues) {
                        return DropdownMenuItem<InputValues>(
                          value: inputValues,
                          child: Text(inputValues.value!),
                        );
                      }).toList(),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    top: 0,
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(
                        start: 25,
                      ),
                      child: Row(
                        children: <Widget>[
                          serviceInput.input?.icon != null?
                          Container(
                            width: 30,
                            height: 30,
                            child: SvgPicture.network(
                              serviceInput.input!.icon!,
                              width: 30,
                              height: 30,
                              color: Colors.grey.shade300,
                            ),
                          )
                              :Icon(
                            Icons.account_circle,
                            size: 30,
                            color: Colors.grey.shade300,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: VerticalDivider(
                              // color: Colors.grey
                                color: Colors.grey.shade300),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            else if(serviceInput.input?.type == 'bool')
            return CheckboxListTile(
              title: Text(serviceInput.input!.name!,
            style: TextStyle(
            fontSize: 14,
            color:serviceValue.value != null? Colors.black54:Colors.grey
              )),
              value:serviceValue.value != null? bool.parse(serviceValue.value!): false,
              onChanged: (newValue) {
                setState(() {
                  serviceValue.value = newValue.toString();
                });
              },
              controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
            );
            else if(serviceInput.input?.type == 'longtext')
              return  Stack(
                children: [
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child:TextFormField(
                      maxLines: 5,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ) {
                          return '';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        serviceValue.value = value;
                        // print(serviceValue.value);
                      },
                      decoration: InputDecoration(
                          errorStyle: TextStyle(fontSize: 0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                              // width: 2.0,
                            ),
                          ),
                          filled: true,
                          // contentPadding: EdgeInsetsDirectional.only( start: 60, top: 15, end: 15, bottom: 15,),
                          contentPadding: EdgeInsetsDirectional.only(
                              start: 20, top: 10, end: 20, bottom: 10),
                          hintStyle: TextStyle(color: Colors.grey),
                          // labelText: "Country",
                          hintText: serviceInput.input?.name,
                          fillColor: Colors.grey.shade50),
                    ),
                  ),
                ],
              );
            else return SizedBox();
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
        -AppBar().preferredSize.height //AppBar
    );

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
                padding: EdgeInsetsDirectional.only(end: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(5),
                    backgroundColor:
                    Colors.grey.shade50, // <-- Button color
                    // foregroundColor: Colors.red, // <-- Splash color
                  ),
                  onPressed: () {},
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
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
                border: Border.all(color: Colors.grey),
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
                child: Column(
                  children: [
                    SizedBox(height:bodyHeight*0.1 ,),
                    Text("Service Name",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: mysecondarycolor),
                    ),

                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child:
                        !isLoading?
                        Column(
                          children: [
                            buildForm(serviceValues),
                            hasRecordFile?Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Text("Record Audio",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: myprimercolor),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                                  child: RecordAndPlayScreen(),
                                ),
                              ],
                            ):SizedBox(),
                            hasImageFile?Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Text("Add Image",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: myprimercolor),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          width: (screenWidth -100) / 4,
                                          height: (screenWidth -100) / 4,
                                          child: ImagePicker()),
                                      Container(
                                          width: (screenWidth -100) / 4,
                                          height: (screenWidth -100) / 4,
                                          child: ImagePicker()),
                                      Container(
                                          width: (screenWidth -100) / 4,
                                          height: (screenWidth -100) / 4,
                                          child: ImagePicker()),
                                      Container(
                                          width: (screenWidth -100) / 4,
                                          height: (screenWidth -100) / 4,
                                          child: ImagePicker()),
                                    ],
                                  ),
                                ),
                              ],
                            ):SizedBox(),
                          ],
                        )
                        :Center(child: CircularProgressIndicator()),
                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50.0, vertical: 10.0),
                      child: Container(
                        width: double.infinity,
                        child: TextButton(
                          child: Padding(
                            padding:
                            const EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              'Confirm',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          style: bs_flatFill(context),
                          onPressed: () async {
                            serviceInputs.forEach((element) {
                              print(element.input?.icon != null? true:false);
                            });

                          },
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
                      image:const DecorationImage(
                          image: NetworkImage("https://picsum.photos/200/300?random=4"),
                        fit: BoxFit.cover,
                      ),
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
                ),
                Positioned(
                  right: 5,
                  bottom: 5,
                  child:
                  Container(
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
                      child: Icon(Icons.favorite,
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


class ImagePicker extends StatefulWidget {
  const ImagePicker({super.key});

  @override
  State<ImagePicker> createState() => _ImagePickerState();
}
class _ImagePickerState extends State<ImagePicker> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    String imagePath = "";
    return GestureDetector(
      onTap: () {
        print("pick image here");
      },
      child: Container(
        height: screenWidth,
        width: screenWidth,
        child: Stack(
                    children: [
        imagePath == ""?
        // background icon
        Container(
          decoration:  BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade200, width: 1),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.black.withOpacity(0.03),
              //     spreadRadius: 5,
              //     blurRadius: 7,
              //     offset: Offset(0, 3), // changes position of shadow
              //   ),
              // ],
              color: Colors.grey.shade100
          ),
          child: Positioned(
            left: 0,
            top: 0,
            right: 0,
            bottom: 0,
            child: Center(
              child: SvgPicture.asset(
                'assets/svg/plus-icon.svg',
                height: 35,
                width: 35,
                fit: BoxFit.cover,
                color: Colors.grey.shade400,
                // color: Colors.red,
              ),
            ),
          ),
        )
        :Container(
          width: screenWidth,
          height: screenWidth,
          decoration: BoxDecoration(
              image:const DecorationImage(
                image: NetworkImage("https://picsum.photos/200/300?random=4"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade200, width: 1),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.black.withOpacity(0.03),
              //     spreadRadius: 5,
              //     blurRadius: 7,
              //     offset: Offset(0, 3), // changes position of shadow
              //   ),
              // ],
              color: Colors.grey.shade100
              ),
        ),
                    ],
                  ),
      ),
    );
  }
}

