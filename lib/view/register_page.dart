// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:education_app/constant/r.dart';
import 'package:education_app/helpers/user_email.dart';
import 'package:education_app/models/network_response.dart';
import 'package:education_app/models/user_by_email.dart';
import 'package:education_app/repository/auth_api.dart';
import 'package:education_app/view/login_page.dart';
import 'package:education_app/view/main_page.dart';
import 'package:flutter/material.dart';

import '../helpers/preference_helper.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  static const String route = "register_page";

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

// enum -> naming Constant value
enum Gender { male, female }

class _RegisterPageState extends State<RegisterPage> {
  List<String> classSlta = ["10", "11", "12"];

  String gender = "Male";
  String selectedClass = "10";

  final emailController = TextEditingController();
  final schoolNameController = TextEditingController();
  final fullNameController = TextEditingController();

  onTapGender(Gender genderInput) {
    if (genderInput == Gender.male) {
      gender = "Male";
    } else {
      gender = "Female";
    }
    setState(() {});
  }

  initDataUser() {
    emailController.text = UserEmail.getUserEmail()!;
    fullNameController.text = UserEmail.getUserDisplayName()!;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initDataUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff0f3f5),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + 20),
        child: AppBar(
          // ignore: prefer_const_constructors
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25.0),
            bottomRight: Radius.circular(25.0),
          )),
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            "Your Personal Information",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: ButtonLogin(
            onTap: () async {
              final json = {
                "email": emailController.text,
                "nama_lengkap": fullNameController.text,
                "nama_sekolah": schoolNameController.text,
                "kelas": selectedClass,
                "gender": gender,
                "foto": UserEmail.getUserPhotoUrl(),
              };
              final result = await AuthApi().postRegister(json);
              if (result.status == Status.success) {
                final registerResult = UserByEmail.fromJson(result.data!);
                if (registerResult.status == 1) {
                  await PreferenceHelper().setUserData(registerResult.data!);
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      MainPage.route, (context) => false);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(registerResult.message!)));
                }
              } else {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Please try again!")));
              }
            },
            backgroundColor: R.colours.primary,
            borderColor: R.colours.primary,
            child: Text(
              R.strings.register,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RegisterTextField(
                title: "Email",
                hintText: "Type your email",
                enabled: false,
                controller: emailController,
              ),
              RegisterTextField(
                title: "Full Name",
                hintText: "Type your full name",
                controller: fullNameController,
              ),
              SizedBox(height: 5),
              Text(
                "Gender",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          primary: gender == "Male"
                              ? R.colours.primary
                              : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                              width: 1,
                              color: R.colours.greyBorder,
                            ),
                          ),
                        ),
                        onPressed: () {
                          onTapGender(Gender.male);
                        },
                        child: Text(
                          "Male",
                          style: TextStyle(
                            fontSize: 14,
                            color: gender == "Male"
                                ? Colors.white
                                : Color(0xff282828),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          primary: gender == "Female"
                              ? R.colours.primary
                              : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                              width: 1,
                              color: R.colours.greyBorder,
                            ),
                          ),
                        ),
                        onPressed: () {
                          onTapGender(Gender.female);
                        },
                        child: Text(
                          "Female",
                          style: TextStyle(
                            fontSize: 14,
                            color: gender == "Female"
                                ? Colors.white
                                : Color(0xff282828),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Text(
                "Class",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 5),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  border: Border.all(color: R.colours.greyBorder),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedClass,
                    items: classSlta
                        .map(
                          (e) => DropdownMenuItem<String>(
                            child: Text(e),
                            value: e,
                          ),
                        )
                        .toList(),
                    onChanged: (String? val) {
                      selectedClass = val!;
                      setState(() {});
                    },
                  ),
                ),
              ),
              SizedBox(height: 5),
              RegisterTextField(
                title: "School",
                hintText: "Type the name of your school",
                controller: schoolNameController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterTextField extends StatelessWidget {
  const RegisterTextField({
    Key? key,
    required this.title,
    required this.hintText,
    this.controller,
    this.enabled = true,
  }) : super(key: key);
  final String title;
  final String hintText;
  final bool enabled;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 5),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              border: Border.all(color: R.colours.greyBorder),
            ),
            child: TextField(
              enabled: enabled,
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: TextStyle(
                  color: R.colours.greyHintText,
                ),
              ),
            )),
      ],
    );
  }
}
