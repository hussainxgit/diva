import 'package:flutter/material.dart';
import 'package:diva/followUpOrder/order_view.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
import 'Models/order.dart';
import 'address/view_all_address.dart';
import 'address/address.dart';
import 'Models/cart_item.dart';
import 'provider/cart.dart';
import 'Models/user.dart';
import 'api_response.dart';
import 'package:provider/provider.dart';
import 'customWidgets/alert_dialog.dart';

class CheckOut extends StatefulWidget {
  final List<Item> orderItems;

  const CheckOut({@required this.orderItems});

  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  double totalPrice = 0;
  bool paymentStatus = false;
  String paymentErrorMsg = "";
  List array = [];

  @override
  void initState() {
    super.initState();
    MFSDK.init('https://apitest.myfatoorah.com/',
        'j4lc68ycMg3Vk30apbsbLnGWMtWbLXzRGilTN4l8ZTz6qlZ5SI7SYZbrRdjtI5FuRWz3lg6jnCV15VBU9cFhA_pRo4qiQCyZtTdjaAkN2QOq-TOWRuj81B6dVbP4DR-nhs4c_KVsYqfHmHcqb3hVS9Aymc771P_e13LU4X_Zd3bKyVY_L9WWBQ3bQtK-gAHpn9RVoVioQo1g_ZaaAiV4GP8scxfEMy02uN-OvcRGXExThTanoqwKwXgzU9dxJQteD0vbgVfeVbtzoWIjnroB2oPQuE_PZtG1ljdq0r5jFJp3fREVJEa2K8DjkMIo0KHavlPBClW11HyBYsnmGxVjXGFMeXVFRrXosl9KudRR8s98QusPDcbP1e4oDv3iJo8bYMDAT8F327FGBjGdonzNsaOIvfzCMdI-jpxaZ7wh5eO-KTTNX4N5xP6Vp0CShkhPTT16z84JFQvnzaJ6nRtYJ6w9AJbi3WghON9x350OIaR0ffThTrincoBGo_0szIj-TcyZhNAT4RRRd01gEm3O6d-qeDVL6xhVKYh9g8Op1AWBB5q5oWlPD8VSRHsWzR7Z05RdPK8qKOXaoA9iQBpo9HS_qddqF9KCyOvy9fhOtYOxdLYv5NpbefMAGfLl87NzjBxCUfKR5KPnGg3Jibv6xSk500KIo_xoKQvcsAo5PvEGvUcQ');
  }

  pay(Carts cart, User user) {
    // The value 1 is the paymentMethodId of KNET payment method.
    // You should call the "initiatePayment" API to can get this id and the ids of all other payment methods
    int paymentMethod = 1;
    var request = MFExecutePaymentRequest(paymentMethod, cart.totalPrice);
    MFSDK.setUpAppBar(isShowAppBar: false);
    MFSDK.executePayment(
        context,
        request,
        MFAPILanguage.EN,
        (String invoiceId, MFResult<MFPaymentStatusResponse> result) => {
              if (result.isSuccess())
                {
                  placeOrder(
                          Order(
                              userAddress: cart.user.getDefaultAddress(),
                              userId: cart.user.id,
                              orderItems: cart.basketItems),
                          context)
                      .then((value) {
                    if (value != null) {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      OrderView(orderDetails: value)))
                          .whenComplete(() => cart.clearBasket());
                    }
                  })
                }
              else
                {
                  showDialog(
                      context: context,
                      builder: (_) =>
                          messageDialog(context, result.error.message))
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Carts>(builder: (context, cart, child) {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text(
            'خطوات اكمال الطلب',
            style: TextStyle(
                fontSize: 18, fontFamily: 'Droid', color: Colors.black54),
          ),
          centerTitle: true,
          backgroundColor: Colors.grey[100],
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black54),
        ),
        body: ListView(
          children: [
            Container(
              margin: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    child: Column(
                      children: [
                        const Image(
                          image: AssetImage('images/delivery.jpg'),
                          fit: BoxFit.cover,
                        ),
                        cart.isSignedIn == true && cart.user.address.isNotEmpty
                            ? cart.user.getDefaultAddress() == null
                                ? Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Icon(
                                          Icons.location_on,
                                          color: Colors.orangeAccent,
                                          size: 33,
                                        ),
                                        Column(
                                          //mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            const Text(
                                              "لم تحدد لك عنوان افتراضي",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: 'Droid'),
                                            ),
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.orange,
                                                  primary: Colors.white),
                                              child: const Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 5, right: 15),
                                                  child: Center(
                                                      child: Text(
                                                    "اختر عنوان",
                                                    style: TextStyle(
                                                        fontFamily: 'Droid',
                                                        fontSize: 16),
                                                  ))),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const ViewAllAddress()),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Icon(
                                          Icons.location_on,
                                          color: Colors.orangeAccent,
                                          size: 33,
                                        ),
                                        Column(
                                          //mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              cart.user
                                                  .getDefaultAddress()
                                                  .area,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'Droid',
                                                  color: Colors.grey),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  cart.user
                                                      .getDefaultAddress()
                                                      .houseNumber,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: 'Droid',
                                                      color: Colors.grey),
                                                ),
                                                const Text(
                                                  'شقة',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: 'Droid',
                                                      color: Colors.grey),
                                                ),
                                                Text(
                                                  cart.user
                                                      .getDefaultAddress()
                                                      .floor,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: 'Droid',
                                                      color: Colors.grey),
                                                ),
                                                const Text(
                                                  'دور',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: 'Droid',
                                                      color: Colors.grey),
                                                ),
                                                Text(
                                                  cart.user
                                                      .getDefaultAddress()
                                                      .houseNumber,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: 'Droid',
                                                      color: Colors.grey),
                                                ),
                                                const Text(
                                                  'منزل',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: 'Droid',
                                                      color: Colors.grey),
                                                ),
                                                Text(
                                                  cart.user
                                                      .getDefaultAddress()
                                                      .jada,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: 'Droid',
                                                      color: Colors.grey),
                                                ),
                                                const Text(
                                                  'جادة',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: 'Droid',
                                                      color: Colors.grey),
                                                ),
                                                Text(
                                                  cart.user
                                                      .getDefaultAddress()
                                                      .street,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: 'Droid',
                                                      color: Colors.grey),
                                                ),
                                                const Text(
                                                  'شارع',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: 'Droid',
                                                      color: Colors.grey),
                                                ),
                                                Text(
                                                  cart.user
                                                      .getDefaultAddress()
                                                      .block,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: 'Droid',
                                                      color: Colors.grey),
                                                ),
                                                const Text(
                                                  'ق',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: 'Droid',
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            ),
                                            InkWell(
                                              child: const Text(
                                                'تغيير',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: 'Droid',
                                                    color: Colors.orange),
                                              ),
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const ViewAllAddress()));
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                            : Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      color: Colors.orangeAccent,
                                      size: 33,
                                    ),
                                    Column(
                                      //mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        const Text(
                                          "لايوجد عنوان مسجل مسبقاً",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'Droid'),
                                        ),
                                        TextButton(
                                          style: TextButton.styleFrom(
                                              backgroundColor: Colors.red,
                                              primary: Colors.white),
                                          child: const Padding(
                                              padding: EdgeInsets.only(
                                                  left: 5, right: 15),
                                              child: Center(
                                                  child: Text(
                                                "اضف عنوان",
                                                style: TextStyle(
                                                    fontFamily: 'Droid',
                                                    fontSize: 16),
                                              ))),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const AddAddress()),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Container(
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Icon(
                            Icons.delivery_dining,
                            color: Colors.white,
                          ),
                        ),
                        Text('مدة التوصيل 60 دقيقة',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Droid',
                              color: Colors.white,
                            )),
                      ],
                    ),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        color: Colors.orange[400]),
                  ),
                  const Divider(),
                  Column(
                    children: [
                      const Text('ملخص الدفع',
                          style: TextStyle(fontSize: 18, fontFamily: 'Droid')),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Text(' طلب  ',
                                  style: TextStyle(
                                      fontSize: 14, fontFamily: 'Droid')),
                              Text(widget.orderItems.length.toString(),
                                  style: const TextStyle(
                                      fontSize: 14, fontFamily: 'Droid')),
                            ],
                          ),
                          const Text('مجموع الطلبات',
                              style:
                                  TextStyle(fontSize: 14, fontFamily: 'Droid')),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              Text(' دك  ',
                                  style: TextStyle(
                                      fontSize: 14, fontFamily: 'Droid')),
                              Text('0.5',
                                  style: TextStyle(
                                      fontSize: 14, fontFamily: 'Droid')),
                            ],
                          ),
                          const Text('رسوم التوصيل',
                              style:
                                  TextStyle(fontSize: 14, fontFamily: 'Droid')),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Text(' دك  ',
                                  style: TextStyle(
                                      fontSize: 14, fontFamily: 'Droid')),
                              Text(cart.totalPrice.toString(),
                                  style: const TextStyle(
                                      fontSize: 14, fontFamily: 'Droid')),
                            ],
                          ),
                          const Text('المبلغ الاجمالي',
                              style:
                                  TextStyle(fontSize: 14, fontFamily: 'Droid')),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
          height: 100,
          color: Colors.grey[200],
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              shadowColor: null,
              primary: Colors.red, // background
              onPrimary: Colors.white, // foreground
            ),
            onPressed: () async {
              if (cart.user != null) {
                if (cart.user.address.isEmpty) {
                  showDialog(
                      context: context,
                      builder: (_) =>
                          messageDialog(context, "user address not found"));
                } else {
                  pay(cart, cart.user);
                }
              } else {
                showDialog(
                    context: context,
                    builder: (_) => messageDialog(context, "user not found"));
              }
            },
            child: const Text(
              'تنفيذ الطلب',
              style: TextStyle(fontFamily: 'Droid', fontSize: 18),
            ),
          ),
        ),
      );
    });
  }
}
