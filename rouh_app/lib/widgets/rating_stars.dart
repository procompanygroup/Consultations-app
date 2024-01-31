import 'package:flutter_svg/flutter_svg.dart';


import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final double rating;
  const RatingStars({Key? key,  required this.rating}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<Widget> stars = <Widget>[];
    for(int i = 1; i <= 5; i++){
      stars.add(
          Builder(
            builder: (context) {
              if(rating >= i)
                return SvgPicture.asset(
                  'assets/svg/star-full-icon.svg',
                  width: 12.5,
                  fit: BoxFit.cover,
                  color:Color(0xffF9CF2B),
                );
              else if(i > rating && rating > i-1 )
                return SvgPicture.asset(
                  'assets/svg/star-half-icon.svg',
                  width: 12.5,
                  fit: BoxFit.cover,
                  color:Color(0xffF9CF2B),
                );
              else
                return SvgPicture.asset(
                  'assets/svg/star-full-icon.svg',
                  width: 12.5,
                  fit: BoxFit.cover,
                  color:Colors.grey.shade300,
                );
            },
          ),
      );
    }
    return Row(
      children: stars,
    );
  }
}
