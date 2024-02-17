import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../controllers/globalController.dart';
import '../../models/country.dart';
import '../../models/user_model.dart';
import '../../mystyle/button_style.dart';
import '../../mystyle/constantsColors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  User user = User();
  var image = File('');
  String imagePath = "";
  final picker = ImagePicker();
  bool uploading = false;

  List<Country> listCountry = <Country>[];
  late Country _selectedCountry;
  late String _selectedGender;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //
    Country.readJson().then((response) => {
      setState(() {
        listCountry = response;
        _selectedCountry = listCountry.first;
        user.nationality = _selectedCountry.name;
      }),
      // print( listCountry[0].name)
    });
    user.marital_status = globallistMaritalStatus[0];
    _selectedGender = globallistGender[0];
    user.gender =
    _selectedGender == "Male" ? 1 : 2;
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
                Positioned(
                  left: 0,
                  top: 0,
                  right: 0,
                  bottom: 0,
                  child: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(
                        end: 20,
                      ),
                      child: ElevatedButton(
                        child: Icon(
                          Icons.shopping_cart,
                          color: myprimercolor,
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

                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
            // Body
            Padding(
              padding: EdgeInsets.only(top: bodyHeight * 0.25),
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
                                        onChanged: (value) {
                                          user.user_name = value;
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
                                        onChanged: (value) {
                                          user.email = value;
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
                                            user.nationality = _selectedCountry.name;
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
                                                    user.birthdate =selectedDate;
                                                  });
                                                }
                                              });
                                            },
                                            child: Align(
                                              alignment: AlignmentDirectional.centerStart,
                                              child: Padding(
                                                padding: const EdgeInsetsDirectional.only(start: 60, end: 10),
                                                child: Text(user.birthdate != null?
                                                "${user.birthdate!.year}/${user.birthdate!.month}/${user.birthdate!.day}"
                                                    :'birth date' ,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color:user.birthdate != null? Colors.black54:Colors.grey
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
                                            user.gender =
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
                                        value: user.marital_status,
                                        icon: const Icon(Icons.arrow_drop_down),
                                        iconSize: 24,
                                        elevation: 16,
                                        isExpanded: true,
                                        style: const TextStyle(color: Colors.grey),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            user.marital_status = newValue!;
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
                        Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              style: bs_flatFill(context),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {

                                }
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Text(
                                  'Save',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
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
                    right: 6,
                    bottom: 6,
                    child:
                    GestureDetector(
                      onTap: (){},
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(150),
                            border: Border.all(color: Colors.grey.shade300, width: 3),
                            color: Colors.white),
                        child:Icon( Icons.camera_alt  ,
                          color: Colors.grey.shade300,
                          size: 30,
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