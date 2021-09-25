class User {
  String id;
  String name;
  String phone;
  String email;
  Address defaultAddress;
  List<Address> address = [];

  User({this.id, this.phone, this.name, this.email, this.address});

  User.fromJson(Map<String, dynamic> json) {
    List<dynamic> jsonAddressList = json['address'] as List;
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    address = jsonAddressList.map((e) => Address.fromJson(e)).toList();

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    if (address != null) {
      data['address'] = address.map((item) => item.toJson()).toList();
    } else {
      address = null;
    }
    return data;
  }

  Map<String, dynamic> toFirebaseJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['address'] =
        address.map((item) => item.toFirebaseJson()).toList();
    return data;
  }

  User.fromFirebaseJson(Map<String, dynamic> json, String uid, String email) {
    List<dynamic> jsonAddressList = json['address'] as List;
    id = uid;
    name = json['name'];
    phone = json['phone'];
    this.email = email;
    address = jsonAddressList.map((e) => Address.fromJson(e)).toList();
  }

  void addAddress(Address address) {
    this.address.add(address);
  }

  void removeAddress(Address address) {
    this.address.remove(address);
  }
  
  Address getDefaultAddress(){
    return address.firstWhere((element) => element.userDefault == true, orElse: () => null);
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, phone: $phone, email: $email, address: $address}';
  }
}

class Address {
  int id;
  String area;
  String block;
  String street;
  String jada;
  String floor;
  String houseNumber;
  String userId;
  bool userDefault;

  Address(
      {this.id,
      this.area,
      this.block,
      this.street,
      this.jada,
      this.floor,
      this.houseNumber,
      this.userId,
      this.userDefault});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    area = json['area'].toString();
    block = json['block'].toString();
    street = json['street'].toString();
    jada = json['jada'].toString();
    floor = json['floor'].toString();
    houseNumber = json['housenumber'].toString();
    userId = json['userId'].toString();
    userDefault = json['user_default'] as bool;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['area'] = area;
    data['block'] = block;
    data['street'] = street;
    data['jada'] = jada;
    data['floor'] = floor;
    data['housenumber'] = houseNumber;
    data['userId'] = userId;
    data['user_default'] = userDefault;
    return data;
  }

  Map<String, dynamic> toFirebaseJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['area'] = area;
    data['block'] = block;
    data['street'] = street;
    data['jada'] = jada;
    data['floor'] = floor;
    data['housenumber'] = houseNumber;
    data['userId'] = userId;
    data['user_default'] = userDefault;
    return data;
  }

  @override
  String toString() {
    return 'Address{id: $id, area: $area, block: $block, street: $street, jada: $jada, floor: $floor, houseNumber: $houseNumber, userId: $userId, userDefault: $userDefault}';
  }
}
