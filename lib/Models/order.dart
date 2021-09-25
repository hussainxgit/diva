import 'dart:convert';
import 'package:diva/Models/cartItem.dart';
import 'package:diva/Models/user.dart';


class Order {
  String id;
  List<Item> orderItems = [];
  String level;
  String userId;
  Address userAddress;

  Order({this.id, this.userId, this.userAddress,  this.orderItems, this.level});

  Order.fromJson(Map<String, dynamic> json){
    var orderDetails = jsonDecode(json['order_details']);
    id = json['id'];
    level = json['level'];
    userId = json['userId'];
    userAddress = Address.fromJson(json['userAddress']);
    orderDetails['orders'].forEach((item) => orderItems.add(Item.fromJson(item)));
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['orders'] = orderItems.map((v) => v.toJson()).toList();
    data['level'] = level;
    return data;
  }

  List<Map<String, dynamic>> orderItemsToJson(List<Item> orderItems) {
    List<Map<String, dynamic>> data = [];
    orderItems.map((order) => data.add(order.toJson()));
    return data;
  }

  Map<String, dynamic> toFirebaseJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['userAddress'] = userAddress.toFirebaseJson();
    data['orders'] = orderItems.map((v) => v.toJson()).toList();
    data['level'] = level;
    return data;
  }

  Order.fromFirebaseJson(Map<String, dynamic> json, String uid){
    List<dynamic> orderDetails = json['orders'] as List<dynamic>;
    id = uid;
    level = json['level'];
    userId = json['userId'];
    userAddress = Address.fromJson(json['userAddress']);
    for (var item in orderDetails) {
      orderItems.add(Item.fromJson(item));
    }
  }

  @override
  String toString() {
    return 'Order{id: $id, orderItems: $orderItems, level: $level, userId: $userId, userAddress: $userAddress}';
  }
}