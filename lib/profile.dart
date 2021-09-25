import 'package:flutter/material.dart';

import 'address/ViewAllAddress.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('addresses'),),
      body: Center(child: ElevatedButton(onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ViewAllAddress()),
        );
      },child: Text('your addresses'),),),
    );
  }
}
