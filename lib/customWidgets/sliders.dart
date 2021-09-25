import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class HomeSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 350.0,
        child: Carousel(
          boxFit: BoxFit.cover,
          autoplay: false,
          animationCurve: Curves.fastOutSlowIn,
          animationDuration: const Duration(milliseconds: 2000),
          dotSize: 6.0,
          dotIncreasedColor: const Color(0xFFffba00),
          dotBgColor: Colors.transparent,
          dotPosition: DotPosition.bottomCenter,
          dotVerticalPadding: 10.0,
          showIndicator: true,
          indicatorBgPadding: 7.0,
          images: const [
            NetworkImage(
                'https://flutterforweb.000webhostapp.com/resturant/sliderimg1.jpg'),
            NetworkImage(
                'https://images.unsplash.com/photo-1481931098730-318b6f776db0?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=674&q=80'),
          ],
        ));
  }
}
