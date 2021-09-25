import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/cart.dart';
import 'checkout.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> jsonList = [];

    return Consumer<Carts>(builder: (context, cart, child) {
      return Center(
          child: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: cart.basketItems.length,
                itemBuilder: (context, i) {
                  jsonList.add(cart.basketItems[i].toJson());
                  return Container(
                    margin: const EdgeInsets.all(10.0),
                    color: Colors.grey[200],
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          color: Colors.lightGreen,
                          child: Image.network(
                            cart.basketItems[i].productItem.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                            height: 100,
                            width: 100,
                            //color: Colors.redAccent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  cart.basketItems[i].getTotalItemPrice
                                          .toString() +
                                      " KWD",
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontFamily: 'Droid',
                                      fontSize: 14,
                                      color: Colors.green),
                                ),
                                TextButton(
                                  child: const Text(
                                    'حذف',
                                    style: TextStyle(
                                        fontFamily: 'Droid', fontSize: 12),
                                  ),
                                  style: ButtonStyle(
                                      padding:
                                          MaterialStateProperty.all<EdgeInsets>(
                                              EdgeInsets.all(5.0)),
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.red),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                              side: BorderSide(
                                                  color: Colors.red)))),
                                  onPressed: () {
                                    cart.remove(cart.basketItems[i]);
                                  },
                                ),
                              ],
                            )),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "${cart.basketItems[i].quantity} x " +
                                      cart.basketItems[i].productItem.name,
                                  style: TextStyle(
                                      fontFamily: 'Droid',
                                      fontSize: 14,
                                      color: Colors.grey[700]),
                                ),
                                SizedBox(
                                  height: 50,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: cart.basketItems[i].productItem
                                          .addons.length,
                                      itemBuilder: (context, index) {
                                        return Text(
                                          " : " +
                                              cart.basketItems[i].productItem
                                                  .addons[index].name,
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              fontFamily: 'Droid',
                                              fontSize: 12,
                                              color: Colors.grey[500]),
                                        );
                                      }),
                                ),
                                SizedBox(
                                    height: 25,
                                    child: Text(
                                      cart.basketItems[i].productItem.notes,
                                      style: TextStyle(
                                        fontFamily: 'Droid',
                                        fontSize: 12,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
          Divider(),
          Container(
            height: 100,
            color: Colors.grey[100],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                cart.basketItems.isNotEmpty ? SizedBox(
                  width: 150,
                  child: TextButton(
                    onPressed: () {
                      //print(jsonList);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CheckOut(orderItems: cart.basketItems)));
                    },
                    child: const Text(
                      'تنفيذ الطلب',
                      style: TextStyle(fontFamily: 'Droid', fontSize: 16),
                    ),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.all(5.0)),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.green),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.green)))),
                  ),
                )
                    : SizedBox(
                  width: 150,
                  child: TextButton(
                    onPressed: () {
                      //print(jsonList);
                    },
                    child: const Text(
                      'لاتوجد طلبات',
                      style: TextStyle(fontFamily: 'Droid', fontSize: 16),
                    ),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(5.0)),
                        foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.orange),
                        shape:
                        MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.orange)))),
                  ),
                ),
                Text(
                  "KWD " ' المجموع' " " + cart.totalPrice.toString(),
                  style: const TextStyle(
                      fontSize: 16, fontFamily: 'Droid', color: Colors.black54),
                ),
              ],
            ),
          )
        ],
      ));
    });
  }
}
// Text(cart.basketItems.length > 0 ?  cart.basketItems[0].name : "No items")
