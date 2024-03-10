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
import '../../mystyle/button_style.dart';
import '../../mystyle/constantsColors.dart';
import '../login/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
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
                  child:  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child:   Column(
                              children: [
                                //user_name
                                Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 5.0),
                                      child: TextFormField(
                                        autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                        validator: (value) {
                                          if (value!.isEmpty || value.length < 6) {
                                            return '';
                                          }
                                          return null;
                                        },
                                        controller: TextEditingController(text: expert.expert_name),
                                        // initialValue: user.user_name,
                                        onChanged: (value) {
                                          expert.expert_name = value;
                                        },
                                        decoration: InputDecoration(
                                          errorStyle:
                                          const TextStyle(fontSize: 0, height: 0),
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
                                          contentPadding:
                                          const EdgeInsetsDirectional.only(
                                              start: 70,
                                              top: 5,
                                              end: 60,
                                              bottom: 5),
                                          hintStyle: const TextStyle(
                                              color: Colors.grey, fontSize: 13),
                                          hintText: "UserName",
                                          fillColor: Colors.grey.shade50,
                                        ),
                                        keyboardType: TextInputType.text,
                                        // inputFormatters: [
                                        //   LengthLimitingTextInputFormatter(9)
                                        // ],
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      top: 0,
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.only(
                                          start: 25,
                                        ),
                                        child: Row(
                                          children: <Widget>[
                                            SvgPicture.asset(
                                              'assets/svg/profile.svg',
                                              width: 50,
                                              height: 30,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 15),
                                              child: VerticalDivider(
                                                // color: Colors.grey
                                                  color: Colors.grey.shade300),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                //email
                                Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 5.0),
                                      child: TextFormField(
                                        autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                        validator: (value) {
                                          if (value!.isEmpty || !value.contains('@')) {
                                            return '';
                                          }
                                          return null;
                                        },
                                        controller: TextEditingController(text: expert.email),
                                        // initialValue: user.email,
                                        onChanged: (value) {
                                          expert.email = value;
                                        },
                                        decoration: InputDecoration(
                                          //test the height
                                          errorStyle:
                                          const TextStyle(fontSize: 0, height: 0),

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
                                          contentPadding:
                                          const EdgeInsetsDirectional.only(
                                              start: 70,
                                              top: 5,
                                              end: 60,
                                              bottom: 5),
                                          hintStyle: const TextStyle(
                                              color: Colors.grey, fontSize: 13),
                                          hintText: "Email",
                                          fillColor: Colors.grey.shade50,
                                        ),
                                        keyboardType: TextInputType.emailAddress,
                                        // inputFormatters: [
                                        //   LengthLimitingTextInputFormatter(9)
                                        // ],
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      top: 0,
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.only(
                                          start: 25,
                                        ),
                                        child: Row(
                                          children: <Widget>[
                                            SvgPicture.asset(
                                              'assets/svg/mail-icon.svg',
                                              width: 40,
                                              height: 20,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 15),
                                              child: VerticalDivider(
                                                // color: Colors.grey
                                                  color: Colors.grey.shade300),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                //nationality
                                Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 5.0),
                                      child: DropdownButtonFormField<Country>(
                                        validator: (value) => value == null ? '' : null,
                                        //isDense: true,
                                        hint: const Text('Choose'),
                                        value: _selectedCountry,
                                        icon: const Icon(Icons.arrow_drop_down),
                                        iconSize: 24,
                                        elevation: 16,
                                        isExpanded: true,
                                        style: const TextStyle(color: Colors.grey),
                                        onChanged: (Country? newValue) {
                                          setState(() {
                                            _selectedCountry = newValue!;
                                            // expert.nationality = _selectedCountry.name;
                                          });
                                        },
                                        decoration: InputDecoration(
                                            errorStyle: const TextStyle(fontSize: 0),
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
                                            contentPadding:
                                            const EdgeInsetsDirectional.only(
                                                start: 60,
                                                top: 5,
                                                end: 10,
                                                bottom: 5),
                                            hintStyle:
                                            const TextStyle(color: Colors.grey),
                                            // labelText: "Country",
                                            hintText: "Country",
                                            fillColor: Colors.grey.shade50),
                                        items: listCountry
                                            .map<DropdownMenuItem<Country>>(
                                                (Country value) {
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
                                        padding: const EdgeInsetsDirectional.only(
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
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 15),
                                              child: VerticalDivider(
                                                // color: Colors.grey
                                                  color: Colors.grey.shade300),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                //birthdate
                                Stack(
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
                                                    expert.birthdate =selectedDate;
                                                  });
                                                }
                                              });
                                            },
                                            child: Align(
                                              alignment: AlignmentDirectional.centerStart,
                                              child: Padding(
                                                padding: const EdgeInsetsDirectional.only(start: 60, end: 10),
                                                child: Text(expert.birthdate != null?
                                                "${expert.birthdate!.year}/${expert.birthdate!.month}/${expert.birthdate!.day}"
                                                    :'birth date' ,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color:expert.birthdate != null? Colors.black54:Colors.grey
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
                                            Icon(
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
                                ),
                                //gender
                                Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 5.0),
                                      child: DropdownButtonFormField<String>(
                                        validator: (value) => value == null ? '' : null,
                                        //isDense: true,
                                        hint: const Text('Choose'),
                                        value: _selectedGender,
                                        icon: const Icon(Icons.arrow_drop_down),
                                        iconSize: 24,
                                        elevation: 16,
                                        isExpanded: true,
                                        style: const TextStyle(color: Colors.grey),
                                        // underline: Container(
                                        //   height: 2,
                                        //   color: Colors.grey,
                                        // ),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            _selectedGender = newValue!;
                                            expert.gender =
                                            _selectedGender == "Male" ? 1 : 2;
                                          });
                                        },
                                        decoration: InputDecoration(
                                            errorStyle: const TextStyle(fontSize: 0),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(25.0),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(25.0),
                                              borderSide: BorderSide(
                                                color: Colors.grey.shade300,
                                              ),
                                            ),
                                            filled: true,
                                            contentPadding:
                                            const EdgeInsetsDirectional.only(
                                                start: 60,
                                                top: 5,
                                                end: 10,
                                                bottom: 5),
                                            hintStyle:
                                            const TextStyle(color: Colors.grey),
                                            hintText: "Gender",
                                            fillColor: Colors.grey.shade50),
                                        items: globallistGender.map<DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      top: 0,
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.only(
                                          start: 25,
                                        ),
                                        child: Row(
                                          children: <Widget>[
                                            SvgPicture.asset(
                                              'assets/svg/male-and-female.svg',
                                              width: 40,
                                              height: 23,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 15),
                                              child: VerticalDivider(
                                                // color: Colors.grey
                                                  color: Colors.grey.shade300),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                //marital_status
                                Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 5.0),
                                      child: DropdownButtonFormField<String>(
                                        validator: (value) => value == null ? '' : null,
                                        //isDense: true,
                                        hint: const Text('Choose'),
                                        value: expert.marital_status,
                                        icon: const Icon(Icons.arrow_drop_down),
                                        iconSize: 24,
                                        elevation: 16,
                                        isExpanded: true,
                                        style: const TextStyle(color: Colors.grey),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            expert.marital_status = newValue!;
                                          });
                                        },
                                        decoration: InputDecoration(
                                            errorStyle: const TextStyle(fontSize: 0),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(25.0),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(25.0),
                                              borderSide: BorderSide(
                                                color: Colors.grey.shade300,
                                              ),
                                            ),
                                            filled: true,
                                            contentPadding:
                                            const EdgeInsetsDirectional.only(
                                                start: 60,
                                                top: 5,
                                                end: 10,
                                                bottom: 5),
                                            hintStyle:
                                            const TextStyle(color: Colors.grey),
                                            hintText: "marital status",
                                            fillColor: Colors.grey.shade50),
                                        items: globallistMaritalStatus
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      top: 0,
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.only(
                                          start: 25,
                                        ),
                                        child: Row(
                                          children: <Widget>[
                                            SvgPicture.asset(
                                              'assets/svg/interlocking-rings.svg',
                                              width: 40,
                                              height: 20,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 15),
                                              child: VerticalDivider(
                                                // color: Colors.grey
                                                  color: Colors.grey.shade300),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),

                              ],
                            ),
                          ),
                        ),
                        // Save
                        Container(
                          width: screenWidth,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: Row(
                              children: [
                                Container(
                                  width: screenWidth - 20 - 40  - 10 - 100,
                                  height: 50,
                                  child: BlocBuilder<ExpertInformationCubit,ExpertInformationState>(
                                    builder:(context,state) {
                                      return TextButton(
                                        style: bs_flatFill(
                                            context, myprimercolor),
                                        onPressed: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            try {
                                              await updateProfile();
                                              // expert = await expert.getExpert(mobile: expert.mobile as String) as Expert;
                                              BlocProvider.of<ExpertInformationCubit>(context)
                                                  .addProfile(expert!);
                                            }
                                            catch (e) {}
                                          }
                                        },
                                        child: Text(
                                          'Save',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Container(
                                  width: 100,
                                  height: 50,
                                  child:BlocBuilder<ExpertInformationCubit,ExpertInformationState>(
                                    builder:(context,state) {
                                      return TextButton(
                                        style: bs_flatFill(context, mysecondarycolor),
                                        onPressed: () async {
                                          try {
                                            // await expert.DeleteAccount(clientId: expert.id as int);
                                            BlocProvider.of<ExpertInformationCubit>(context)
                                                .addProfile(null);
                                            Navigator.of(context)
                                                .pushReplacement(MaterialPageRoute(
                                              builder: (context) => const LoginScreen(),
                                            ));
                                          }
                                          catch (e) {}
                                        },
                                        child: Icon(Icons.close,
                                          color: Colors.grey.shade300,
                                          size: 35,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
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
