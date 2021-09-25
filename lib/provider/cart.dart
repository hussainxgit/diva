import 'package:flutter/cupertino.dart';
import 'package:diva/Models/cartItem.dart';
import 'package:diva/Models/user.dart';

class Carts extends ChangeNotifier {
  final List<Item> _items = [];
  double _totalPrice = 0.0;
  User user;
  bool isSignedIn = false;

  void add(Item item) {
    _items.add(item);
    _totalPrice += item.getTotalItemPrice;
    notifyListeners();
  }

  void remove(Item item) {
    _items.remove(item);
    _totalPrice -= item.getTotalItemPrice;
    notifyListeners();
  }

  int get count {
    return _items.length;
  }

  double get totalPrice {
    return _totalPrice;
  }

  List<Item> get basketItems {
    return _items;
  }

  void clearBasket(){
    _totalPrice = 0.0;
    _items.clear();
    notifyListeners();
  }

  void saveUserInProvider(User user){
    this.user = user;
    isSignedIn = true;
    notifyListeners();
  }

  void logOutUserInProvider(){
    user = null;
    isSignedIn = false;
    notifyListeners();
  }

  void removeUserAddressProvider(Address address){
    user.address.remove(address);
    notifyListeners();
  }

  void addUserAddressProvider(Address address){
    user.address.add(address);
    notifyListeners();
  }

  void updateUserAddressProvider(int addressIndex, Address address){
    user.address[addressIndex] = address;
    notifyListeners();
  }

}
