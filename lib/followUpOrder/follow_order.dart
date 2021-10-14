import 'package:flutter/material.dart';
import 'package:diva/Models/order.dart';
import 'package:diva/followUpOrder/order_view.dart';
import '../Models/user.dart';
import '../services/api_response.dart';

class FollowOrder extends StatefulWidget {
  final User user;

  const FollowOrder({@required this.user});

  @override
  _FollowOrderState createState() => _FollowOrderState(user);
}

class _FollowOrderState extends State<FollowOrder> {
  User user;

  _FollowOrderState(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'قائمة الطلبيات',
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
                'قائمة الطلبيات (قيد الانتظار) الخاصة بك',
                style: TextStyle(fontSize: 18, fontFamily: 'Droid'),
              ),
            ),
            Container(
              color: Colors.white,
              child: FutureBuilder<List<Order>>(
                  future: getUserPendingOrders(user.id),
                  builder: (context, AsyncSnapshot<List<Order>>snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          physics:const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Dismissible(
                              background: Container(
                                color: Colors.red,
                                child: Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 20),
                                  alignment: Alignment.centerRight,
                                  child: const Text(
                                    'الغاء الطلب',
                                    style: TextStyle(
                                        fontFamily: 'Droid',
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              onDismissed: (direction) {
                              },
                              key: ValueKey<Order>(snapshot.data[index]),
                              child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: Text(
                                          snapshot.data[index].orderItems[0].productItem.name,
                                          style: const TextStyle(
                                              fontFamily: 'Droid',
                                              fontSize: 14),
                                        ),
                                        leading: const Icon(
                                            Icons.location_history_outlined),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    OrderView(orderDetails: snapshot.data[index])),
                                          );
                                        },
                                      ),
                                      const Divider()
                                    ],
                                  )),
                            );
                          });
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return Center(
                        child: Container(
                            height: 50,
                            width: 50,
                            margin: const EdgeInsets.all(10),
                            child: const CircularProgressIndicator(
                              backgroundColor: Colors.orange,
                            )));
                  }),
            ),
          ],
        ));
  }
}
