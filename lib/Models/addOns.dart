class ProductAddons {
  int id;
  String name;
  double price;
  String productId;

  ProductAddons({this.id, this.name, this.price, this.productId});

  ProductAddons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    productId = json['productId'];
  }

  ProductAddons.fromFirebase(Map<String, dynamic> json) {
    name = json['name'];
    //add 0.0, to convert it from int to double
    price = json['price'] + 0.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['productId'] = productId;
    return data;
  }

  Map<String, dynamic> toFirebaseJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['price'] = price;
    return data;
  }

}
