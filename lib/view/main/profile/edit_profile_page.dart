// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:education_app/constant/r.dart';
import 'package:education_app/helpers/user_email.dart';
import 'package:education_app/models/network_response.dart';
import 'package:education_app/models/user_by_email.dart';
import 'package:education_app/repository/auth_api.dart';
import 'package:education_app/view/login_page.dart';
import 'package:education_app/view/main_page.dart';
import 'package:flutter/material.dart';

import '../../../helpers/preference_helper.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);
  static const String route = "register_page";

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

// enum -> naming Constant value
enum Gender { lakiLaki, perempuan }

class _EditProfilePageState extends State<EditProfilePage> {
  List<String> classSlta = ["10", "11", "12"];

  String gender = "Laki-laki";
  String selectedClass = "10";

  final emailController = TextEditingController();
  final schoolNameController = TextEditingController();
  final fullNameController = TextEditingController();

  onTapGender(Gender genderInput) {
    if (genderInput == Gender.lakiLaki) {
      gender = "Laki-laki";
    } else {
      gender = "Perempuan";
    }
    setState(() {});
  }

  initDataUser() async {
    emailController.text = UserEmail.getUserEmail()!;
    final dataUser = await PreferenceHelper().getUserData();
    fullNameController.text = dataUser!.userName!;
    schoolNameController.text = dataUser.userAsalSekolah!;
    gender = dataUser.userGender!;
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Edit Profile",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: ButtonLogin(
            radius: 8,
            onTap: () async {
              final json = {
                "email": emailController.text,
                "nama_lengkap": fullNameController.text,
                "nama_sekolah": schoolNameController.text,
                "kelas": selectedClass,
                "gender": gender,
                "foto": UserEmail.getUserPhotoUrl(),
              };
              final result = await AuthApi().postUpdateUser(json);
              if (result.status == Status.success) {
                final registerResult = UserByEmail.fromJson(result.data!);
                if (registerResult.status == 1) {
                  await PreferenceHelper().setUserData(registerResult.data!);
                  // true means update data from the previous page
                  Navigator.pop(context, true);
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
              R.strings.updateData,
              style: TextStyle(
                fontSize: 16,
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
              EditProfileTextField(
                title: "Email",
                hintText: "Type your email",
                enabled: false,
                controller: emailController,
              ),
              EditProfileTextField(
                title: "Full Name",
                hintText: "Type your full name",
                controller: fullNameController,
              ),
              SizedBox(height: 5),
              Text(
                "Gender",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: R.colours.greySubtitle,
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
                          primary:
                              gender.toLowerCase() == "Laki-laki".toLowerCase()
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
                          onTapGender(Gender.lakiLaki);
                        },
                        child: Text(
                          "Laki-laki",
                          style: TextStyle(
                            fontSize: 14,
                            color: gender.toLowerCase() ==
                                    "Laki-laki".toLowerCase()
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
                          primary: gender == "Perempuan"
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
                          onTapGender(Gender.perempuan);
                        },
                        child: Text(
                          "Perempuan",
                          style: TextStyle(
                            fontSize: 14,
                            color: gender == "Perempuan"
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
                  color: R.colours.greySubtitle,
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
              EditProfileTextField(
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

class EditProfileTextField extends StatelessWidget {
  const EditProfileTextField({
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: R.colours.greySubtitle),
          ),
          SizedBox(height: 5),
          TextField(
            enabled: enabled,
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: R.colours.greyHintText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
