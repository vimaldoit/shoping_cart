import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Appvalidation {
  static String? validateEmailInput(String? email) {
    bool emailValid = RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email!.trim());
    if (email.trim().isEmpty || !emailValid) {
      return "Please enter valid eamil ID";
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password!.trim().isEmpty || password.trim().length < 6) {
      return "Password must be 6 charater long";
    }
    return null;
  }

  static void showSnackBar(BuildContext? context, String? value) {
    final snackBar = SnackBar(content: Text(value!));
    ScaffoldMessenger.of(context!).showSnackBar(snackBar);
  }

  static void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg.trim(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0);
  }
}
