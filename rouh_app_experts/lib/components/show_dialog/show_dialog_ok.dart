import 'package:flutter/material.dart';

import '../../mystyle/button_style.dart';
import '../../mystyle/constantsColors.dart';

Future ShowDialogOk(BuildContext context,double _height, double _width,  String body,String ok, Function() okFunction) {
  return showDialog(context: context, builder: (BuildContext context) =>
      Align(
        alignment: Alignment.center,
        child: Container(
          height:_height + 50 ,
          width:_width ,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                // child: Dialog(
                //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), //this right here
                child: Container(
                  // height: 300.0,
                  // width: 300.0,
                  height:_height,
                  width: _width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(height: 30,),
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Padding(
                            padding:  EdgeInsets.all(10.0),
                            child: Container(
                              child: Center(
                                child: Text(body,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: myprimercolor,
                                      fontSize: 22
                                  ),),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        width: _width,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          child: Expanded(
                            child: Row(
                              children: [
                                Container(
                                  width: (_width  - 25)  ,
                                  //width: 200,
                                  height: 50,
                                  child:TextButton(
                                    style: bs_flatFill(
                                        context, myprimercolor),
                                    onPressed: () async {
                                      Navigator.of(context).pop();
                                      okFunction();
                                    },
                                    child: Text(
                                      ok,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,)

                    ],
                  ),
                ),
                // ),
              ),

            ],
          ),
        ),
      ),
  );
}