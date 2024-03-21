import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:norq/data/models/user_model.dart';
import 'package:norq/utils/constants.dart';
import 'package:norq/utils/network/ApiBaseHelper.dart';

class UserRespository {
  final CollectionReference users =
      FirebaseFirestore.instance.collection("users");

  var authInstance = FirebaseAuth.instance;

  Future registerUser(String email, String password) async {
    var data = await authInstance.createUserWithEmailAndPassword(
        email: email, password: password);

    return Future.value(data);
  }

  Future<void> addUser(UserModel user) {
    return users.doc(authInstance.currentUser?.uid).set(user.toJson());
  }

  Future userLogin(String email, String password) async {
    var data = await authInstance.signInWithEmailAndPassword(
        email: email, password: password);
    return Future.value(data);
  }

  Future getUserData() async {
    QuerySnapshot data = await users
        .where("userID", isEqualTo: authInstance.currentUser?.uid)
        .get();

    if (data.docs.isEmpty) {
      return Future.value(false);
    } else {
      print("data for user is ${data.docs.first.data()}");
      return Future.value(UserModel.fromJson(data.docs.first.data()));
    }
  }

  Future<dynamic> fetchProducts() async {
    ApiBaseHelper apiHelper = ApiBaseHelper();
    final data = await apiHelper.get(Constants.PRODUCTS);
    print("User is${data}");
    return data;
  }
}
