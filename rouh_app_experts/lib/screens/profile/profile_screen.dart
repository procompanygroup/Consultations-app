import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import '../../bloc/expert/expert_information_cubit.dart';
import '../../controllers/globalController.dart';
import '../../models/country.dart';
import '../../models/expert_model.dart';
import '../../models/service_model.dart';
import '../../mystyle/button_style.dart';
import '../../mystyle/constantsColors.dart';
import '../../components/rating_stars.dart';
import '../../components/record_and_play_screen.dart';
import '../login/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Expert expert = Expert();
  var image = File('');
  String imagePath = "";
  final picker = ImagePicker();
  bool uploading = false;

  late Country _selectedCountry = new Country(code: "",name: "", dialCode: "",flag: "");
  // late Country _selectedCountry;
  List<Country> listCountry = <Country>[];
  late String _selectedGender = "Male";


  @override
  void initState() {
    // TODO: implement initState
    Country.readJson().then((response) => {
      setState(() {
        listCountry = response;
        expert = context.read<ExpertInformationCubit>().state.fetchedExpert!;
        _selectedGender = expert.gender == 1?"Male":"Female";
        // _selectedCountry = listCountry.firstWhere((element) => element.name == expert.nationality);
        _selectedCountry = listCountry.first;

        imagePath = expert.image as String;
        image = File(imagePath);

        print(expert.expert_name);
        print(imagePath);
        print(expert.image);
      }),
    });


    super.initState();
    //




  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double bodyHeight = (MediaQuery.of(context).size.height //screen
        -MediaQuery.of(context).padding.top // safe area
        // -AppBar().preferredSize.height //AppBar
    );
    _buildServices(List<Service> services) {
      return Row(
          children: List.generate(services.length, (index) {
            Service service = services[index];
            return GestureDetector(
                onTap: () {
                  print(service.name);

                  // setState(() {
                  // _selectedService = service.id!;
                  // print(_selectedService);
                  // });
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
    return Scaffold(
      //backgroundColor: const Color(0xff022440),
      body: Stack(
          children: [
            //Top
            Stack(
              children: [
                Container(
                  height: bodyHeight * 0.30,
                  width: screenWidth,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25)),
                      gradient: LinearGradient(
                        colors: [Color(0xff015DAC), Color(0xff022440)],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      )),
                ),
              ],
            ),
            // Body
            Padding(
              padding: EdgeInsets.only(top: bodyHeight * 0.35),
              child: Container(
                width: screenWidth,
                height: bodyHeight * 0.80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                  // border: Border.all(color: Colors.grey),
                  // color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
                  child:  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child:   Column(
                            children: [

                              // expert_name
                              Text(expert.expert_name!,
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
                                            rating: expert.rates!, size: 20))),
                              ),
                              //answer_speed
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Spacer(),
                                  Text(expert.expert_name!,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade500),
                                  ),
                                  SizedBox(width: 5,),
                                  Text(expert.answer_speed!.toString(),
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: mysecondarycolor),
                                  ),
                                  Spacer(),

                                ],
                              ),

                              SizedBox(height: 10,),


                              //nationality
                              Directionality(
                                textDirection: TextDirection.ltr,
                                child: Stack(
                                  children: [
                                    Padding(
                                        padding:
                                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                                        child: Container(
                                          height: 50,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(25),
                                              border: Border.all(color: Colors.grey.shade300)),
                                          child: Padding(
                                            padding:  EdgeInsetsDirectional.only(start: 120,end: 10),
                                            child: Align(
                                                alignment: AlignmentDirectional.centerStart,
                                                child: Text(expert.mobile!,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color:  Colors.grey.shade400,
                                                  ),)),
                                          ),
                                        )),

                                    // icon number
                                    Positioned(
                                      bottom: 0,
                                      top: 0,
                                      //   left: 0,
                                      right: 0,
                                      //   child:
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          right: 25,
                                        ),
                                        child: Row(
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                              const EdgeInsets.symmetric(vertical: 15),
                                              child: VerticalDivider(
                                                // color: Colors.grey
                                                  color: Colors.grey.shade300),
                                            ),
                                            Container(
                                              width: 30,
                                              child: SvgPicture.asset(
                                                'assets/svg/mobile-phone-icon.svg',
                                                width: 50,
                                                height: 30,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // flag
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
                                    ),
                                    // code number
                                    Positioned(
                                      bottom: 0,
                                      top: 0,
                                      //   left: 0,
                                      left: 50,
                                      //   child:
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: 25,
                                        ),
                                        child: Container(
                                          width: 60,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                _selectedCountry.dialCode!,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13,
                                                    color: myprimercolor),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0, top: 15, right: 10, bottom: 15),
                                                child: VerticalDivider(
                                                  // color: Colors.grey
                                                    color: Colors.grey.shade300),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),


                              //email
                              Stack(
                                children: [
                                  Padding(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                                      child: Container(
                                        height: 50,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(25),
                                            border: Border.all(color: Colors.grey.shade300)),
                                        child: Padding(
                                          padding:  EdgeInsetsDirectional.only(start: 60,end: 10),
                                          child: Align(
                                              alignment: AlignmentDirectional.centerStart,
                                              child: Text(expert.email!,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color:  Colors.grey.shade400,
                                              ),)),
                                        ),
                                      )),
                                  Positioned(
                                    bottom: 0,
                                    top: 0,
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.only(
                                        start: 25,
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          SvgPicture.asset(
                                            'assets/svg/mail-icon.svg',
                                            width: 40,
                                            height: 20,
                                            color: Colors.grey.shade400,
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
                              ),
                              //desc
                              Padding(
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                                  child: Container(
                                    // height: 50,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(25),
                                        border: Border.all(color: Colors.grey.shade300)),
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                      child:  Padding(
                                        padding:  EdgeInsetsDirectional.all(5),
                                        child: Align(
                                            alignment: AlignmentDirectional.centerStart,
                                            child: Text(expert.desc!,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color:  Colors.grey.shade400,
                                              ),)),
                                      ),
                                    ),
                                  )),



                              // Experts Title
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                child: Align(
                                  alignment: AlignmentDirectional.centerStart,
                                  child: Text("الخبرات",
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
                                    child: _buildServices(expert.services! )),
                              ),
                              // Record Title
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                child: Align(
                                  alignment: AlignmentDirectional.center,
                                  child: Text("رسالة صوتية",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: myprimercolor),
                                  ),
                                ),
                              ),
                              // Record
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30.0, vertical: 5.0),
                                child: RecordAndPlayScreen(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Save
                      Container(
                        width: screenWidth,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                          child: Container(
                            width: screenWidth - 20 - 100  ,
                            height: 50,
                            child: BlocBuilder<ExpertInformationCubit,ExpertInformationState>(
                              builder:(context,state) {
                                return TextButton(
                                  style: bs_flatFill(
                                      context, myprimercolor),
                                  onPressed: () async {
                                      try {
                          
                                      }
                                      catch (e) {}
                                  },
                                  child: Text(
                                    'Save',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                );
                              },
                            ),
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
              height: bodyHeight * 0.35,
              width: screenWidth,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Stack(children: [
                  Container(
                    width: bodyHeight * 0.25,
                    height: bodyHeight * 0.25,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(150),
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
                      borderRadius: BorderRadius.circular(150),
                      child:
                      imagePath == ""
                          ? Image(
                        image:  NetworkImage(""),
                        fit: BoxFit.cover,
                        errorBuilder:
                            (BuildContext context, Object exception, StackTrace? stackTrace) {
                          return Image(
                            image: AssetImage("assets/images/default_image.png"),
                            fit: BoxFit.fitHeight,
                          );
                        },
                      )
                          : Image(
                        image: NetworkImage(imagePath),
                        fit: BoxFit.cover,
                        errorBuilder:
                            (BuildContext context, Object exception, StackTrace? stackTrace) {
                          return Image(
                            image: FileImage(image),
                            //image: AssetImage("assets/images/default_image.png"),
                            fit: BoxFit.fitHeight,
                          );
                        },
                      ),
                    ),
                  ),

                  Positioned(
                    right: 6,
                    bottom: 6,
                    child:
                    GestureDetector(
                      onTap: (){
                        getImagefromGallery();
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(150),
                            border: Border.all(color: Colors.grey.shade300, width: 3),
                            color: Colors.white),
                        child:Icon( Icons.camera_alt  ,
                          color: Colors.grey.shade300,
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

  getImagefromGallery() async {
    //final status = await ImagePicker();
    final pickedfile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedfile != null) {
      setState(() {
        image = File(pickedfile.path);
        imagePath = pickedfile.path;
        print(imagePath);
      });
      setState(() {
        uploading = true;
      });
    }
  }

//update profile function
  Future<String?> updateProfile() async {
    var imageFile = imagePath ==""? null : await MultipartFile.fromFile(
      imagePath,
    );

    FormData formData = FormData.fromMap({
      "id" : expert.id,
      "user_name": expert.expert_name,
      "email": expert.email,
      "gender": expert.gender,
      // "nationality": expert.nationality,
      "birthdate": expert.birthdate,
      "marital_status": expert.marital_status,
      'image':imageFile,
    });

    // String? res = await expert.Update(formData:formData );

    return "res";
  }
}
