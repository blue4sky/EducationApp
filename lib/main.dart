import 'package:education_app/constant/r.dart';
import 'package:education_app/view/login_page.dart';
import 'package:education_app/view/main/latihan_soal/mapel_page.dart';
import 'package:education_app/view/main/latihan_soal/paket_soal_page.dart';
import 'package:education_app/view/main_page.dart';
import 'package:education_app/view/register_page.dart';
import 'package:education_app/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        appBarTheme: AppBarTheme(
          backgroundColor: R.colours.primary,
        ),
        primarySwatch: Colors.blue,
      ),
      // home: SplashScreen(),
      initialRoute: "/",
      routes: {
        "/": (context) => const SplashScreen(),
        LoginPage.route : (context) => const LoginPage(),
        RegisterPage.route : (context) => const RegisterPage(),
        MainPage.route : (context) => const MainPage(),
        MapelPage.route :(context) => const MapelPage(),
        PaketSoalPage.route : (context) => const PaketSoalPage(),
      },
    );
  }
}