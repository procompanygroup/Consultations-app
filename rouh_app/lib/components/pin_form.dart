import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';

class PinForm extends StatelessWidget {
  const PinForm({
    super.key,
    required this.focusNode,
    required this.pin,
    this.nextFiledNode,
    this.onSubmit,
    this.otpLength = 4,
  });

  final TextEditingController pin;
  final FocusNode focusNode;
  final FocusNode? nextFiledNode;
  final VoidCallback? onSubmit;
  final int otpLength;

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      height: 50,
      textStyle: const TextStyle(fontSize: 22),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Theme.of(context).highlightColor),
      ),
    );

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        margin: const EdgeInsets.fromLTRB(40, 0, 40, 0),
        width: MediaQuery.of(context).size.width,
        child: Pinput(
          controller: pin,
          focusNode: focusNode,
          androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
          length: otpLength,
          defaultPinTheme: defaultPinTheme,
          validator: (val) {
            if (val == '') {
              return 'Please enter OTP code';
            } else {
              return null;
            }
          },
          errorTextStyle: Theme.of(context).inputDecorationTheme.errorStyle,
          keyboardType: TextInputType.phone,
          inputFormatters: [
            LengthLimitingTextInputFormatter(otpLength),
            FilteringTextInputFormatter.digitsOnly,
          ],
          onClipboardFound: (value) => pin.setText(value),
          hapticFeedbackType: HapticFeedbackType.heavyImpact,
          // cursor: GeneralWidgets.cursor,
          separatorBuilder: (_) => const SizedBox(width: 6),
          focusedPinTheme: defaultPinTheme.copyWith(
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.05999999865889549),
                  offset: Offset(0, 3),
                  blurRadius: 16,
                )
              ],
            ),
          ),
          closeKeyboardWhenCompleted: nextFiledNode != null ? false : true,
          onCompleted: (String? v) {
            if (nextFiledNode != null) {
              FocusScope.of(context).requestFocus(nextFiledNode);
            } else {
              if (onSubmit != null) onSubmit!();
            }
          },
          onSubmitted: (String? v) {
            if (onSubmit != null) onSubmit!();
          },
          submittedPinTheme: defaultPinTheme.copyWith(
            decoration: defaultPinTheme.decoration?.copyWith(
              color: Colors.cyan.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
              border:
                  Border.all(color: Theme.of(context).canvasColor, width: 1.8),
            ),
          ),
          errorPinTheme: defaultPinTheme.copyBorderWith(
            border: Border.all(
              color: Theme.of(context).inputDecorationTheme.errorStyle?.color ??
                  Colors.red,
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
