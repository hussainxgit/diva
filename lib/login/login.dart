import 'package:flutter/material.dart';
import 'package:diva/api_response.dart';
import 'package:diva/login//signup.dart';
import 'package:diva/provider/cart.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  // passing phone and password for login.
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email;
  String password;
  final signInForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<Carts>(// List of Carts from Consumer.
        builder: (context, cart, child) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        //appBar: CustomAppBar(),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(
              height: 80,
            ),
            Image.network(
              'https://flutterforweb.000webhostapp.com/resturant/logo.jpg',
              width: 150,
            ),
            const Text('تسجيل الدخول',
                style: TextStyle(
                    color: Colors.black, fontSize: 24, fontFamily: 'Droid')),
            Form(
                key: signInForm,
                child: Column(
                  children: [
                    SizedBox(
                      width: 300,
                      child: TextFormField(
                        initialValue: 'robinx5.q8@gmail.com',
                        textDirection: TextDirection.rtl,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.amber),
                                borderRadius: BorderRadius.circular(10.0)),
                            hintText: 'البريد الالكتروني',
                            hintStyle: const TextStyle(
                              fontFamily: 'Droid',
                            )),
                        validator: (value) {
                          if (value.isEmpty || value == null) {
                            return 'ادخل البريد الالكتروني';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          email = value;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: TextFormField(
                          initialValue: '123456',
                          textDirection: TextDirection.rtl,
                          maxLength: 30,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.amber),
                                  borderRadius: BorderRadius.circular(10.0)),
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
                  ],
                )),
            // ignore: deprecated_member_use
            TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.all(20.0),
                  backgroundColor: Colors.black,
                ),
                child: const Text('تسجيل الدخول',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Droid',
                        fontSize: 16)),
                onPressed: () async {
                  if (signInForm.currentState.validate()) {
                    signInForm.currentState.save();
                    await signIn(email, password).then((user) {
                      if(user != null){
                        cart.saveUserInProvider(user);
                        return Navigator.pushReplacementNamed(context, 'MyApp', arguments: user);
                      }
                    });
                  }
                }),
            TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.all(20.0),
                  backgroundColor: Colors.black,
                ),
                child: const Text('انشاء حساب جديد',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Droid',
                        fontSize: 16)),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpPage()));
                }),
            const Text('نسيت الرقم السري',
                style: TextStyle(
                    color: Colors.black, fontFamily: 'Droid', fontSize: 16)),
            InkWell(
              child: const Text('تسجيل لاحقاً',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Droid',
                      fontSize: 16)),
              onTap: () {
                Navigator.pushReplacementNamed(context, 'MyApp');
              },
            ),
            const SizedBox(
              height: 100,
            )
          ],
        )),
      );
    });
  }
}
