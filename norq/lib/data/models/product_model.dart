class Product {
  int? _id;
  String? _title;
  num? _price;
  String? _description;
  String? _category;
  String? _image;
  Rating? _rating;

  Product(
      {int? id,
      String? title,
      num? price,
      String? description,
      String? category,
      String? image,
      Rating? rating}) {
    _id = id;
    _title = title;
    _price = price;
    _description = description;
    _category = category;
    _image = image;
    _rating = rating;
  }

  int? get id => _id;
  String? get title => _title;
  num? get price => _price;
  String? get description => _description;
  String? get category => _category;
  String? get image => _image;
  Rating? get rating => _rating;

  Product.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _title = json['title'];
    _price = json['price'];
    _description = json['description'];
    _category = json['category'];
    _image = json['image'];
    _rating =
        json['rating'] != null ? new Rating.fromJson(json['rating']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map['id'] = _id;
    map['title'] = _title;
    map['price'] = _price;
    map['description'] = _description;
    map['category'] = _category;
    map['image'] = _image;
    if (_rating != null) {
      map['rating'] = _rating!.toJson();
    }
    return map;
  }
}

class Rating {
  num? _rate;
  int? _count;

  Rating({num? rate, int? count}) {
    _rate = rate;
    _count = count;
  }

  num? get rate => _rate;
  int? get count => _count;

  Rating.fromJson(Map<String, dynamic> json) {
    _rate = json['rate'];
    _count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map['rate'] = _rate;
    map['count'] = _count;
    return map;
  }
}
