import 'package:flutter/material.dart';

import 'address/view_all_address.dart';

class Profile extends StatelessWidget {
  const Profile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('addresses'),),
      body: Center(child: ElevatedButton(onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const ViewAllAddress()),
        );
      },child: const Text('your addresses'),),),
    );
  }
}
