import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:diva/provider/cart.dart';

class CustomAppBar extends PreferredSize {
  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return Consumer<Carts>(builder: (context, cart, child) {
      return SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
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
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                              height: 150.0,
                              width: 30.0,
                              child: GestureDetector(
                                onTap: () {
                                  cart.basketItems.length.toString();
                                },
                                child: Stack(
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(
                                        Icons.shopping_cart,
                                        color: Colors.black54,
                                      ),
                                      onPressed: () {},
                                    ),
                                    cart.basketItems.isEmpty
                                        ? Container()
                                        : Positioned(
                                            child: Stack(
                                            children: <Widget>[
                                              Icon(Icons.brightness_1,
                                                  size: 20.0,
                                                  color: Colors.orange[800]),
                                              Positioned(
                                                  top: 3.0,
                                                  right: 6.0,
                                                  child: Center(
                                                    child: Text(
                                                      cart.basketItems.length
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 11.0,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  )),
                                            ],
                                          )),
                                  ],
                                ),
                              )),
                        )),
                    onTap: () {
                      //Navigator.pop(context);
                    },
                  ),
                ),
              ),
              // FutureBuilder(
              //   future: getSettingsData(),
              //   builder: (context, settings) {
              //     if (settings.hasData) {
              //       return Text(
              //         settings.data[0].appName,
              //         style: TextStyle(
              //             fontFamily: 'Droid',
              //             fontSize: 22,
              //             color: Colors.black54),
              //       );
              //     } else if (settings.hasError) {
              //       return Text("${settings.error}");
              //     } else if (settings.hasError) {
              //       return Text("${settings.error}");
              //     }
              //
              //     // By default, show a loading spinner.
              //     return new Container(
              //       height: 60.0,
              //       child: new Center(
              //           child: new CircularProgressIndicator(
              //         backgroundColor: Colors.grey,
              //       )),
              //     );
              //   },
              // ),
              ClipOval(
                child: Material(
                  color: Colors.white, // button color
                  child: InkWell(
                    splashColor: Colors.red, // inkwell color
                    child: SizedBox(
                      width: 56,
                      height: 56,
                      child: Icon(Icons.category, color: Colors.black54),
                    ),
                    onTap: () {
                      //Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
