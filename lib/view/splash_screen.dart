import 'dart:async';

import 'package:education_app/view/login_page.dart';
import 'package:education_app/view/main_page.dart';
import 'package:education_app/view/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    Timer(const Duration(seconds: 3), () async {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          // Check with the API
          final dataUser = await AuthApi().getUserByEmail(user.email);
          if (dataUser != null) {
            final data = UserByEmail.fromJson(dataUser);
            // Check if user has register or no (1 registered, 0 not yet)
            if (data.status == 1) {
              Navigator.of(context).pushNamed(MainPage.route);
            } else {
              Navigator.of(context).pushNamed(RegisterPage.route);
            }
          }
        } else {
          Navigator.of(context).pushReplacementNamed(LoginPage.route);
        }
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
              R.assets.icSplash,
              width: MediaQuery.of(context).size.width * 0.45,
            ),
          ],
        ),
      ),
    );
  }
}
