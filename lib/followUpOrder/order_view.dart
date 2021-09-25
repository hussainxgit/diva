import 'package:flutter/material.dart';
import 'package:diva/Models/order.dart';

class OrderView extends StatelessWidget {
  final Order orderDetails;

  const OrderView({this.orderDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'تحضير طلبك',
          style: TextStyle(fontFamily: 'Droid', color: Colors.black54),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[100],
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black54),
      ),
      body: ListView(children: [
        SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                orderDetails.id,
                style: const TextStyle(fontFamily: 'Droid', fontSize: 22),
              ),
              const Text(
                'توقيت الطلب : ١٠.١٥',
                style: TextStyle(fontFamily: 'Droid', fontSize: 22),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        margin: const EdgeInsets.all(10),
                        child: const Icon(Icons.delivery_dining),
                        decoration: BoxDecoration(
                            color: orderDetails.level == 'delivery'
                                ? Colors.orange[400]
                                : Colors.grey[200],
                            shape: BoxShape.circle),
                      ),
                      const Text('جاري توصيل الطلب',
                          style: TextStyle(fontFamily: 'Droid')),
                    ],
                  ),
                  Container(
                    color: Colors.grey,
                    child: Container(
                      width: 35,
                      height: 1,
                      padding: const EdgeInsets.all(10),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        margin: const EdgeInsets.all(10),
                        child: const Icon(Icons.fastfood_outlined),
                        decoration: BoxDecoration(
                            color: orderDetails.level == 'cooking' ||
                                    orderDetails.level == 'delivery'
                                ? Colors.orange[400]
                                : Colors.grey[200],
                            shape: BoxShape.circle),
                      ),
                      const Text('جاري تحضير الطلب',
                          style: TextStyle(fontFamily: 'Droid')),
                    ],
                  ),
                  Container(
                    color: Colors.grey,
                    child: Container(
                      width: 35,
                      height: 1,
                      padding: const EdgeInsets.all(10),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        margin: const EdgeInsets.all(10),
                        child: const Icon(Icons.done),
                        decoration: BoxDecoration(
                            color: orderDetails.level == 'new' ||
                                    orderDetails.level == 'cooking' ||
                                    orderDetails.level == 'delivery'
                                ? Colors.orange[400]
                                : Colors.grey[200],
                            shape: BoxShape.circle),
                      ),
                      const Text('تم استلام طلبك',
                          style: TextStyle(fontFamily: 'Droid')),
                    ],
                  ),
                ],
              ),
              const Divider(),
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'تفاصيل الطلب',
                    style: TextStyle(fontFamily: 'Droid', fontSize: 22),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: orderDetails.orderItems.length,
                      itemBuilder: (context, index) {
                        return Container(
                          color: Colors.grey[100],
                          margin: const EdgeInsets.only(top: 10, bottom: 10),
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                color: Colors.red,
                                child: Image.network(orderDetails
                                    .orderItems[index].productItem.image),
                              ),
                              orderDetails.orderItems[index].productItem.addons.isNotEmpty
                                  ? SizedBox(
                                      width: 50,
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: orderDetails
                                              .orderItems[index]
                                              .productItem
                                              .addons
                                              .length,
                                          itemBuilder: (context, i) {
                                            return Text(
                                              orderDetails.orderItems[index]
                                                  .productItem.addons[i].name,
                                              style: const TextStyle(
                                                  fontFamily: 'Droid'),
                                            );
                                          }),
                                    )
                                  : const Text(
                                      'لاتوجد اضافات',
                                      style: TextStyle(fontFamily: 'Droid'),
                                    ),
                              Text(
                                orderDetails
                                        .orderItems[index].productItem.name +
                                    'x ${orderDetails.orderItems[index].quantity}',
                                style: const TextStyle(fontFamily: 'Droid'),
                              ),
                            ],
                          ),
                        );
                      })),
            ],
          ),
        ),
      ]),
    );
  }
}
