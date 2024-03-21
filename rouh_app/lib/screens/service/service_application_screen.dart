import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rouh_app/models/service_input_model.dart';

import '../../bloc/UserInformation/user_information_cubit.dart';
import '../../bloc/audio_file/audio_file_cubit.dart';
import '../../bloc/service_inputs/service_input_cubit.dart';
import '../../constants/global_variable.dart';
import '../../controllers/converters.dart';
import '../../controllers/globalController.dart';
import '../../models/country.dart';
import '../../models/service_model.dart';
import '../../models/service_value_model.dart';
import '../../models/user_model.dart';
import '../../mystyle/button_style.dart';
import '../../mystyle/constantsColors.dart';
import '../../widgets/custom_image_picker.dart';
import '../../widgets/record_and_play_screen.dart';
import '../../widgets/show_dialog.dart';
import '../shop/purchase_shop_screen.dart';
import 'select_expert_screen.dart';

class ServiceApplicationScreen extends StatefulWidget {
  const ServiceApplicationScreen({super.key, required this.service});
  final Service service;

  @override
  State<ServiceApplicationScreen> createState() =>
      _ServiceApplicationScreenState();
}

class _ServiceApplicationScreenState extends State<ServiceApplicationScreen> {
  final _formKey = GlobalKey<FormState>();

  // List<Country> listCountry = <Country>[];
  Country _selectedCountry = new Country(code: "",name: "", dialCode: "",flag: "");

  // bool isLoading = true;
  bool hasRecordFile = false;
  int RecordInputServiceId = 0;
  int ImageInputServiceId = 0;
  int ImageCount = 0;

  bool hasImageFile = false;
  Service service = Service();
  List<ServiceInput> serviceInputs = <ServiceInput>[];
  List<ServiceValue> serviceValues = <ServiceValue>[];
  User user = User();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
/*
    Country.readJson().then((response) => {
      // print(response),
      setState(() {
        listCountry = response;
        _selectedCountry = listCountry[2];
      }),
      // print( listCountry[0].name)
    });
*/

    fillServiceInputList();
    serviceImages = [null, null, null, null];

    user = context.read<UserInformationCubit>().state.fetchedPerson!;
  }

  Future<void> fillServiceInputList() async {
    // print("start");
    // print(widget.serviceId);
    // await fillServiceInputApplicationList(widget.serviceId);
    // print("end");
    setState(() {
      serviceInputs = globalServiceInputsApplicationList;
      serviceValues = globalServiceValuesApplicationList;
      // isLoading = false;
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
  Widget buildForm(List<ServiceValue> _serviceValues) {



    List<Widget> inputsWidgetList = [];
    try{
    _serviceValues.forEach((ServiceValue serviceValue) {
      var serviceInput = serviceInputs
          .firstWhere((element) => element.id == serviceValue.inputservice_id);
      if (serviceInput.input?.type == 'record') {
        setState(() {
          hasRecordFile = true;
          RecordInputServiceId = serviceValue.inputservice_id!;
        });
      } else if (serviceInput.input?.type == 'image') {
        setState(() {
          hasImageFile = true;
          ImageInputServiceId = serviceValue.inputservice_id!;
          ImageCount = serviceInput.input!.imageCount!;
          print(ImageCount);
        });
      }

      inputsWidgetList.add(
        Builder(
          builder: (context) {

            if (serviceInput.input?.type == 'date' &&
                serviceValue.value == "") {
              serviceValue.value =
                  "${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}";
            }
            if (serviceInput.input?.type == 'bool' && serviceValue.value == "" )
              serviceValue.value = "False";
            if (serviceInput.input!.name! == "nationality")
               _selectedCountry = globalCountryList.first;

            if (serviceInput.input!.ispersonal!) {
              if (serviceInput.input!.name! == "user_name")
                serviceValue.value = user.user_name;
              else if (serviceInput.input!.name! == "mobile")
                serviceValue.value = user.mobile;
              else if (serviceInput.input!.name! == "nationality")
               { serviceValue.value = user.nationality;
               _selectedCountry = globalCountryList.where((element) => element.name == serviceValue.value).first;
               }
              else if (serviceInput.input!.name! == "birthdate")
                serviceValue.value = user.birthdate.toString();
              else if (serviceInput.input!.name! == "gender")
                serviceValue.value = user.gender.toString();
              else if (serviceInput.input!.name! == "marital_status")
                serviceValue.value = user.marital_status;
            }

            print(serviceValue.value);

            InputValues? inputValue;
            if (serviceInput.input?.type == 'list')
              {
                 inputValue = serviceInput.input!.inputValues!.where((element) =>element.value == serviceValue.value).firstOrNull;
              }

            if ( serviceInput.input!.name! == "nationality")
              return Stack(
                children: [
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: DropdownButtonFormField<Country>(
                      validator: (value) => value == null ? '' : null,
                      //isDense: true,
                      hint: Text('Choose'),
                      value: _selectedCountry,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      isExpanded: true,
                      style: TextStyle(color: Colors.grey),
                      // underline: Container(
                      //   height: 2,
                      //   color: Colors.grey,
                      // ),
                      onChanged: (Country? newValue) {
                        setState(() {
                          _selectedCountry = newValue!;
                          serviceValue.value = _selectedCountry.name;
                          print("_selectedCountry.flag :" + _selectedCountry.flag.toString());
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
                          // labelText: "Country",
                          hintText: "Country",
                          fillColor: Colors.grey.shade50),
                      items: globalCountryList
                          .map<DropdownMenuItem<Country>>((Country value) {
                        return DropdownMenuItem<Country>(
                          value: value,
                          child: Text(value.name!),
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
                          SizedBox(
                            width: 30,
                            height: 20,
                            child: SvgPicture.asset(
                              _selectedCountry.flag!,
                              fit: BoxFit.cover,
                            ),
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
            else if (serviceInput.input?.type == 'text')
              return Stack(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '';
                        }
                        return null;
                      },
                      initialValue: serviceValue.value,
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
                          // labelText: serviceValue.value,
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
                          serviceInput.input?.icon != null
                              ? Container(
                                  width: 30,
                                  height: 30,
                                  child: SvgPicture.network(
                                    serviceInput.input!.icon!,
                                    width: 30,
                                    height: 30,
                                    color: Colors.grey.shade300,
                                  ),
                                )
                              : Icon(
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
            else if (serviceInput.input?.type == 'date')
              return Stack(
                children: [
                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      child: Container(
                        height: 45,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: Colors.grey.shade300)),
                        child: InkWell(
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDate: serviceValue.value != "" ?  DateTime.parse(serviceValue.value.toString()) : DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100),
                            ).then((selectedDate) {
                              if (selectedDate != null) {
                                setState(() {
                                  final dateOnly =
                                      "${selectedDate.year}/${selectedDate.month}/${selectedDate.day}";
                                  serviceValue.value = dateOnly.toString();
                                });
                              }
                            });
                          },
                          child: Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Padding(
                              padding: const EdgeInsetsDirectional.only(
                                  start: 60, end: 10),
                              child: Text(
                                serviceValue.value != null
                                    ? ( serviceValue.value.toString().split(" ")[0])
                                    : serviceInput.input!.name!,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: serviceValue.value != null
                                        ? Colors.black54
                                        : Colors.grey),
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
                          serviceInput.input?.icon != null
                              ? Container(
                                  width: 30,
                                  height: 30,
                                  child: SvgPicture.network(
                                    serviceInput.input!.icon!,
                                    width: 30,
                                    height: 30,
                                    color: Colors.grey.shade300,
                                  ),
                                )
                              : Icon(
                                  Icons.date_range,
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
            else if (serviceInput.input?.type == 'list')
              return Stack(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: DropdownButtonFormField<InputValues>(
                      validator: (value) => value == null ? '' : null,
                      //isDense: true,
                      hint: Text('Choose'),
                      value:inputValue,
                      // value: serviceValue.value != "" ?  serviceValue.value.toString() : InputValues(),
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
                          hintText: serviceInput.input!.name!,
                          fillColor: Colors.grey.shade50),
                      items: serviceInput.input!.inputValues!
                          .map<DropdownMenuItem<InputValues>>(
                              (InputValues inputValues) {
                        return DropdownMenuItem<InputValues>(
                          value: inputValues,
                          // child: Text(inputValues.value!),
                          child: serviceInput.input!.name! == "gender" ?
                          Text(  converterGender( inputValues.value!))
                         :serviceInput.input!.name! == "marital_status" ?
                          Text(  converterMaritalStatus( inputValues.value!))
                         : Text(inputValues.value!),
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
                          serviceInput.input?.icon != null
                              ? Container(
                                  width: 30,
                                  height: 30,
                                  child: SvgPicture.network(
                                    serviceInput.input!.icon!,
                                    width: 30,
                                    height: 30,
                                    color: Colors.grey.shade300,
                                  ),
                                )
                              : Icon(
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
            else if (serviceInput.input?.type == 'bool')
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
            else if (serviceInput.input?.type == 'longtext')
              return Stack(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: TextFormField(
                      maxLines: 5,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
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
            else
              return SizedBox();
          },
        ),
      );
    });
    }
    catch(ex)
    {

    }
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
                          builder: (context) => PurchaseShop(),
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
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: bodyHeight * 0.1,
                    ),
                    Text(
                      widget.service.name!,
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
                              buildForm(serviceValues),
                              hasRecordFile
                                  ? Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(
                                            "Record Audio",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: myprimercolor),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 5.0),
                                          child: RecordAndPlayScreen(
                                              RecordInputServiceId:
                                                  RecordInputServiceId),
                                        ),
                                      ],
                                    )
                                  : SizedBox(),
                              hasImageFile
                                  ? Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(
                                            "Add Image",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: myprimercolor),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 5.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                  width:
                                                      (screenWidth - 100) / 4,
                                                  height:
                                                      (screenWidth - 100) / 4,
                                                  child: ImageCount > 0
                                                      ? CustomImagePicker(
                                                          ImageInputServiceId:
                                                              ImageInputServiceId,
                                                          index: 0,
                                                        )
                                                      : Container(
                                                          width: (screenWidth -
                                                                  100) /
                                                              4,
                                                          height: (screenWidth -
                                                                  100) /
                                                              4,
                                                          decoration:
                                                              BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade200,
                                                                      width: 1),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.03),
                                                                      spreadRadius:
                                                                          5,
                                                                      blurRadius:
                                                                          7,
                                                                      offset: Offset(
                                                                          0,
                                                                          3), // changes position of shadow
                                                                    ),
                                                                  ],
                                                                  color: Colors
                                                                      .grey
                                                                      .shade100),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            child: Image(
                                                              image: AssetImage(
                                                                  "assets/images/default_image.png"),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        )),
                                              Container(
                                                  width:
                                                      (screenWidth - 100) / 4,
                                                  height:
                                                      (screenWidth - 100) / 4,
                                                  child: ImageCount > 1
                                                      ? CustomImagePicker(
                                                          ImageInputServiceId:
                                                              ImageInputServiceId,
                                                          index: 1)
                                                      : Container(
                                                          width: (screenWidth -
                                                                  100) /
                                                              4,
                                                          height: (screenWidth -
                                                                  100) /
                                                              4,
                                                          decoration:
                                                              BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade200,
                                                                      width: 1),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.03),
                                                                      spreadRadius:
                                                                          5,
                                                                      blurRadius:
                                                                          7,
                                                                      offset: Offset(
                                                                          0,
                                                                          3), // changes position of shadow
                                                                    ),
                                                                  ],
                                                                  color: Colors
                                                                      .grey
                                                                      .shade100),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            child: Image(
                                                              image: AssetImage(
                                                                  "assets/images/default_image.png"),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        )),
                                              Container(
                                                  width:
                                                      (screenWidth - 100) / 4,
                                                  height:
                                                      (screenWidth - 100) / 4,
                                                  child: ImageCount > 2
                                                      ? CustomImagePicker(
                                                          ImageInputServiceId:
                                                              ImageInputServiceId,
                                                          index: 2)
                                                      : Container(
                                                          width: (screenWidth -
                                                                  100) /
                                                              4,
                                                          height: (screenWidth -
                                                                  100) /
                                                              4,
                                                          decoration:
                                                              BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade200,
                                                                      width: 1),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.03),
                                                                      spreadRadius:
                                                                          5,
                                                                      blurRadius:
                                                                          7,
                                                                      offset: Offset(
                                                                          0,
                                                                          3), // changes position of shadow
                                                                    ),
                                                                  ],
                                                                  color: Colors
                                                                      .grey
                                                                      .shade100),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            child: Image(
                                                              image: AssetImage(
                                                                  "assets/images/default_image.png"),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        )),
                                              Container(
                                                  width:
                                                      (screenWidth - 100) / 4,
                                                  height:
                                                      (screenWidth - 100) / 4,
                                                  child: ImageCount > 3
                                                      ? CustomImagePicker(
                                                          ImageInputServiceId:
                                                              ImageInputServiceId,
                                                          index: 3)
                                                      : Container(
                                                          width: (screenWidth -
                                                                  100) /
                                                              4,
                                                          height: (screenWidth -
                                                                  100) /
                                                              4,
                                                          decoration:
                                                              BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade200,
                                                                      width: 1),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.03),
                                                                      spreadRadius:
                                                                          5,
                                                                      blurRadius:
                                                                          7,
                                                                      offset: Offset(
                                                                          0,
                                                                          3), // changes position of shadow
                                                                    ),
                                                                  ],
                                                                  color: Colors
                                                                      .grey
                                                                      .shade100),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            child: Image(
                                                              image: AssetImage(
                                                                  "assets/images/default_image.png"),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        )),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50.0, vertical: 10.0),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        child:
                            BlocBuilder<ServiceInputCubit, ServiceInputState>(
                          builder: (context, state) {
                            return TextButton(
                              child: Text(
                                'Confirm',
                                style: TextStyle(fontSize: 18),
                              ),
                              style: bs_flatFill(context, myprimercolor),
                              onPressed: () async {
                                bool canSave = false;
                                if (_formKey.currentState!.validate()) {
                                  if (hasRecordFile) {
                                    var audio = context
                                        .read<AudioFileCubit>()
                                        .state
                                        .audioFile;
                                    if (audio != null) {
                                      canSave = true;
                                    } else {
                                      await   ShowMessageDialog(context, "تحذير",
                                          "التسجيل الصوتي مطلوب");
                                    }
                                  }
                                  if (hasImageFile && canSave) {
                                    for (var p in serviceImages ?? []) {
                                      if (p != null) {
                                        canSave = true;
                                        break;
                                      }
                                    }

                                    if (canSave == false) {
                                      await  ShowMessageDialog(context, "تحذير",
                                          "يجب ادخال صورة على الأقل");
                                    }
                                    //  var contain = serviceImages.contains( (element) => element != null);
                                    // // print(contain);
                                    //  if (contain == false)
                                    //    {
                                    //        canSave = false;
                                    //      //yasin
                                    //      //image is mandatory
                                    //    }
                                  }
                                  print(canSave);
                                  if (canSave) {
                                    BlocProvider.of<ServiceInputCubit>(context)
                                        .loadServiceValues(serviceInputs,
                                            serviceValues, ImageInputServiceId);

                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => SelectExpert(
                                            serviceId:
                                                widget.service.id as int),
                                      ),
                                    );
                                  }
                                }
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
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
                        NetworkImage(widget.service.image!),
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
