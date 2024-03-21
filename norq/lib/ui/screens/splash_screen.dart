import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:norq/data/repositories/user_repository.dart';
import 'package:norq/ui/screens/home/home.dart';
import 'package:norq/ui/screens/home/home_cubit.dart';
import 'package:norq/ui/screens/login/login.dart';
import 'package:norq/ui/screens/login/login_cubit.dart';
import 'package:norq/utils/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3), () {
      if (UserRespository().authInstance.currentUser != null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => HomeCubit(UserRespository()),
                child: const HomePage(),
              ),
            ),
            (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => LoginCubit(UserRespository()),
                child: const LoginPage(),
              ),
            ),
            (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.backgroundColor,
      body: Container(child: const Center(child: Text("WELCOME..."))),
    );
  }
}
