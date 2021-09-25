import 'package:flutter/material.dart';
import 'package:diva/apiResponse.dart';

class SignUpPage extends StatelessWidget {
  final signInForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String phone;
    String password;
    String name;
    String email;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.network(
              'https://flutterforweb.000webhostapp.com/resturant/logo.jpg',
              width: 150,
            ),
            Text('تسجيل حساب جديد',
                style: TextStyle(
                    color: Colors.black, fontSize: 24, fontFamily: 'Droid')),
            Form(
                key: signInForm,
                child: Column(
                  children: [
                    SizedBox(
                      width: 300,
                      child: TextFormField(
                        textDirection: TextDirection.rtl,
                        maxLength: 8,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.amber),
                                borderRadius: BorderRadius.circular(10.0)),
                            hintText: 'رقم الهاتف',
                            hintStyle: TextStyle(
                              fontFamily: 'Droid',
                            )),
                        validator: (value) {
                          if (value.isEmpty || value == null) {
                            return 'ادخل رقم الهاتف';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          phone = value;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: TextFormField(
                          textDirection: TextDirection.rtl,
                          maxLength: 20,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.amber),
                                  borderRadius: BorderRadius.circular(10.0)),
                              hintText: 'الرقم السري',
                              hintStyle: TextStyle(
                                fontFamily: 'Droid',
                              )),
                          validator: (value) {
                            if (value.isEmpty || value == null) {
                              return 'ادخل الرقم السري';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            password = value;
                          }),
                    ),
                    SizedBox(
                      width: 300,
                      child: TextFormField(
                          textDirection: TextDirection.rtl,
                          maxLength: 30,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.amber),
                                  borderRadius: BorderRadius.circular(10.0)),
                              hintText: 'بريدك الالكتروني',
                              hintStyle: TextStyle(
                                fontFamily: 'Droid',
                              )),
                          validator: (value) {
                            if (value.isEmpty || value == null) {
                              return 'ادخل بريدك الالكتروني';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            email = value;
                          }),
                    ),
                    SizedBox(
                      width: 300,
                      child: TextFormField(
                          textDirection: TextDirection.rtl,
                          maxLength: 30,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.amber),
                                  borderRadius: BorderRadius.circular(10.0)),
                              hintText: 'الاسم',
                              hintStyle: TextStyle(
                                fontFamily: 'Droid',
                              )),
                          validator: (value) {
                            if (value.isEmpty || value == null) {
                              return 'ادخل الاسم';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            name = value;
                          }),
                    ),
                  ],
                )),
            TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.all(20.0),
                  backgroundColor: Colors.black,
                ),
                child: Text('تسجيل حساب جديد',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Droid',
                        fontSize: 16)),
                onPressed: () async {
                  if (signInForm.currentState.validate()) {
                    signInForm.currentState.save();
                    await signUp(phone, password, name, email, context);
                  }
                }),
            InkWell(
              child: Text('العودة',
                  style: TextStyle(
                      color: Colors.black, fontFamily: 'Droid', fontSize: 16)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(
              height: 20,
            )
          ],
        )),
      ),
    );
  }
}
