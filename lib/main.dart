import 'package:education_app/view/auth/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // Root of my app
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Education App',
      theme: Theme.of(context).copyWith(
        appBarTheme: AppBarTheme(backgroundColor: const Color(0xff3A7FD5)),
        primaryColor: Color(0xff3A7FD5),
        primaryIconTheme: Theme.of(context).primaryIconTheme.copyWith(color: Colors.white),
        primaryTextTheme: Theme.of(context).primaryTextTheme.apply(bodyColor: Colors.white),
      ),
      home: SplashScreen(),
    );
  }
}