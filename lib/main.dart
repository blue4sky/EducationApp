import 'package:education_app/view/login_page.dart';
import 'package:education_app/view/main_page.dart';
import 'package:education_app/view/register_page.dart';
import 'package:education_app/view/splash_screen.dart';
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
      // home: SplashScreen(),
      initialRoute: "/",
      routes: {
        "/": (context) => const SplashScreen(),
        LoginPage.route : (context) => const LoginPage(),
        RegisterPage.route : (context) => const RegisterPage(),
        MainPage.route : (context) => const MainPage(),
      },
    );
  }
}