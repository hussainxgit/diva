import 'package:flutter/material.dart';
import 'package:diva/services/api_response.dart';

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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.all(50),),
            Image.network(
              'https://flutterforweb.000webhostapp.com/resturant/logo.jpg',
              width: 150,
            ),
            const Text('تسجيل حساب جديد',
                style: TextStyle(
                    color: Colors.black, fontSize: 24, fontFamily: 'Droid')),
            const Padding(padding: EdgeInsets.all(10),),
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
                            contentPadding: const EdgeInsets.only(left: 20.0),
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.amber),
                                borderRadius: BorderRadius.circular(20.0)),
                            hintText: 'رقم الهاتف',
                            hintStyle: const TextStyle(
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
                              contentPadding: const EdgeInsets.only(left: 20.0),
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.amber),
                                  borderRadius: BorderRadius.circular(20.0)),
                              hintText: 'الرقم السري',
                              hintStyle: const TextStyle(
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
                              contentPadding: const EdgeInsets.only(left: 20.0),
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.amber),
                                  borderRadius: BorderRadius.circular(20.0)),
                              hintText: 'بريدك الالكتروني',
                              hintStyle: const TextStyle(
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
                              contentPadding: const EdgeInsets.only(left: 20.0),
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.amber),
                                  borderRadius: BorderRadius.circular(20.0)),
                              hintText: 'الاسم',
                              hintStyle: const TextStyle(
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
                  padding: const EdgeInsets.all(20.0),
                  backgroundColor: Colors.black,
                ),
                child: const Text('تسجيل حساب جديد',
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
            const Padding(padding: EdgeInsets.all(30),),
            InkWell(
              child: const Text('العودة',
                  style: TextStyle(
                      color: Colors.black, fontFamily: 'Droid', fontSize: 16)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        )),
      ),
    );
  }
}
