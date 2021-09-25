import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'best_sales.dart';
import 'categories.dart';
import 'customWidgets/sliders.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: 350,
          child: HomeSlider(),
        ), // Slider
        Container(
          margin: EdgeInsets.all(10.0),
          height: 35,
          alignment: Alignment.topRight,
          child: Text(
            'شنو تبي تاكل ؟',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Droid',
            ),
          ),
        ), // Text
        Container(
          height: 180,
          margin: EdgeInsets.all(5.0),
          child: HomeCategories(),
        ), // Menu Categories
        Container(
          margin: EdgeInsets.all(10.0),
          height: 35,
          alignment: Alignment.topRight,
          child: Text(
            'الاكثر طلبا هذا الشهر',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Droid',
            ),
          ),
        ), // Text (best Sales)
        BestSales(),
      ],
    );
  }
}
