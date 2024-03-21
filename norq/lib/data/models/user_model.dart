class UserModel {
  String? _userID;
  String? _name;
  String? _email;
  String? _adddress;
  UserModel({String? userID, String? name, String? email, String? address}) {
    _userID = userID;
    _name = name;
    _email = email;
    _adddress = address;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["userID"] = _userID;
    map["name"] = _name;
    map["email"] = _email;
    map["address"] = _adddress;
    return map;
  }

  UserModel.fromJson(dynamic json) {
    _userID = json["userID"];
    _name = json["name"];
    _adddress = json["email"];
    _adddress = json["address"];
  }

  String? get userID => _userID;
  String? get name => _name;
  String? get email => _email;
  String? get address => _adddress;
}
