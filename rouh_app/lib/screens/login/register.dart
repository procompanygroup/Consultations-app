import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../controllers/dio_manager_controller.dart';
import '../../models/country.dart';
import '../../models/user_model.dart';
import '../../mystyle/button_style.dart';

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
  List<String> listMaritalStatus = ["Single", "Married", "Divorced", "Widowed"];
  List<String> listGender = ["Male", "Female"];
  late Country _selectedCountry;
  late String _selectedGender = listGender[0];
  late String _selectedMaterialState = listMaritalStatus[0];
  late String _selectedDate = "Choose your birthday";
  bool isChecked = true;
  User user = User();
  String? mobile;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //
    Country.readJson().then((response) => {
          setState(() {
            listCountry = response;
            _selectedCountry = listCountry.first;
          }),
          // print( listCountry[0].name)
        });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      //backgroundColor: const Color(0xff022440),
      body: SingleChildScrollView(
        child: Container(
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
              Padding(
                padding: EdgeInsetsDirectional.only(
                    start: size.width * 0.3,
                    end: size.width * 0.3,
                    top: size.height * 0.1),
                child: Stack(children: [
                  Container(
                    width: size.width * 0.4,
                    height: size.width*0.4,
                    decoration: BoxDecoration(
                        image: imagePath == ""
                            ? const DecorationImage(image: NetworkImage(""))
                            : DecorationImage(image: FileImage(image)),
                        borderRadius: BorderRadius.circular(80),
                        border: Border.all(color: Colors.white, width: 5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 4,
                            blurRadius: 10,
                            offset: const Offset(3, 3),
                          ),
                        ],
                        color: Colors.blueGrey),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: size.width * 0.25, top: size.height * 0.12),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(5),
                        backgroundColor:
                            Colors.grey.shade50, // <-- Button color
                      ),
                      onPressed: () {
                        getImagefromGallery();
                      },
                      child: Icon(
                        Icons.camera_alt,
                        size: 35,
                        color: Colors.grey.shade300,
                      ),
                    ),
                  )
                ]),
              ),
              Padding(
                  padding: EdgeInsetsDirectional.only(
                    top: size.height * 0.33,
                    end: size.width * 0.07,
                    start: size.width * 0.07,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
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
                                    SvgPicture.asset(
                                      'assets/svg/syria-flag.svg',
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
                        Stack(
                          children: [
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 5.0),
                                child: Container(
                                  height: size.height * 0.06,
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
                                items: listGender.map<DropdownMenuItem<String>>(
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
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 5.0),
                              child: DropdownButtonFormField<String>(
                                validator: (value) => value == null ? '' : null,
                                //isDense: true,
                                hint: const Text('Choose'),
                                value: _selectedMaterialState,
                                icon: const Icon(Icons.arrow_drop_down),
                                iconSize: 24,
                                elevation: 16,
                                isExpanded: true,
                                style: const TextStyle(color: Colors.grey),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedMaterialState = newValue!;
                                    user.marital_status =
                                        _selectedMaterialState;
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
                                items: listMaritalStatus
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
                        Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              style: bs_flatFill(context),
                              onPressed: () async {
                                if(_formKey.currentState!.validate()){
                                  String? res = await register();
                                  if (int.parse(res ?? "0") > 0) {
                                    var token =
                                    await user.login(mobile: mobile ?? "");
                                    // print(token);
                                    if (token != "") {
                                      const storage = FlutterSecureStorage();
                                      // for write
                                      await storage.write(
                                          key: 'token', value: token);
                                    }
                                    print(res);
                                  }
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
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Future<String?> register() async {
    DioManager dioManager = DioManager();
    const storage = FlutterSecureStorage();
    String? mobile = await storage.read(key: "mobile") ?? "0";
    user.mobile = mobile.replaceFirst("+", "");
    FormData formData = FormData.fromMap({
      "user_name": user.user_name,
      "email": user.email,
      "gender": user.gender,
      "nationality": user.nationality,
      "mobile": user.mobile,
      "birthdate": user.birthdate,
      "marital_status": user.marital_status,
      'image': await MultipartFile.fromFile(
        imagePath,
      ),
    });
    try {
      var response = await dioManager.dio.post(
        'https://oras.orasweb.com/api/registerclient',
        data: formData,
      );
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return "";
      }
    } catch (e) {
      print(e.toString());
    }
    return "";
  }

  getImagefromGallery() async {
    //final status = await ImagePicker();
    final pickedfile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedfile != null) {
      setState(() {
        image = File(pickedfile.path);
        imagePath = pickedfile.path;
        // print(image);
      });
      setState(() {
        uploading = true;
      });
    }
  }
}
