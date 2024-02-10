import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImagePicker extends StatefulWidget {
  const ImagePicker({super.key});

  @override
  State<ImagePicker> createState() => _ImagePickerState();
}
class _ImagePickerState extends State<ImagePicker> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    String imagePath = "";
    return GestureDetector(
      onTap: () {
        print("pick image here");
      },
      child: Container(
        height: screenWidth,
        width: screenWidth,
        child: Stack(
          children: [
            imagePath == ""?
            // background icon
            Container(
              decoration:  BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade200, width: 1),
                  color: Colors.grey.shade100
              ),
              child: Positioned(
                left: 0,
                top: 0,
                right: 0,
                bottom: 0,
                child: Center(
                  child: SvgPicture.asset(
                    'assets/svg/plus-icon.svg',
                    height: 35,
                    width: 35,
                    fit: BoxFit.cover,
                    color: Colors.grey.shade400,
                    // color: Colors.red,
                  ),
                ),
              ),
            )
                : Container(
              width: screenWidth,
              height: screenWidth,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade200, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  color: Colors.grey.shade100),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(
                  image:NetworkImage("https://picsum.photos/200/300?random=4"),
                  fit: BoxFit.cover,
                  errorBuilder:
                      (BuildContext context, Object exception, StackTrace? stackTrace) {
                    return Image(
                      image: AssetImage("assets/images/default_image.png"),
                      fit: BoxFit.fitHeight,
                    );
                  },
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}