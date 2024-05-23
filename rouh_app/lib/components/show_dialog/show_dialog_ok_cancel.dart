import 'package:flutter/material.dart';
import 'package:rouh_app/mystyle/constantsColors.dart';

import '../../mystyle/button_style.dart';

Future ShowDialogOkCancel(BuildContext context,double _height, double _width,  String body,String ok,String cancel, Function() okFunction) {
  return showDialog(context: context, builder: (BuildContext context) =>
      Align(
        alignment: Alignment.center,
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
              // height: 30
              SizedBox(height: 30,),
              // height: _height - 30-10-70-10
              Container(
                height: _height - 30-10-70-10,
                child: Column(
                  children: [
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
                  ],
                ),
              ),
              // height: 10
              SizedBox(height: 10,),
              // height: 70
              Container(
                height: 70,
                width: _width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Container(
                              width: (_width  - 25 - 10) * 0.5   ,
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
                            SizedBox(width: 10,),
                            Container(
                              width: (_width  - 25 - 10) * 0.5   ,
                              height: 50,
                              child:TextButton(
                                style: bs_flatFill(
                                    context, mysecondarycolor),
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  cancel,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // height: 10
              SizedBox(height: 10,)

            ],
          ),
        ),
          ),
        );
 }