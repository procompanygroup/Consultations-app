import 'dart:math';

import 'package:flutter/material.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import '../constants/global.dart';

class PhoneAuthController  {
  late TwilioFlutter twilioFlutter;
  TextEditingController phoneNumberController = TextEditingController();


  Future<String> sendSMS({required toPhoneNumber}) async {
    twilioFlutter = TwilioFlutter(
        accountSid:accountSid, // replace it with your account SID
        authToken: authToken, // replace it with your auth token
        twilioNumber: twilioNumber // replace it with your purchased twilioNumber

        );

    var rnd = new Random();

    var digits = rnd.nextInt(900000) + 100000;

    // lets print otp as well
   // print(toPhoneNumber);
String res ="";
    try {
      var sendSMSRes = await twilioFlutter.sendSMS(
          toNumber: toPhoneNumber,
          messageBody: smsBody + ' $digits');

       //print(sendSMSRes);
      //
      if (sendSMSRes == "Sms sent Success")
        res = digits.toString();
      else if (sendSMSRes == "Sending Failed")
        res =  "errorPhone";

      return res;
    }
    catch (e,s){
      //print(e.toString() + ' errorPhone exp');
      if(e.hashCode == 314407456)
        res = "noInternet";
      else
      res =  "errorPhone";
     // print(e.hashCode);
      return res;
    }

    res = "unknownError";
    return res;
  }

}
