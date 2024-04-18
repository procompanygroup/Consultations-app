import 'dart:convert';
import 'package:collection/collection.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

import '../../controllers/globalController.dart';
import '../../controllers/phone_auth_controller.dart';
import '../../models/country.dart';
import '../../mystyle/button_style.dart';
import '../../mystyle/constantsColors.dart';
import '../../components/show_dialog.dart';
import 'login_verification_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool isLoading = false;

   List<Country> listCountry = <Country>[];
  late Country _selectedCountry = new Country(code: "",name: "", dialCode: "",flag: "");
  // late Country _selectedCountry;
  late String _phoneNumber;
  late String fullNumber;
  PhoneAuthController controller = PhoneAuthController();
  var verifyCode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /*
    Country.readJson().then((response) => {
      // print(response),
      setState(() {
        listCountry = response;
        globalCountryList = listCountry;

        _selectedCountry = listCountry.first;
      }),
      // print( listCountry[0].name)
    });
    */

/*
    Country.readJson().then((response) => {
      // print(response),
      setState(() {
        listCountry = response;
        globalCountryList = listCountry;
        String ipLocation = '';
        try {
          http.get(Uri.parse('http://ip-api.com/json')).then((value) {
            // print(json.decode(value.body)['countryCode'].toString());
            ipLocation = json.decode(value.body)['countryCode'].toString();
            print(ipLocation);
          });
          _selectedCountry =listCountry.firstWhere((element) => element.code == ipLocation);
        } catch (err) {
          //handleError
          ipLocation = '';
          _selectedCountry = listCountry.first;
        }
        // _selectedCountry = listCountry.first;
      }),
      // print( listCountry[0].name)
      print(_selectedCountry)
    });
    */
    print("globalCountryList.first:" + globalCountryList.first.code.toString());
    print("globalCountryIp: " + globalCountryIp);
    listCountry = globalCountryList;
      setState(() {
        // try {
        Country? _selectedCountryIp = listCountry.firstWhereOrNull((element) => element.code == globalCountryIp);

          _selectedCountry = globalCountryIp == "" || _selectedCountryIp == null ?
              globalCountryList.first
              : _selectedCountryIp;
          print("_selectedCountry: " + _selectedCountry.code.toString());
        // } catch (err) {
        //   _selectedCountry = listCountry.first;
        // }
      });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25.0),
      child: Stack(
        children: [
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Login",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: mysecondarycolor),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10.0),
                  child: Divider(color: Colors.grey.shade300),
                ),
                // select country
                Stack(
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
                        items: listCountry
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
                ),

                // phone number
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Stack(
                    children: [
                      // phone number without code
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length > 9 ||
                                  value.length < 4) {
                                return '';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              _phoneNumber = value;
                              //_formKey.currentState!.validate();
                              // print(_phoneNumber);
                            },
                            //style: TextStyle(fontSize: 12),
                            decoration: InputDecoration(
                              //test the height
                              errorStyle: TextStyle(fontSize: 0, height: 0),

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
                              contentPadding: EdgeInsetsDirectional.only(
                                  start: 70, top: 5, end: 60, bottom: 5),
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                              // labelText: "Phone Number",
                              hintText: "Phone Number",
                              fillColor: Colors.grey.shade50,
                            ),
                            keyboardType: TextInputType.number,
                            // maxLength: 10,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(9)
                            ],
                            // obscureText: true,
                            // enableSuggestions: false,
                            // autocorrect: false,
                          )),
                      // code number
                      Positioned(
                        bottom: 0,
                        top: 0,
                        //   left: 0,
                        left: 0,
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
                      // )
                    ],
                  ),
                ),

                // login button
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 5.0),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    child: TextButton(
                        child: Text(
                          'LOGIN',
                          style: TextStyle(fontSize: 18),
                        ),
                        style: bs_flatFill(context,myprimercolor),
                        // onPressed: () {},

                        onPressed: isLoading
                            ? () {}
                            : () async {

                            if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });


                                  fullNumber =
                                      _selectedCountry.dialCode! + _phoneNumber;
                                  verifyCode = await controller.sendSMS(
                                      toPhoneNumber: (fullNumber));
                                  print("verifyCode: " + verifyCode);
                                  if (verifyCode == 'timedOut') {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    await ShowMessageDialog(context,
                                        "Error",
                                        "Connection Failed. Please Retry Later");
                                  } else if (verifyCode == 'noInternet') {
                                    await  ShowMessageDialog( context,
                                        "Error",
                                        "Internet Connection Error");
                                    setState(() {
                                      isLoading = false;
                                    });
                                  } else if (verifyCode == 'errorPhone') {
                                   await ShowMessageDialog( context,
                                        "Error",
                                        "Incorrect Phone Number");
                                    setState(() {
                                      isLoading = false;
                                    });
                                  } else {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    const storage = FlutterSecureStorage();
                                    // for write mobile phone
                                    await storage.write(
                                        key: 'mobile', value: _phoneNumber);
                                    await storage.write(
                                        key: 'dialCode', value: _selectedCountry.dialCode);
                                    // Navigator.of(context).push(
                                    //   MaterialPageRoute(
                                    //     builder: (context) =>
                                    //         LoginVerificationScreen(
                                    //             verifyCode: verifyCode,
                                    //             fullNumber: fullNumber),
                                    //   ),
                                    // );
                                  }

                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          LoginVerificationScreen(
                                              verifyCode: verifyCode,
                                              fullNumber: fullNumber,
                                          phoneNumber :_phoneNumber,
                                          dialCode:_selectedCountry.dialCode),
                                    ),
                                  );
                                  // }
                                  // ),
                                }

                          }),
                  ),
                ),
              ],
            ),
          ),
          // loading
          if (isLoading)
            Positioned(
              left: 0,
              top: 0,
              right: 0,
              bottom: 0,
              child: Center(child: CircularProgressIndicator()
                  // child: Text("Hello")
                  ),
            )
        ],
      ),
    );
  }
}
