import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rouh_app/controllers/converters.dart';
import '../../bloc/UserInformation/user_information_cubit.dart';
import '../../controllers/dio_manager_controller.dart';
import '../../controllers/globalController.dart';
import '../../models/country.dart';
import '../../models/key_value_model.dart';
import '../../models/user_model.dart';
import '../../mystyle/button_style.dart';
import '../../mystyle/constantsColors.dart';
import '../main_navigation_screen.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var image = File('');
  String imagePath = "";
  final picker = ImagePicker();
  bool uploading = false;
  List<Country> listCountry = <Country>[];

  late Country _selectedCountry;
  // late String _selectedGender;
  late KeyValue _selectedGender ;
  late KeyValue _selectedMaritalStatus;
  // late String _selectedMaterialState;
  late String _selectedDate = "Choose your birthday";
  bool isChecked = true;
  User user = User();
  String? mobile;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState


    setState(() {
      listCountry = globalCountryList;
      _selectedCountry = listCountry.first;
      user.nationality = _selectedCountry.name;
      _selectedGender = globalListGender.first;
      _selectedMaritalStatus = globalListMaritalStatus.first;
    });


    super.initState();
    //

  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double bodyHeight = (MediaQuery.of(context).size.height //screen
        // -MediaQuery.of(context).padding.top // safe area
        // -AppBar().preferredSize.height //AppBar
    );

    // raghad
    final size = MediaQuery.of(context).size;

    return Scaffold(
      //backgroundColor: const Color(0xff022440),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [Color(0xff015DAC), Color(0xff022440)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        )),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.2),
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40))),
                width: size.width,
                height: size.height * 0.8,
              ),
            ),


            //form
            Padding(
                padding: EdgeInsetsDirectional.only(
                  top: size.height * 0.33,
                  end: size.width * 0.07,
                  start: size.width * 0.07,
                ),
                child: Form(
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5.0),
                                  child: Container(
                                    height: 45,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade50,
                                        borderRadius: BorderRadius.circular(25),
                                        border: Border.all(
                                            color: Colors.grey.shade300)),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.only(
                                          start: size.width * 0.17,
                                          top: size.height * 0.01),
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
                                                _selectedDate =
                                                    dateOnly.toString();
                                                user.birthdate = selectedDate;
                                              });
                                            }
                                          });
                                        },
                                        child: Text(_selectedDate),
                                      ),
                                    ),
                                  )),
                              Positioned(
                                bottom: 0,
                                top: 0,
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                    start: 25,
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      const Icon(Icons.date_range_sharp,
                                          color: Colors.black38),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15),
                                        child: VerticalDivider(
                                            color: Colors.grey.shade300),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          //gender
                          Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 5.0),
                                child: DropdownButtonFormField<KeyValue>(
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
                                  onChanged: (KeyValue? newValue) {
                                    setState(() {
                                      _selectedGender = newValue!;
                                      user.gender = int.parse(_selectedGender.key);
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
                                      hintText: "الجنس",
                                      fillColor: Colors.grey.shade50),
                                  items: globalListGender.map<DropdownMenuItem<KeyValue>>(
                                      (KeyValue value) {
                                    return DropdownMenuItem<KeyValue>(
                                      value: value,
                                      child: Text(converterGender(value.key)),
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
                                child: DropdownButtonFormField<KeyValue>(
                                  validator: (value) => value == null ? '' : null,
                                  //isDense: true,
                                  hint: const Text('Choose'),
                                  value: _selectedMaritalStatus,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  iconSize: 24,
                                  elevation: 16,
                                  isExpanded: true,
                                  style: const TextStyle(color: Colors.grey),
                                  onChanged: (KeyValue? newValue) {
                                    setState(() {
                                      _selectedMaritalStatus = newValue!;
                                      user.marital_status = _selectedMaritalStatus.key!;
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
                                      hintText: "الحالة الاجتماعية",
                                      fillColor: Colors.grey.shade50),
                                  items: globalListMaritalStatus
                                      .map<DropdownMenuItem<KeyValue>>(
                                          (KeyValue value) {
                                    return DropdownMenuItem<KeyValue>(
                                      value: value,
                                      child: Text(converterMaritalStatus(value.key)),
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
                          // Checkbox
                          Row(
                            children: [
                              Checkbox(
                                value: isChecked,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isChecked = value!;
                                  });
                                },
                                activeColor: Colors.pink.shade500,
                                checkColor: Colors.white,
                              ),
                              const Text(
                                'I am agree to the terms of use and privacy\n policy of the application.',
                                style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff015DAC)),
                                textAlign: TextAlign.center,
                              ),
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
                            height: 50,
                            child:BlocBuilder<UserInformationCubit,UserInformationState>(
                              builder:(context,state) {
                            return TextButton(
                              style: bs_flatFill(context,myprimercolor),
                                onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                String? res = await register();

                              if (int.parse(res ?? "0") > 0) {
                                //mobile = mobile?.replaceFirst("+", "");
                                var token =
                                await user.login(mobile: mobile ?? "");
                                // print(token);
                                if (token != "") {
                                  const storage = FlutterSecureStorage();
                                  // for write
                                  await storage.write(
                                    key: 'token', value: token);

                                  // get user Info
                                  var userInfo = await user.getUser(
                                      mobile: mobile as String);
                                  //save user info in block
                                  BlocProvider.of<UserInformationCubit>(context)
                                      .addProfile(userInfo!);
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                builder: (context) => const MainNavigationScreen(),
                               ));
                             }
                            }
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
                        ),
                      ],
                    ),
                )),

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
                      child:
                      imagePath == ""
                      ? Image(
                        // image: NetworkImage("https://picsum.photos/200/300?random=4"),
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
                        // image: NetworkImage("https://picsum.photos/200/300?random=4"),
                        image: FileImage(image),
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
                    right: 5,
                    bottom: 5,
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
                        child:Icon(  Icons.camera_alt  ,
                          color: Colors.grey.shade300,
                          size: 25,
                        ),
                      ),
                    ),

                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> register() async {

    const storage = FlutterSecureStorage();

    var mobileNum = await storage.read(key: "mobile") ?? "0";
   var dialCode = await storage.read(key: "dialCode") ?? "0";
    mobile = "$dialCode$mobileNum";
    //user.mobile = mobile;
    var imageFile = imagePath ==""? null : await MultipartFile.fromFile(
      imagePath,
    );
    FormData formData = FormData.fromMap({
      "user_name": user.user_name,
      "email": user.email,
      "gender": user.gender,
      "nationality": user.nationality,
      "mobile_num": mobileNum,
      "country_num": dialCode,
      "birthdate": user.birthdate,
      "marital_status": user.marital_status,
      'image': imageFile,
    });

      String? res = await user.register(formData:formData );

    return res;
  }

  getImagefromGallery() async {

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
}
