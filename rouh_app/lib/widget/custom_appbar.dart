import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double bodyHeight = (MediaQuery.of(context).size.height);
    return Container(
      height: bodyHeight * 0.30,
      width: screenWidth,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: [Color(0xff015DAC), Color(0xff022440)],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      )),
      child: Padding(
        padding: EdgeInsetsDirectional.only(bottom: bodyHeight * 0.05),
        child: Row(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Transform(
              transform: Matrix4.identity().scaled(-1.0, 1.0, 1.0),
              child: InkWell(
                  child: SvgPicture.asset(
                    "assets/svg/back-arrow.svg",
                    width: 33,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  }),
            ),
            SizedBox(
              width: screenWidth * 0.15,
            ),
            const Text(
              "Activate App",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
