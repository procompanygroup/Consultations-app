import 'package:twilio_flutter/twilio_flutter.dart';

import '/constants/global.dart';

class PhoneAuthController {
  late final TwilioFlutter twilioFlutter;

  PhoneAuthController() {
    _initializeTwilio();
  }

  void _initializeTwilio() {
    twilioFlutter = TwilioFlutter(
      accountSid: accountSid, // replace it with your account SID
      authToken: authToken, // replace it with your auth token
      twilioNumber: twilioNumber, // replace it with your purchased twilioNumber
    );
  }

  Future<String> sendSMS({required String toPhoneNumber}) async {
    try {
      final sendSMSRes = await twilioFlutter.sendSMS(
        toNumber: toPhoneNumber,
        messageBody: smsBody,
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
