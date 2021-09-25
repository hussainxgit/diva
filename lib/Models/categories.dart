class Categories {
  String id;
  String name;
  String image;

  Categories({this.id, this.name, this.image});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    return data;
  }
  Categories.fromFirebase(Map<String, dynamic> json, String uid) {
    id = uid;
    name = json['name'];
    image = json['image'];
  }
}
