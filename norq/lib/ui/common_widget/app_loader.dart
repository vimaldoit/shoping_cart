import 'package:flutter/material.dart';
import 'package:norq/utils/colors.dart';
import 'package:sizer/sizer.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Appcolors.backgroundColor,
      width: 100.w,
      height: 100.h,
      child: const Center(
        child: CircularProgressIndicator(
          color: Appcolors.accentColor,
        ),
      ),
    );
  }
}
