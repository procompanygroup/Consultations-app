import 'package:flutter/material.dart';

import '../../mystyle/button_style.dart';
import '../../mystyle/constantsColors.dart';

Future ShowDialogExpertSelect(BuildContext context,double _height, double _width,  String body,String ok,String cancel, Function() okFunction, String imagePath) {
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
                       SizedBox(height: 50,),
                       SizedBox(height: 10,),
                       Expanded(
                         child: SingleChildScrollView(
                           scrollDirection: Axis.vertical,
                           child: Padding(
                             padding:  EdgeInsets.symmetric(horizontal: 30.0, vertical: 0),
                             child: Container(
                               child: Center(
                                 child: Text(body,
                                   textAlign: TextAlign.center,
                                   style: TextStyle(
                                       color: myprimercolor,
                                       fontSize: 18
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
                         ),
                       ),
                       SizedBox(height: 10,)

                     ],
                   ),
                 ),
               // ),
             ),
             //Image
             Align(
               alignment: Alignment.topCenter,
               child: Container(
                 width: 100,
                 height: 100,
                 decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(150),
                     border: Border.all(color: Colors.white, width: 3),
                     boxShadow: [
                       BoxShadow(
                         color: Colors.black.withOpacity(0.03),
                         spreadRadius: 5,
                         blurRadius: 7,
                         offset: Offset(0, 3), // changes position of shadow
                       ),
                     ],
                     color: Colors.blueGrey),
                 child: ClipRRect(
                     borderRadius: BorderRadius.circular(150),
                     child:
                     Image(
                       image:  NetworkImage(imagePath),
                       fit: BoxFit.cover,
                       errorBuilder:
                           (BuildContext context, Object exception, StackTrace? stackTrace) {
                         return Image(
                           image: AssetImage("assets/images/default_image.png"),
                           fit: BoxFit.fitHeight,
                         );
                       },
                     )
                 ),
               ),
             ),
           ],
         ),
       ),
     )
 );
}