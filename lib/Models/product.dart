import 'package:diva/Models/add_ons.dart';

class Product {
  String id;
  String name;
  String description;
  String image;
  double price;
  String catId;
  int totalSales;
  List<ProductAddons> addons = [];
  String notes;

  Product(
      {this.id,
      this.name,
      this.description,
      this.image,
      this.price,
      this.catId,
      this.notes,
      this.totalSales,
      this.addons}) {
    addons ??= [];
    notes ??= "لايوجد ملاحظات";
  }

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    price = json['price'];
    catId = json['catId'].toString();
    totalSales = json['totalSales'] == null ? 0 : int.parse(json['totalSales']);
    notes = json['notes'];
    if (json['addons'] != null) {
      for (var addon in json['addons']) {
        addons.add(ProductAddons.fromJson(addon));
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['image'] = image;
    data['price'] = price;
    data['catId'] = catId;
    data['totalSales'] = totalSales;
    data['addons'] = addonsToJson(addons);
    data['notes'] = notes;
    return data;
  }

  List<Map<String, dynamic>> addonsToJson(List<ProductAddons> addons) {
    List<Map<String, dynamic>> data = [];
    for (var addon in addons) {
      data.add(addon.toJson());
    }
    return data;
  }

  Map<String, dynamic> toFirebaseJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['image'] = image;
    data['price'] = price;
    data['catId'] = catId;
    data['totalSales'] = totalSales;
    data['addons'] = addonsToFirebaseJson(addons);
    data['notes'] = notes;
    return data;
  }

  Product.fromFirebase(Map<String, dynamic> json, String uid) {
    id = uid;
    name = json['name'];
    description = json['description'];
    image = json['image'];
    catId = json['catId'];
    notes = json['notes'];
    price = json['price'];
    if (json['addons'] != null) {
      for (var addon in json['addons']) {
        addons.add(ProductAddons.fromFirebase(addon));
      }
    }
  }

  List<Map<String, dynamic>> addonsToFirebaseJson(List<ProductAddons> addons) {
    List<Map<String, dynamic>> data = [];
    for (var addon in addons) {
      data.add(addon.toFirebaseJson());
    }
    return data;
  }

  double get getTotalPrice {
    double price = 0;
    price += this.price;
    if (addons.isNotEmpty) {
      for (var addon in addons) {
        price += addon.price;
      }
    }
    return price;
  }
}
