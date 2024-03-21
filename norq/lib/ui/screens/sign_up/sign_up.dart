import 'package:flutter/material.dart';
import 'package:norq/data/repositories/user_repository.dart';
import 'package:norq/ui/common_widget/app_loader.dart';
import 'package:norq/ui/screens/login/login.dart';
import 'package:norq/ui/screens/login/login_cubit.dart';
import 'package:norq/ui/screens/sign_up/sign_up_cubit.dart';
import 'package:norq/utils/colors.dart';
import 'package:norq/utils/style.dart';
import 'package:norq/utils/validations.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _addresscontroller = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _ConfirmPasswordController =
      TextEditingController();

  bool _passwordVisible = true;
  bool _ConfirmPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Appcolors.backgroundColor,
        appBar: AppBar(
          backgroundColor: Appcolors.backgroundColor,
          centerTitle: true,
          title: const Text(
            "Sign UP",
            style: TextStyle(
              color: Appcolors.textColor,
            ),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: BlocConsumer<SignUpCubit, SignUpState>(
              listener: (context, state) {
                if (state is SignUpFailure) {
                  Appvalidation.showToast(state.error.toString());
                }
                if (state is SignUpSuccess) {
                  Appvalidation.showToast("User registerd successfully");
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BlocProvider(
                                create: (context) =>
                                    LoginCubit(UserRespository()),
                                child: const LoginPage(),
                              )));
                }
              },
              builder: (context, state) {
                if (state is SignUpLoading) {
                  return const AppLoader();
                }
                return Container(
                  height: 100.h,
                  child: SingleChildScrollView(
                    child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 5.h,
                            ),
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
                              controller: _addresscontroller,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.streetAddress,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your address';
                                }
                                return null;
                              },
                              decoration: AppStyle.getInputDecorationStyle(
                                  hint: "Enter your address",
                                  label: "address",
                                  icon: Icons.location_city),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            TextFormField(
                                controller: _passwordController,
                                obscureText: _passwordVisible,
                                textInputAction: TextInputAction.next,
                                validator: Appvalidation.validatePassword,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    hintText: "Enter password",
                                    label: const Text("Password"),
                                    prefixIcon: const Icon(Icons.lock,
                                        color: Colors.black),
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
                                    errorStyle:
                                        const TextStyle(color: Colors.red),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        borderSide: const BorderSide(
                                            color: Appcolors.accentColor,
                                            width: 1)),
                                    hintStyle: TextStyle(
                                        color: Appcolors.hintColor,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        textBaseline: TextBaseline.alphabetic,
                                        fontStyle: FontStyle.normal),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        borderSide: const BorderSide(
                                            color: Appcolors.accentColor,
                                            width: 1)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        borderSide: const BorderSide(
                                            color: Appcolors.accentColor,
                                            width: 1)))),
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
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    hintText: "Confirm password",
                                    label: const Text("Confirm Password"),
                                    prefixIcon: const Icon(Icons.lock,
                                        color: Colors.black),
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
                                    errorStyle:
                                        const TextStyle(color: Colors.red),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        borderSide: const BorderSide(
                                            color: Appcolors.accentColor,
                                            width: 1)),
                                    hintStyle: TextStyle(
                                        color: Appcolors.hintColor,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        textBaseline: TextBaseline.alphabetic,
                                        fontStyle: FontStyle.normal),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        borderSide: const BorderSide(
                                            color: Appcolors.accentColor,
                                            width: 1)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        borderSide: const BorderSide(
                                            color: Appcolors.accentColor,
                                            width: 1)))),
                            SizedBox(
                              height: 5.h,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Appcolors.accentColor),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                              side: const BorderSide(
                                                  color:
                                                      Appcolors.accentColor)))),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      BlocProvider.of<SignUpCubit>(context)
                                          .registerUser(
                                              _nameController.text,
                                              _emailcontroller.text,
                                              _addresscontroller.text,
                                              _passwordController.text);
                                    }
                                  },
                                  child: Text(
                                    "Register",
                                    style: TextStyle(
                                        color: Appcolors.backgroundColor,
                                        fontSize: 14.sp),
                                  )),
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            const Row(
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
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Appcolors.backgroundColor),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                              side: const BorderSide(
                                                  color:
                                                      Appcolors.accentColor)))),
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => BlocProvider(
                                            create: (context) =>
                                                LoginCubit(UserRespository()),
                                            child: const LoginPage(),
                                          ),
                                        ));
                                  },
                                  child: Text(
                                    "Log In",
                                    style: TextStyle(
                                        color: Appcolors.accentColor,
                                        fontSize: 14.sp),
                                  )),
                            ),
                          ],
                        )),
                  ),
                );
              },
            )));
  }
}
