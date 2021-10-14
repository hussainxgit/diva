import 'package:flutter/material.dart';
import 'package:diva/address/address.dart';
import 'package:diva/services/api_response.dart';
import 'package:diva/Models/user.dart';
import 'package:diva/address/edit_address.dart';
import 'package:diva/provider/cart.dart';
import 'package:provider/provider.dart';

class ViewAllAddress extends StatefulWidget {
  const ViewAllAddress({Key key}) : super(key: key);

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
            title: const Text(
              'اختر العنوان المناسب',
              style: TextStyle(fontFamily: 'Droid', color: Colors.black54),
            ),
            centerTitle: true,
            backgroundColor: Colors.grey[100],
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black54),
          ),
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            children: [
              const SizedBox(
                child: Image(
                  image: AssetImage('images/delivery.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                height: 70,
                alignment: Alignment.center,
                child: const Text(
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
                              margin: const EdgeInsets.symmetric(horizontal: 20),
                              alignment: Alignment.centerRight,
                              child: const Text(
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
                                      style: const TextStyle(
                                          fontFamily: 'Droid', fontSize: 14),
                                    ),
                                    subtitle: Row(
                                      children: [
                                        Text(
                                          " ق " +
                                              cart.user.address[index].block,
                                          style: const TextStyle(
                                              fontFamily: 'Droid',
                                              fontSize: 14),
                                        ),
                                        Text(
                                          " ش " +
                                              cart.user.address[index].street,
                                          style: const TextStyle(
                                              fontFamily: 'Droid',
                                              fontSize: 14),
                                        ),
                                        Text(
                                          " ج " + cart.user.address[index].jada,
                                          style: const TextStyle(
                                              fontFamily: 'Droid',
                                              fontSize: 14),
                                        ),
                                        Text(
                                          " د " +
                                              cart.user.address[index].floor,
                                          style: const TextStyle(
                                              fontFamily: 'Droid',
                                              fontSize: 14),
                                        ),
                                        Text(
                                          " م " +
                                              cart.user.address[index]
                                                  .houseNumber,
                                          style: const TextStyle(
                                              fontFamily: 'Droid',
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                    leading:
                                        const Icon(Icons.location_history_outlined),
                                    trailing: cart
                                            .user.address[index].userDefault
                                        ? const Icon(
                                            Icons.location_on,
                                            color: Colors.orange,
                                          )
                                        : const Padding(padding: EdgeInsets.all(0)),
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
                                  const Divider()
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
                              builder: (context) => const AddAddress()));
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.orange[400],
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    child: const Text(
                      'اضف عنوان جديد',
                      style: TextStyle(fontFamily: 'Droid', fontSize: 16),
                    )),
              )
            ],
          ));
    });
  }
}
