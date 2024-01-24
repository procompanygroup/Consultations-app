import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../controllers/phone_auth_controller.dart';
import '../../models/country.dart';
import '../../mystyle/button_style.dart';
import '../../mystyle/constantsColors.dart';
import 'login_verification_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool isLoading = false;

  List<Country> listCountry = <Country>[];
  late Country _selectedCountry;
  late String _phoneNumber;
  late String fullNumber;
  PhoneAuthController controller = PhoneAuthController();
  var verifyCode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //
    Country.readJson().then((response) => {
          // print(response),

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
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Divider(color: Colors.grey),
                ),

                // select country
                Stack(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      child: DropdownButtonFormField<Country>(
                        validator: (value) =>
                            value == null ? 'field required' : null,
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
                            SvgPicture.asset(
                              'assets/svg/syria-flag.svg',
                              width: 50,
                              height: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: VerticalDivider(
                                  // color: Colors.grey
                                  color: Colors.grey),
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
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length < 10) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              _phoneNumber = value;
                              _formKey.currentState!.validate();
                              // print(_phoneNumber);
                            },
                            //style: TextStyle(fontSize: 12),
                            decoration: InputDecoration(
                              errorStyle: TextStyle(fontSize: 0),

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              filled: true,
                              contentPadding: EdgeInsetsDirectional.only(
                                  start: 70, top: 5, end: 60, bottom: 5),
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                              // labelText: "Phone Number",
                              hintText: "Phone Number",
                              fillColor: Colors.grey.shade50,
                              // // hide maxLength
                              // counterStyle: TextStyle(height: double.minPositive,),
                              // counterText: ""
                            ),
                            keyboardType: TextInputType.number,
                            // maxLength: 10,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10)
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
                                      fontSize: 12,
                                      color: myprimercolor),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0, top: 15, right: 10, bottom: 15),
                                  child: VerticalDivider(
                                      // color: Colors.grey
                                      color: Colors.grey),
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
                                    color: Colors.grey),
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
                    child: TextButton(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            'LOGIN',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        style: bs_flatFill(context),
                        // onPressed: () {},

                        onPressed: isLoading
                            ? () {}
                            : () async => {
                                  if (_formKey.currentState!.validate())
                                    {
                                      setState(() {
                                        isLoading = true;
                                      }),

                                      // print(_selectedCountry.dialCode! + _phoneNumber ),
                                      print("Send messager"),
                                      fullNumber = _selectedCountry.dialCode! +
                                          _phoneNumber,
                                      verifyCode = await controller.sendSMS(
                                          toPhoneNumber: (fullNumber)),
                                      print("verifyCode: " + verifyCode),
                                      /*    if (verifyCode == 'timedOut')
                                        {message = "Time Out"}
                                      else if (verifyCode == 'noInternet')
                                        {message = "No Internet"}
                                      else if (verifyCode == 'errorPhone')
                                        {message = "Error Phone"}*/
                                      // else
                                      setState(() {
                                        isLoading = false;
                                      }),

                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              LoginVerificationScreen(
                                                  verifyCode: verifyCode,
                                                  fullNumber: fullNumber),
                                        ),
                                      ),

                                      // }
                                      // ),
                                    },
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
