import 'package:diva/Models/product.dart';

class Item {
  int quantity;
  Product productItem;

  Item({this.productItem, this.quantity});

  double get getTotalItemPrice {
    double price = productItem.getTotalPrice * quantity;

    return price;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['quantity'] = quantity;
    data['productItem'] = productItem.toJson();
    return data;
  }

  Item.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    productItem = Product.fromJson(json['productItem']);
  }

  Map<String, dynamic> toFirebaseJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['quantity'] = quantity;
    data['productItem'] = productItem.toFirebaseJson();
    return data;
  }
}
