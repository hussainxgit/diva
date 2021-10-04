import 'package:flutter/material.dart';

import 'address/view_all_address.dart';

class Profile extends StatelessWidget {
  const Profile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ملفي الشخصي',
          style: TextStyle(fontFamily: 'Droid', color: Colors.black87),
        ),
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black87),
        backgroundColor: Colors.grey[100],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(10),
          ),
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey[200],
            child: const Text('Image'),
          ),
          const Padding(
            padding: EdgeInsets.all(10),
          ),
          const Text('Name of Client'),
          const Padding(
            padding: EdgeInsets.all(10),
          ),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
                onPrimary: Colors.white,
                padding: const EdgeInsets.all(10),
                textStyle: const TextStyle(fontFamily: 'Droid',
                fontSize: 18,)
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ViewAllAddress()),
                );
              },
              child: const Text('العناوين المسجلة'),
            ),
          )
        ],
      ),
    );
  }
}
