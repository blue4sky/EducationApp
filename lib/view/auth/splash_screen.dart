import 'dart:async';

import 'package:education_app/view/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:education_app/constant/r.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  goToNextPage() {
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
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
            Image.asset(R.assets.icSplash, width: MediaQuery.of(context).size.width * 0.45,
            ),
          ],
        ),
      ),
    );
  }
}