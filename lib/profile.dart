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
          const Text('شحفان القطو', style: TextStyle(fontSize: 16,fontFamily: 'Droid'),),

          Center(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.all(20),
              //padding: EdgeInsets.all(20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.orange[400],
                    onPrimary: Colors.white,
                    padding: const EdgeInsets.all(10.0),
                    textStyle: const TextStyle(fontFamily: 'Droid',fontSize: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ViewAllAddress()),
                  );
                },
                child: const Text('العناوين المسجلة'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
