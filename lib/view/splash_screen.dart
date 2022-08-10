import 'dart:async';

import 'package:education_app/helpers/user_email.dart';
import 'package:education_app/models/network_response.dart';
import 'package:education_app/view/login_page.dart';
import 'package:education_app/view/main_page.dart';
import 'package:education_app/view/register_page.dart';
import 'package:flutter/material.dart';
import 'package:education_app/constant/r.dart';

import '../models/user_by_email.dart';
import '../repository/auth_api.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const String route = "splash_screen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  goToNextPage() {
    Timer(const Duration(seconds: 5), () async {
      final user = UserEmail.getUserEmail();
      if (user != null) {
        // Check with the API
        final dataUser = await AuthApi().getUserByEmail();
        if (dataUser.status == Status.success) {
          final data = UserByEmail.fromJson(dataUser.data!);
          // Check if user has register or not (1 registered, 0 not yet)
          if (data.status == 1) {
            Navigator.of(context).pushReplacementNamed(MainPage.route);
          } else {
            Navigator.of(context).pushReplacementNamed(RegisterPage.route);
          }
        }
      } else {
        Navigator.of(context).pushReplacementNamed(LoginPage.route);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    goToNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff3A7FD5),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              R.assets.quizLogo,
              width: MediaQuery.of(context).size.width * 0.45,
            ),
          ],
        ),
      ),
    );
  }
}
