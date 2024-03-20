import 'package:flutter/material.dart';
import 'package:norq/utils/colors.dart';
import 'package:sizer/sizer.dart';

class AppStyle {
  static InputDecoration getInputDecorationStyle({
    String? hint,
    String? label,
    IconData? icon,
  }) {
    return InputDecoration(
      contentPadding: EdgeInsets.zero,
      hintText: hint,
      label: Text(label ?? "".toString()),
      prefixIcon: Icon(
        icon,
        color: Colors.black,
      ),
      errorStyle: TextStyle(color: Colors.red),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(color: Appcolors.textColor, width: 1)),
      hintStyle: TextStyle(
          color: Appcolors.hintColor,
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          textBaseline: TextBaseline.alphabetic,
          fontStyle: FontStyle.normal),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(color: Appcolors.accentColor, width: 1)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(color: Appcolors.accentColor, width: 1)),
    );
  }
}
