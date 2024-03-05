import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import '../../bloc/UserInformation/user_information_cubit.dart';
import '../../models/user_model.dart';

class PaymentScreen extends StatefulWidget {

  final String price;
  final int pointId;
  final int points;
  const PaymentScreen({Key? key,required this.pointId,required this.points, required this.price})
      : super(key: key);


  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Map<String, dynamic>? paymentIntent;
  User user = User();

  @override
  void initState() {
    // TODO: implement initState
    setState(()  {
      // paymentIntent = await createPaymentIntent(widget.price, 'USD');
      user = context.read<UserInformationCubit>().state.fetchedPerson!;
      WidgetsBinding.instance.addPostFrameCallback((_){
        makePayment(widget.price);
        createPaymentIntent(widget.price, 'USD');
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stripe Payment'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //BlocBuilder<UserInformationCubit,UserInformationState>(
            //builder:(context,state) {
                  // return TextButton(
                  // child: const Text('Make Payment'),
                  // onPressed: () async {
                  // await makePayment(widget.price );
                  // },
                  // );
                //  },
            //),
          ],
        ),
      ),
    );
  }

  Future<void> makePayment( String price) async {
    try {
      paymentIntent = await createPaymentIntent(price as String, 'USD');

      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            customFlow: false,
            merchantDisplayName: 'Flutter Stripe Demo',
              paymentIntentClientSecret: paymentIntent![
              'client_secret'], //Gotten from payment intent
            // paymentIntentClientSecret: paymentIntent![
            //   'paymentIntent'], //Gotten from payment intent
            style: ThemeMode.dark,
            //extra
            customerEphemeralKeySecret: paymentIntent!['ephemeralKey'],
              customerId: paymentIntent!['customer'],
            googlePay: const PaymentSheetGooglePay(merchantCountryCode: 'US',testEnv: true),
              ))
          .then((value) {});

      //STEP 3: Display Payment sheet
      await displayPaymentSheet();
    } catch (err) {
      throw Exception(err);
    }
  }

  displayPaymentSheet() async {
    try {

      await Stripe.instance.presentPaymentSheet().then((value) async {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 100.0,
                  ),
                  SizedBox(height: 10.0),
                  Text("Payment Successful!"),
                ],
              ),
            ));

        try {
          await user.ChangeBalance(clientId: user.id as int,
              points: widget.points,
              pointId: widget.pointId);

          user.balance = (user.balance! + widget.points)!;
          BlocProvider.of<UserInformationCubit>(context)
              .addProfile(user);

          paymentIntent = null;

          //balance updated successfully
          Navigator.pop(context);

        }
        catch(e){

        }
      }).onError((error, stackTrace) {
        throw Exception(error);
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: const [
                Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                Text("Payment Failed"),
              ],
            ),
          ],
        ),
      );
    } catch (e) {
      print('$e');
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
      };

      var headers = {
        'content-type': 'application/x-www-form-urlencoded',
        'accept': 'application/json',
        'connection': 'keep-alive',
        'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
      };
      Dio dio = Dio(
        BaseOptions(
          // baseUrl: 'https://api.stripe.com/v1/payment_intents',
         // contentType:'application/json' ,
          responseType: ResponseType.plain,
          followRedirects: true,
          headers: headers,
          validateStatus: (int? status) {
            return status != null;
            // return status != null && status >= 200 && status < 300;
          },
        ),
      );
      //Make post request to Stripe
      var response = await dio.post('https://api.stripe.com/v1/payment_intents',data:body);
      print(response.data);

      return json.decode(response.data);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  calculateAmount(String amount) {
    final calculatedAmout = (double.parse(amount)) * 100;
    return calculatedAmout.toInt().toString();
  }
}
