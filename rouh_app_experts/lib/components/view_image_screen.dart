import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../mystyle/constantsColors.dart';
import 'custom_appbar.dart';

class ViewImageScreen extends StatelessWidget {
  const ViewImageScreen({super.key, required this.imagePath});
  final String imagePath;
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
          const CustomAppBar(title: "عرض الصورة"),
          // Body
          Padding(
            padding: EdgeInsets.only(top: bodyHeight * 0.20),
            child: Container(
              height: bodyHeight * 0.80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                // border: Border.all(color: Colors.grey),
                color: Colors.white,
              ),
              child: Padding(
                padding:
                // EdgeInsets.only(left: 0, top: 40, right: 0, bottom: 10),
                EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image(
                       image: NetworkImage(imagePath),
                      fit: BoxFit.fitWidth,
                      height: bodyHeight * 0.80,
                      width: screenWidth,
                      errorBuilder:
                          (BuildContext context, Object exception, StackTrace? stackTrace) {
                        return Image(
                          image: AssetImage("assets/images/default_image.png"),
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );


  }
}
