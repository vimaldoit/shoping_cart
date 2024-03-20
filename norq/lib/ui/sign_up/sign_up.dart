import 'package:flutter/material.dart';
import 'package:norq/utils/colors.dart';
import 'package:norq/utils/style.dart';
import 'package:norq/utils/validations.dart';
import 'package:sizer/sizer.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _ConfirmPasswordController =
      TextEditingController();

  bool _passwordVisible = true;
  bool _ConfirmPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Sign UP",
            style: TextStyle(
              color: Appcolors.textColor,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      decoration: AppStyle.getInputDecorationStyle(
                          hint: "Enter your name",
                          label: "Name",
                          icon: Icons.person),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    TextFormField(
                      controller: _emailcontroller,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      validator: Appvalidation.validateEmailInput,
                      decoration: AppStyle.getInputDecorationStyle(
                          hint: "Enter your email",
                          label: "Email ID",
                          icon: Icons.mail),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    TextFormField(
                        controller: _passwordController,
                        obscureText: _passwordVisible,
                        textInputAction: TextInputAction.next,
                        validator: Appvalidation.validatePassword,
                        style: TextStyle(
                            fontSize: 16.sp, color: Appcolors.textColor),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            hintText: "Enter password",
                            label: Text("Password"),
                            prefixIcon: Icon(Icons.lock, color: Colors.black),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                              icon: Icon(
                                  _passwordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Appcolors.accentColor),
                            ),
                            errorStyle: TextStyle(color: Colors.red),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: BorderSide(
                                    color: Appcolors.accentColor, width: 1)),
                            hintStyle: TextStyle(
                                color: Appcolors.hintColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                textBaseline: TextBaseline.alphabetic,
                                fontStyle: FontStyle.normal),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: BorderSide(
                                    color: Appcolors.accentColor, width: 1)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: BorderSide(
                                    color: Appcolors.accentColor, width: 1)))),
                    SizedBox(
                      height: 5.h,
                    ),
                    TextFormField(
                        controller: _ConfirmPasswordController,
                        obscureText: _ConfirmPasswordVisible,
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          if (value!.trim() !=
                              _passwordController.text.trim()) {
                            return "Password mismatch";
                          } else {
                            return null;
                          }
                        },
                        style: TextStyle(
                            fontSize: 16.sp, color: Appcolors.textColor),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            hintText: "Confirm password",
                            label: Text("Confirm Password"),
                            prefixIcon: Icon(Icons.lock, color: Colors.black),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _ConfirmPasswordVisible =
                                      !_ConfirmPasswordVisible;
                                });
                              },
                              icon: Icon(
                                  _ConfirmPasswordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Appcolors.accentColor),
                            ),
                            errorStyle: TextStyle(color: Colors.red),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: BorderSide(
                                    color: Appcolors.accentColor, width: 1)),
                            hintStyle: TextStyle(
                                color: Appcolors.hintColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                textBaseline: TextBaseline.alphabetic,
                                fontStyle: FontStyle.normal),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: BorderSide(
                                    color: Appcolors.accentColor, width: 1)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: BorderSide(
                                    color: Appcolors.accentColor, width: 1)))),
                    SizedBox(
                      height: 5.h,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Appcolors.accentColor),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                          color: Appcolors.accentColor)))),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {}
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(
                                color: Appcolors.backgroundColor,
                                fontSize: 14.sp),
                          )),
                    )
                  ],
                )),
          ),
        ));
  }
}
