import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:norq/data/repositories/user_repository.dart';
import 'package:norq/ui/common_widget/app_loader.dart';
import 'package:norq/ui/home/home.dart';
import 'package:norq/ui/home/home_cubit.dart';
import 'package:norq/ui/login/login_cubit.dart';
import 'package:norq/ui/sign_up/sign_up.dart';
import 'package:norq/ui/sign_up/sign_up_cubit.dart';
import 'package:norq/utils/colors.dart';
import 'package:norq/utils/style.dart';
import 'package:norq/utils/validations.dart';
import 'package:sizer/sizer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginformKey = GlobalKey<FormState>();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text("Login"),
        // ),
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => HomeCubit(UserRespository()),
                    child: HomePage(),
                  ),
                ),
                (route) => false);
          }
          if (state is LoginFailuer) {
            String error = state.error;
            Appvalidation.showSnackBar(context, "User not found");
          }
        },
        builder: (context, state) {
          if (state is LoginLoading) {
            return AppLoader();
          }
          return Container(
            height: 100.h,
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Form(
                key: _loginformKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter password";
                          }
                          return null;
                        },
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
                                fontSize: 12.sp,
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
                            if (_loginformKey.currentState!.validate()) {
                              BlocProvider.of<LoginCubit>(context).login(
                                  email: _emailcontroller.text,
                                  password: _passwordController.text);
                            }
                          },
                          child: Text(
                            "Log In",
                            style: TextStyle(
                                color: Appcolors.backgroundColor,
                                fontSize: 14.sp),
                          )),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Row(
                      children: [
                        Expanded(child: Divider()),
                        Text("OR"),
                        Expanded(child: Divider())
                      ],
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Appcolors.backgroundColor),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                          color: Appcolors.accentColor)))),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                    create: (context) =>
                                        SignUpCubit(UserRespository()),
                                    child: SignUpPage(),
                                  ),
                                ));
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                color: Appcolors.accentColor, fontSize: 14.sp),
                          )),
                    ),
                    SizedBox(
                      height: 5.h,
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    ));
  }
}
