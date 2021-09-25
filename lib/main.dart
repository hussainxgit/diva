import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'address/ViewAllAddress.dart';
import 'followUpOrder/followOrder.dart';
import 'login/login.dart';
import 'login/signup.dart';
import 'homePage.dart';
import 'offers.dart';
import 'selectCategory.dart';
import 'cart.dart';
import 'provider/cart.dart';
import 'package:provider/provider.dart';
import 'customWidgets/customDrawer.dart';
import 'checkout.dart';
import 'address/address.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(ChangeNotifierProvider(
    create: (context) => Carts(),
    child: MaterialApp(
      initialRoute: 'login',
      routes: {
        'MyApp': (context) => MyApp(),
        'home': (context) => HomePage(),
        'selectCategory': (context) => SelectCategoryItems(),
        'login': (context) => LoginPage(),
        'signUp': (context) => SignUpPage(),
        'checkout': (context) => CheckOut(),
        'address': (context) => AddAddress(),
        'viewaddress': (context) => ViewAllAddress(),
        'followOrder': (context) => FollowOrder(),
      },
      debugShowCheckedModeBanner: false,
    ),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedPage = 0;
  Widget currentScreen;
  final _pageOptions = [
    HomePage(),
    OffersPage(),
    CartPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<Carts>(builder: (context, cart, child) {
      return Scaffold(
        endDrawer: CustomDrawer(),
        appBar: AppBar(
          title: const Text(
            'ديفــا',
            style: TextStyle(
                color: Colors.black45, fontFamily: 'Droid', fontSize: 20),
          ),
          leading: SizedBox(
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
                            icon: const Icon(
                              Icons.shopping_bag_outlined,
                              color: Colors.black54,
                            ),
                            onPressed: () {
                              setState(() {
                                _selectedPage = 2;
                              });
                            },
                          ),
                          cart.basketItems.isEmpty
                              ? Container()
                              : Positioned(
                                  child: Stack(
                                  children: <Widget>[
                                    Icon(Icons.brightness_1,
                                        size: 20.0, color: Colors.orange[800]),
                                    Positioned(
                                        top: 3.0,
                                        right: 6.0,
                                        child: Center(
                                          child: Text(
                                            cart.basketItems.length.toString(),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 11.0,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        )),
                                  ],
                                )),
                        ],
                      ),
                    )),
              )),
          //iconTheme: IconThemeData(color: Colors.black45),
          actions: [
            Builder(
                builder: (BuildContext context) => IconButton(
                      onPressed: () => Scaffold.of(context).openEndDrawer(),
                      icon: const Icon(Icons.menu),
                      color: Colors.black45,
                    ))
          ],
          elevation: 0.0,
          backgroundColor: Colors.grey[100],
        ),
        body: IndexedStack(
          index: _selectedPage,
          children: _pageOptions,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedPage,
          onTap: (int index) {
            setState(() {
              _selectedPage = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: "الرئيسية",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_offer_outlined),
              label: "العروض",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined),
              label: "الطلبات",
            ),
          ],
          selectedLabelStyle: TextStyle(fontSize: 16, fontFamily: 'Droid'),
          selectedItemColor: Colors.orangeAccent,
          unselectedLabelStyle: TextStyle(fontSize: 14, fontFamily: 'Droid'),
        ),
      );
    });
  }

  void onTabTapped(int index) {
    setState(() {
      _selectedPage = index;
    });
  }
}
