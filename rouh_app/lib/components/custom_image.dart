import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({super.key, this.url,  this.height,  this.width,  this.radius,  this.borderColor,  this.borderWidth, this.background});
  final String? url;
  final double? height;
  final double? width;
  final double? radius;
  final double? borderWidth;
  final Color? borderColor;
  final Color? background;

  @override
  Widget build(BuildContext context) {
    return Container(
      height:  height != null ? height! : 50,
      width:  width != null ? width! : 50,
      child: Container(
        height: height != null ? height! : 50,
        width:  width != null ? width! : 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius != null ? radius! : 15),
            border: Border.all(color:borderColor != null ? borderColor! : Colors.white , width:  borderWidth != null ? borderWidth! : 3),
            color:background != null ? background! : Colors.blueGrey),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius != null ? radius! : 15),
          child: Image(
            image: NetworkImage( url != null ? url! : ""),
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
    );
  }
}
