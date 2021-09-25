import 'package:flutter/material.dart';
import 'package:diva/followUpOrder/follow_order.dart';
import 'package:diva/provider/cart.dart';
import 'package:diva/support.dart';
import 'package:provider/provider.dart';
import '../profile.dart';
import '../settings.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key key}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool isSignIn;

  @override
  Widget build(BuildContext context) {
    return Consumer<Carts>(// List of Carts from Consumer.
        builder: (context, cart, child) {
      isSignIn = cart.user == null ? false : true;

      return Drawer(
        child: Column(
          children: <Widget>[
            Expanded(
                child: Column(
              children: [
                UserAccountsDrawerHeader(
                  accountName: isSignIn
                      ? Text(
                          cart.user.name,
                          style: const TextStyle(color: Colors.orange),
                        )
                      : const Text('Anonymous'),
                  accountEmail: isSignIn
                      ? Text(cart.user.email, style: const TextStyle(color: Colors.orange))
                      : const Text('مستخدم افتراضي',
                          style: TextStyle(
                              fontFamily: 'Droid', color: Colors.grey)),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                  ),
                  currentAccountPicture: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text(
                      "A",
                      style:
                          TextStyle(fontSize: 40.0, color: Colors.orangeAccent),
                    ),
                  ),
                ),
                ListTile(
                  title: const Text(
                    'ملفي الشخصي',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Droid',
                    ),
                  ),
                  leading: const Icon(Icons.supervised_user_circle_outlined),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Profile()));
                  },
                ),
                const Divider(),
                ListTile(
                  title: const Text(
                    'متابعة الطلبات',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Droid',
                    ),
                  ),
                  leading: const Icon(Icons.follow_the_signs),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FollowOrder(
                                  user: cart.user,
                                )));
                  },
                ),
                const Divider(),
                ListTile(
                  title: const Text(
                    'الدعم الفني',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Droid',
                    ),
                  ),
                  leading: const Icon(Icons.support),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Support()));
                  },
                ),
                const Divider(),
                ListTile(
                  title: const Text(
                    'الاعدادات',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Droid',
                    ),
                  ),
                  leading: const Icon(Icons.settings),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Settings()));
                  },
                ),
                const Divider(),
              ],
            )),
            Container(
              margin: const EdgeInsets.only(bottom: 30),
              child: isSignIn
                  ? ListTile(
                      title: const Text(
                        'تسجيل الخروج',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Droid',
                        ),
                      ),
                      leading: const Icon(Icons.logout),
                      onTap: () async {

                        isSignIn = false;
                        Navigator.of(context).pushNamed('login');
                      },
                    )
                  : ListTile(
                      title: const Text(
                        'تسجيل الدخول',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Droid',
                        ),
                      ),
                      leading: const Icon(Icons.logout),
                      onTap: () {
                        Navigator.of(context).pushNamed('login');
                      },
                    ),
            ),
          ],
        ),
      );
    });
  }
}
