import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:otp/otp.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

import '/constants/global.dart';

class PhoneAuthController {
  late final TwilioFlutter twilioFlutter;

  PhoneAuthController() {
    _initializeTwilio();
  }

  void _initializeTwilio() {
    twilioFlutter = TwilioFlutter(
      accountSid: accountSid,
      authToken: authToken,
      twilioNumber: twilioNumber,
    );
  }

  Future<String> sendSMS({required String toPhoneNumber}) async {
    debugPrint('toPhoneNumber: => $toPhoneNumber');

    try {
      const storage = FlutterSecureStorage();
      final otp = OTP.generateTOTPCodeString(
        "$toPhoneNumber${Random().nextInt(toPhoneNumber.length)}",
        7,
        length: 4,
      );
      await storage.write(key: 'otp', value: otp);

      final sendSMSRes = await twilioFlutter.sendSMS(
        toNumber: toPhoneNumber,
        messageBody: "ROUH account verification code: $otp",
      );

      return _handleSendSMSResponse(sendSMSRes);
    } catch (e) {
      return _handleSendSMSError(e);
    }
  }

  String _handleSendSMSResponse(int responseCode) {
    return responseCode == 201 ? 'success' : 'errorPhone';
  }

  String _handleSendSMSError(dynamic error) {
    final errorMessage = error.toString();
    debugPrint('SendSMSError: => $error');

    switch (errorMessage) {
      case "Connection timed out":
        return "timedOut";
      case "Failed host lookup: 'api.twilio.com'":
        return "noInternet";
      default:
        return "errorPhone";
    }
  }
}
