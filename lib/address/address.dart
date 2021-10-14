import 'package:flutter/material.dart';
import 'package:diva/services/api_response.dart';
import 'package:diva/provider/cart.dart';
import 'package:provider/provider.dart';
import 'package:diva/Models/user.dart';

class AddAddress extends StatefulWidget {
  final Function notifyCheckoutPage;
  final Function notifyViewAllAddress;
  const AddAddress({Key key, this.notifyCheckoutPage, this.notifyViewAllAddress}) : super(key: key);

  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final addressForm = GlobalKey<FormState>();
  Address address = Address();

  @override
  Widget build(BuildContext context) {
    return Consumer<Carts>(// List of Carts from Consumer.
        builder: (context, cart, child) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'اضافة عنوان جديد',
          style: TextStyle(fontFamily: 'Droid', color: Colors.black54),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[100],
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black54),
      ),
      body: ListView(children: [
        Directionality(textDirection: TextDirection.rtl, child: Form(
            key: addressForm,
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                  child: Image.network('https://freesvg.org/img/1392496432.png'),
                ),
                Container(
                  height: 100,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  //color: Colors.white,
                  alignment: Alignment.center,
                  child: const Text('اضف عنوانك الحالي',style: TextStyle(fontSize: 18, fontFamily: 'Droid'),),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  //color: Colors.redAccent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 150,
                        child: TextFormField(
                          textDirection: TextDirection.rtl,
                          maxLength: 8,
                          decoration: const InputDecoration(
                              hintText: ' المنطقة',
                              hintStyle: TextStyle(
                                fontFamily: 'Droid',
                              )),
                          validator: (value) {
                            if (value.isEmpty || value == null) {
                              return 'ادخل  اسم المنطقة';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            address.area = value;
                          },
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: TextFormField(
                            textDirection: TextDirection.rtl,
                            maxLength: 20,
                            decoration: const InputDecoration(
                                hintText: 'رقم القطعة',
                                hintStyle: TextStyle(
                                  fontFamily: 'Droid',
                                )),
                            validator: (value) {
                              if (value.isEmpty || value == null) {
                                return 'ادخل رقم القطعة';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              address.block = value;
                            }),
                      ),
                    ],),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  //color: Colors.redAccent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 150,
                        child: TextFormField(
                            textDirection: TextDirection.rtl,
                            maxLength: 30,
                            decoration: const InputDecoration(
                                hintText: 'رقم الشارع',
                                hintStyle: TextStyle(
                                  fontFamily: 'Droid',
                                )),
                            validator: (value) {
                              if (value.isEmpty || value == null) {
                                return 'ادخل رقم الشارع';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              address.street = value;
                            }),
                      ),
                      SizedBox(
                        width: 150,
                        child: TextFormField(
                            textDirection: TextDirection.rtl,
                            maxLength: 30,
                            decoration: const InputDecoration(
                                hintText: 'رقم المنزل',
                                hintStyle: TextStyle(
                                  fontFamily: 'Droid',
                                )),
                            validator: (value) {
                              if (value.isEmpty || value == null) {
                                return 'ادخل رقم المنزل';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              address.houseNumber = value;
                            }),
                      ),
                    ],),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  //color: Colors.redAccent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 150,
                        child: TextFormField(
                            textDirection: TextDirection.rtl,
                            maxLength: 30,
                            decoration: const InputDecoration(
                                hintText: 'رقم الجادة',
                                hintStyle: TextStyle(
                                  fontFamily: 'Droid',
                                )),
                            validator: (value) {
                              if (value.isEmpty || value == null) {
                                return 'ادخل رقم الجادة';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              address.jada = value;
                            }),
                      ),
                      SizedBox(
                        width: 150,
                        child: TextFormField(
                            textDirection: TextDirection.rtl,
                            maxLength: 30,
                            decoration: const InputDecoration(
                                hintText: 'الدور',
                                hintStyle: TextStyle(
                                  fontFamily: 'Droid',
                                )),
                            validator: (value) {
                              if (value.isEmpty || value == null) {
                                return 'ادخل رقم الدور';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              address.floor = value;
                            }),
                      ),
                    ],),
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 20)),

                TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(20.0),
                      backgroundColor: Colors.orange[400],
                    ),
                    child: const Text('اضافة العنوان الجديد',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Droid',
                            fontSize: 16)),
                    onPressed: () async {
                      if (addressForm.currentState.validate()) {
                        addressForm.currentState.save();
                        cart.addUserAddressProvider(address);
                        cart.user.defaultAddress = address;
                        cart.user.defaultAddress.userId = cart.user.id;
                        await newAddress(cart.user, address);
                        Navigator.pop(context, true);
                      }
                    })
              ],
            )))
      ],),
    );});
  }
}
