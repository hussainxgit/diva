import 'package:flutter/material.dart';
import 'package:diva/address/address.dart';
import 'package:diva/apiResponse.dart';
import 'package:diva/Models/user.dart';
import 'package:diva/address/editAddress.dart';
import 'package:diva/provider/cart.dart';
import 'package:provider/provider.dart';

class ViewAllAddress extends StatefulWidget {
  @override
  _ViewAllAddressState createState() => _ViewAllAddressState();
}

class _ViewAllAddressState extends State<ViewAllAddress> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Carts>(// List of Carts from Consumer.
        builder: (context, cart, child) {
      return Scaffold(
          appBar: AppBar(
            title: Text(
              'اختر العنوان المناسب',
              style: TextStyle(fontFamily: 'Droid', color: Colors.black54),
            ),
            centerTitle: true,
            backgroundColor: Colors.grey[100],
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black54),
          ),
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            children: [
              SizedBox(
                child: Image(
                  image: AssetImage('images/delivery.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                height: 70,
                alignment: Alignment.center,
                child: Text(
                  'قائمة العناوين الخاصة بك',
                  style: TextStyle(fontSize: 18, fontFamily: 'Droid'),
                ),
              ),
              Container(
                  color: Colors.white,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: cart.user.address.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          background: Container(
                            color: Colors.red,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              alignment: Alignment.centerRight,
                              child: Text(
                                'حذف العنوان',
                                style: TextStyle(
                                    fontFamily: 'Droid', color: Colors.white),
                              ),
                            ),
                          ),
                          onDismissed: (direction) {
                            setState(() {
                              Address removedAddress = cart.user.address[index];
                              cart.removeUserAddressProvider(removedAddress);
                              addressRemove(removedAddress, cart.user);
                            });
                          },
                          key: ValueKey<Address>(cart.user.address[index]),
                          child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      cart.user.address[index].area,
                                      style: TextStyle(
                                          fontFamily: 'Droid', fontSize: 14),
                                    ),
                                    subtitle: Row(
                                      children: [
                                        Text(
                                          " ق " +
                                              cart.user.address[index].block,
                                          style: TextStyle(
                                              fontFamily: 'Droid',
                                              fontSize: 14),
                                        ),
                                        Text(
                                          " ش " +
                                              cart.user.address[index].street,
                                          style: TextStyle(
                                              fontFamily: 'Droid',
                                              fontSize: 14),
                                        ),
                                        Text(
                                          " ج " + cart.user.address[index].jada,
                                          style: TextStyle(
                                              fontFamily: 'Droid',
                                              fontSize: 14),
                                        ),
                                        Text(
                                          " د " +
                                              cart.user.address[index].floor,
                                          style: TextStyle(
                                              fontFamily: 'Droid',
                                              fontSize: 14),
                                        ),
                                        Text(
                                          " م " +
                                              cart.user.address[index]
                                                  .houseNumber,
                                          style: TextStyle(
                                              fontFamily: 'Droid',
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                    leading:
                                        Icon(Icons.location_history_outlined),
                                    trailing: cart
                                            .user.address[index].userDefault
                                        ? Icon(
                                            Icons.location_on,
                                            color: Colors.orange,
                                          )
                                        : Padding(padding: EdgeInsets.all(0)),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => EditAddress(
                                                  addressIndex:index,
                                                )),
                                      );
                                    },
                                  ),
                                  Divider()
                                ],
                              )),
                        );
                      })),
              SizedBox(
                height: 60,
                child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddAddress()));
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.orange[400],
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    child: Text(
                      'اضف عنوان جديد',
                      style: TextStyle(fontFamily: 'Droid', fontSize: 16),
                    )),
              )
            ],
          ));
    });
  }
}
