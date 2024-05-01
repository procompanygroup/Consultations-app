import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rouh_app_experts/models/expert_model.dart';

import '../../bloc/expert/expert_information_cubit.dart';
import '../../controllers/globalController.dart';
import '../../mystyle/constantsColors.dart';
import '../../components/custom_appbar.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  Expert expertWallet = Expert(cash_balance: 0,
      cash_balance_todate: 0);
  bool isLoadingExpertWallet = true;
  int expertId = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    expertId = context.read<ExpertInformationCubit>().state.fetchedExpert!.id!;
    fillExpertWalletList();

  }

  Future<void> fillExpertWalletList() async {

    try{

      globalExpert.GetWallet(expertId: expertId )
      .then((response) {
        setState(() {
          isLoadingExpertWallet = true;
          print(response);
          expertWallet = response;
          isLoadingExpertWallet = false;
        });
      });

    } catch (err) {
      setState(() {
        isLoadingExpertWallet = false;

      });

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(err.toString()),
          )
      );
    }


  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double bodyHeight = (MediaQuery.of(context).size.height //screen
        // - MediaQuery.of(context).padding.top // safe area
        // - AppBar().preferredSize.height //AppBar
        );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // top
          const CustomAppBar(title: "المحفظة"),
          // Body
          Padding(
            padding: EdgeInsets.only(top: bodyHeight * 0.20),
            child: Container(
              height: bodyHeight * 0.80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
                border: Border.all(color: Colors.grey),
                color: Colors.white,
              ),
              child: Padding(
                padding:
                    EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: bodyHeight*0.1,
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Text(
                          'غير مدفوع',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.grey.shade500,
                            // fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: screenWidth * 0.75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: mysecondarycolor,width: 2),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child:  Align(
                          alignment: Alignment.center,
                          child: Text( expertWallet!.cash_balance!.toString() +  '\$',
                            style: TextStyle(
                              fontSize: 22,
                              color: myprimercolor,
                              // fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding:
                      const EdgeInsets.only(left: 20,top: 20, right: 20, bottom: 0.0),
                      child: Divider(color: Colors.grey.shade200),
                    ),

                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Text(
                          'مدفوع',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.grey.shade500,
                            // fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: screenWidth * 0.75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: mysecondarycolor,width: 2),
                        color: mysecondarycolor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child:  Align(
                          alignment: Alignment.center,
                          child: Text(expertWallet!.cash_balance_todate!.toString() +  '\$',
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              // fontWeight: FontWeight.bold
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

          if ( isLoadingExpertWallet)
            Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
