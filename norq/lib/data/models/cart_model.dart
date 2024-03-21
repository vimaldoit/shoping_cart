class CartItem {
  int? _id;
  String? _title;
  num? _price;
  String? _description;
  String? _category;
  String? _image;
  int? _itemCount;

  CartItem(
      {int? id,
      String? title,
      num? price,
      String? description,
      String? category,
      String? image,
      int? itemCount}) {
    _id = id;
    _title = title;
    _price = price;
    _description = description;
    _category = category;
    _image = image;
    _itemCount = itemCount;
  }

  int? get id => _id;
  String? get title => _title;
  num? get price => _price;
  String? get description => _description;
  String? get category => _category;
  String? get image => _image;
  int? get itemCount => _itemCount;

  CartItem.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _title = json['title'];
    _price = json['price'];
    _description = json['description'];
    _category = json['category'];
    _image = json['image'];
    _itemCount = json["itemCount"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map['id'] = _id;
    map['title'] = _title;
    map['price'] = _price;
    map['description'] = _description;
    map['category'] = _category;
    map['image'] = _image;
    map["itemCount"] = _itemCount;
    return map;
  }
}
