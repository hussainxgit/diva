import 'package:flutter/material.dart';
import 'package:diva/Models/user.dart';
import 'package:diva/apiResponse.dart';
import 'package:diva/provider/cart.dart';
import 'package:provider/provider.dart';

class EditAddress extends StatefulWidget {
  final int addressIndex;

  const EditAddress({
    Key key,
    this.addressIndex,
  }) : super(key: key);

  @override
  _EditAddressState createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  final addressForm = GlobalKey<FormState>();
  int selectR = 0;
  Address updatedAddress = Address();

  @override
  Widget build(BuildContext context) {
    return Consumer<Carts>(// List of Carts from Consumer.
        builder: (context, cart, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'تعديل عنوان',
            style: TextStyle(fontFamily: 'Droid', color: Colors.black54),
          ),
          centerTitle: true,
          backgroundColor: Colors.grey[100],
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black54),
        ),
        body: ListView(
          children: [
            SizedBox(
              height: 200,
              child: Image(
                image: AssetImage('images/location.png'),
                width: 200,
              ),
            ),
            Container(
              height: 70,
              alignment: Alignment.center,
              child: Text(
                'تعديل العنوان',
                style: TextStyle(fontSize: 18, fontFamily: 'Droid'),
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Form(
                  key: addressForm,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: 150,
                              child: TextFormField(
                                textDirection: TextDirection.rtl,
                                maxLength: 30,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.amber),
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    hintText: cart
                                        .user.address[widget.addressIndex].area,
                                    hintStyle: TextStyle(
                                      fontFamily: 'Droid',
                                    )),
                                initialValue:
                                    cart.user.address[widget.addressIndex].area,
                                validator: (value) {
                                  if (value.isEmpty || value == null) {
                                    return 'ادخل  اسم المنطقة';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  updatedAddress.area = value;
                                },
                              ),
                            ),
                            SizedBox(
                              width: 150,
                              child: TextFormField(
                                  textDirection: TextDirection.rtl,
                                  maxLength: 30,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.amber),
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      hintText: cart.user
                                          .address[widget.addressIndex].block,
                                      hintStyle: TextStyle(
                                        fontFamily: 'Droid',
                                      )),
                                  initialValue: cart
                                      .user.address[widget.addressIndex].block,
                                  validator: (value) {
                                    if (value.isEmpty || value == null) {
                                      return 'ادخل رقم القطعة';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    updatedAddress.block = value;
                                  }),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: 150,
                              child: TextFormField(
                                  textDirection: TextDirection.rtl,
                                  maxLength: 30,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.amber),
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      hintText: cart.user
                                          .address[widget.addressIndex].street,
                                      hintStyle: TextStyle(
                                        fontFamily: 'Droid',
                                      )),
                                  initialValue: cart
                                      .user.address[widget.addressIndex].street,
                                  validator: (value) {
                                    if (value.isEmpty || value == null) {
                                      return 'ادخل رقم الشارع';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    updatedAddress.street = value;
                                  }),
                            ),
                            SizedBox(
                              width: 150,
                              child: TextFormField(
                                  textDirection: TextDirection.rtl,
                                  maxLength: 30,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.amber),
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      hintText: cart
                                          .user
                                          .address[widget.addressIndex]
                                          .houseNumber,
                                      hintStyle: TextStyle(
                                        fontFamily: 'Droid',
                                      )),
                                  initialValue: cart.user
                                      .address[widget.addressIndex].houseNumber,
                                  validator: (value) {
                                    if (value.isEmpty || value == null) {
                                      return 'ادخل رقم المنزل';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    updatedAddress.houseNumber = value;
                                  }),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: 150,
                              child: TextFormField(
                                  textDirection: TextDirection.rtl,
                                  maxLength: 30,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.amber),
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      hintText: cart.user
                                          .address[widget.addressIndex].jada,
                                      hintStyle: TextStyle(
                                        fontFamily: 'Droid',
                                      )),
                                  initialValue: cart
                                      .user.address[widget.addressIndex].jada,
                                  validator: (value) {
                                    if (value.isEmpty || value == null) {
                                      return 'ادخل رقم الجادة';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    updatedAddress.jada = value;
                                  }),
                            ),
                            SizedBox(
                              width: 150,
                              child: TextFormField(
                                  textDirection: TextDirection.rtl,
                                  maxLength: 30,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.amber),
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      hintStyle: TextStyle(
                                        fontFamily: 'Droid',
                                      )),
                                  initialValue: cart
                                      .user.address[widget.addressIndex].floor,
                                  validator: (value) {
                                    if (value.isEmpty || value == null) {
                                      return 'ادخل رقم الدور';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    updatedAddress.floor = value;
                                  }),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                          width: 300,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: CheckboxListTile(
                              title: Text(
                                "عنواني الافتراضي",
                                style: TextStyle(fontFamily: 'Droid'),
                              ),
                              value: cart.user.address[widget.addressIndex]
                                  .userDefault,
                              onChanged: (value) {
                                setState(() {
                                  updatedAddress.userDefault = !cart.user
                                      .address[widget.addressIndex].userDefault;
                                  cart.user.address[widget.addressIndex]
                                          .userDefault =
                                      !cart.user.address[widget.addressIndex]
                                          .userDefault;
                                });
                              },
                            ),
                          )),
                      Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                      TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.all(20.0),
                            backgroundColor: Colors.orange[400],
                          ),
                          child: Text('تعديل العنوان ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Droid',
                                  fontSize: 16)),
                          onPressed: () async {
                            if (addressForm.currentState.validate()) {
                              addressForm.currentState.save();
                              cart.updateUserAddressProvider(
                                  widget.addressIndex, updatedAddress);
                              await addressUpdate(cart.user, updatedAddress);
                              Navigator.pop(context);
                            }
                          })
                    ],
                  )),
            )
          ],
        ),
      );
    });
  }
}
