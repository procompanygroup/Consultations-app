import 'package:flutter_svg/flutter_svg.dart';


import 'package:flutter/material.dart';

class RatingStarsAction extends StatelessWidget {
  // final Function()? onTap;
  final Function(int val) function;
  final double size;
  const RatingStarsAction({Key? key,   required this.size, required this.function}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<Widget> stars = <Widget>[];
    for(int i = 1; i <= 5; i++){
      stars.add(
        Builder(
          builder: (context) {
            var val = i ;
              return GestureDetector(
                onTap: () => function(val),
                // onTap: () => print(val),
                child: SvgPicture.asset(
                  'assets/svg/star-full-icon.svg',
                  width: size,
                  fit: BoxFit.cover,
                  color:Colors.grey.shade300,
                ),
              );
          },
        ),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: stars,
    );
  }
}
