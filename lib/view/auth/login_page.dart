import 'package:flutter/material.dart';
import 'package:education_app/constant/r.dart';
import 'package:education_app/view/auth/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    // add textStyle
                    const Text("Login"),
                    Image.asset("assets/auth/img_login.png"),
                    const Text("Selamat Datang"),
                    const Text("Selamat Datang di Aplikasi Widya Edu Aplikasi Latihan dan Konsultasi Soal"),
                  ],
                ),
              ),
              // Spacer(),
              // Login with Google
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    primary: Colors.white,
                    fixedSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                      side: const BorderSide(
                        color: Colors.blue,
                        style: BorderStyle.solid,
                        width: 1,
                      ),
                    ),
                  ),
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const RegisterPage(),
                    ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/auth/ic_google.png"),
                      const SizedBox(width: 10),
                      const Text(
                        "Login with Google",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Distance between login with Apple and Google
              SizedBox(height: 10),
              // Login with Apple
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    primary: Colors.black,
                    fixedSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                      side: BorderSide(color: R.colors.primary),
                    ),
                  ),
                  onPressed: (){},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/auth/ic_apple.png"),
                      const SizedBox(width: 10),
                      const Text(
                        "Login with Apple",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
