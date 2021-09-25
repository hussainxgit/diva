import 'package:flutter/material.dart';
import 'Models/addOns.dart';
import 'package:provider/provider.dart';
import 'provider/cart.dart';
import 'Models/cartItem.dart';
import 'Models/product.dart';

class ProductSelect extends StatefulWidget {
  final Product passedProduct;

  const ProductSelect({this.passedProduct});

  @override
  _ProductSelectState createState() => _ProductSelectState(passedProduct);
}

class _ProductSelectState extends State<ProductSelect> {
  List checkBoxesHandle = []; // to add boxes .

  List<ProductAddons> checkBoxes = [];

  double addonsPrice = 0.0;
  int counter = 1; // number of orders = 1
  double totalPrice = 0.0;

  // Passing Details from main class
  Product passedProduct;

  _ProductSelectState(this.passedProduct);

  @override
  Widget build(BuildContext context) {
    double totalPriceFinal = (addonsPrice + passedProduct.price) * counter;

    return Consumer<Carts>(// List of Carts from Consumer.
        builder: (context, cart, child) {
      return Scaffold(
        backgroundColor: Color(0xFFF5F6F9),
        appBar: CustomAppBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Image.network(passedProduct.image,
                            fit: BoxFit.cover),
                      ),
                    ),
                    Container(
                      //height: 300,
                      margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35.0),
                          topRight: Radius.circular(35.0),
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: ListTile(
                                  title: Text(
                                    passedProduct.name,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontSize: 18, fontFamily: 'Droid'),
                                  ),
                                  subtitle: Text(passedProduct.description,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: "Droid",
                                          color: Colors.grey)),
                                  trailing: TextButton(
                                    onPressed: () {},
                                    child: Text(
                                        "KWD ${totalPriceFinal.toString()}"
                                            .toUpperCase(),
                                        style: TextStyle(
                                            fontSize: 14, fontFamily: "Droid")),
                                    style: ButtonStyle(
                                        padding:
                                            MaterialStateProperty.all<EdgeInsets>(
                                                EdgeInsets.all(5.0)),
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.lightGreen),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                                side: BorderSide(
                                                    color: Colors.lightGreen)))),
                                  ),
                                ),
                              )),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              width: 104,
                              decoration: BoxDecoration(
                                  color: Color(0xffffE6E6),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  )),
                              child: Row(
                                children: const [
                                  Text('60 Min'),
                                  Icon(Icons.delivery_dining),
                                ],
                              ),
                            ),
                          ),
                          Text('اضافات اختيارية',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Droid",
                                  color: Colors.grey)),
                          ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemCount: passedProduct.addons.length,
                            itemBuilder: (context, i) {
                              if (checkBoxesHandle.length <
                                  passedProduct.addons.length) {
                                checkBoxesHandle.add(false);
                              }
                              return Directionality(
                                textDirection: TextDirection.rtl,
                                child: CheckboxListTile(
                                  title: Text(passedProduct.addons[i].name,
                                      style: TextStyle(
                                          fontSize: 14, fontFamily: "Droid")),
                                  subtitle: passedProduct.addons[i].price != 0
                                      ? Text(
                                          passedProduct.addons[i].price
                                                  .toString() +
                                              " دك ",
                                          style: TextStyle(fontFamily: 'Droid'),
                                        )
                                      : Text('free'),
                                  value: checkBoxesHandle[i],
                                  onChanged: (bool value) {
                                    setState(() {
                                      checkBoxesHandle[i] =
                                          checkBoxesHandle[i] ? false : true;
                                      if (checkBoxesHandle[i]) {
                                        checkBoxes.add(passedProduct.addons[i]);
                                        addonsPrice +=
                                            passedProduct.addons[i].price;
                                      } else {
                                        checkBoxes
                                            .remove(passedProduct.addons[i]);
                                        if (addonsPrice > 0) {
                                          addonsPrice -=
                                              passedProduct.addons[i].price;
                                        }
                                      }
                                    });
                                  },
                                ),
                              );
                            },
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: TextField(
                                maxLines: 1,
                                maxLength: 60,
                                textAlign: TextAlign.right,
                                decoration: InputDecoration.collapsed(
                                    hintText: "اضف ملاحطاتك ..",
                                    hintStyle: TextStyle(fontFamily: 'Droid')),
                                onChanged: (value) {
                                  if (value != null) {
                                    passedProduct.notes = value;
                                  } else {
                                    passedProduct.notes = " ";
                                  }
                                }),
                          ),
                          Divider(),
                          SizedBox(
                            height: 100,
                            width: 300,
                            //color: Colors.lightGreen,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 60,
                                  margin: EdgeInsets.all(5),
                                  child: OutlinedButton(
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.black54,
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      shape: CircleBorder(),
                                      side: BorderSide(
                                          width: 1, color: Colors.black54),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        if (counter < 20) {
                                          counter++;
                                        }
                                      });
                                    },
                                  ),
                                ),
                                Text(
                                  '$counter',
                                  style: TextStyle(fontSize: 22),
                                ),
                                Container(
                                  height: 60,
                                  margin: EdgeInsets.all(5),
                                  child: OutlinedButton(
                                    child: Icon(
                                      Icons.remove,
                                      color: Colors.black54,
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      shape: CircleBorder(),
                                      side: BorderSide(
                                          width: 1, color: Colors.black54),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        if (counter > 1) {
                                          counter--;
                                        } else {
                                          counter = 1;
                                        }
                                      });
                                    },
                                  ),
                                ),
                                Text(
                                  ': العدد ',
                                  style: TextStyle(
                                      fontSize: 18, fontFamily: 'Droid'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )),
          ],
        ),
        bottomNavigationBar: SizedBox(
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 15.0, 0, 0),
            //width: double.infinity,
            height: 110,
            child: ElevatedButton(
              child: Text(
                'أكمل الطلب ( ${totalPriceFinal.toString()} دك )',
                style: TextStyle(fontSize: 20, fontFamily: "Droid"),
              ),
              onPressed: () {
                Product product = Product(
                    id: passedProduct.id,
                    name: passedProduct.name,
                    description: passedProduct.description,
                    image: passedProduct.image,
                    price: passedProduct.price,
                    addons: checkBoxes);
                Item item = Item(productItem: product, quantity: counter);
                cart.add(item);
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              style: ElevatedButton.styleFrom(primary: Colors.lightGreen),
            ),
          ),
        ),
      );
    });
  }
}

// Calling Custom Class
class CustomAppBar extends PreferredSize {
  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipOval(
              child: Material(
                color: Colors.white, // button color
                child: InkWell(
                  splashColor: Colors.red, // inkwell color
                  child: SizedBox(
                      width: 56,
                      height: 56,
                      child: Icon(Icons.arrow_back_outlined)),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular((14)),
                color: Colors.white,
              ),
              child: Row(
                children: const [
                  Text(
                    "4.5",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
