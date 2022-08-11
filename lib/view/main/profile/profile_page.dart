// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:education_app/constant/r.dart';
import 'package:education_app/helpers/preference_helper.dart';
import 'package:education_app/models/user_by_email.dart';
import 'package:education_app/view/login_page.dart';
import 'package:education_app/view/main/profile/edit_profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserData? user;
  getUserData() async {
    final data = await PreferenceHelper().getUserData();
    user = data;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Account",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: (() async {
              final result = await Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return EditProfilePage();
              }));
              // If user succeed updating their data
              if (result == true) {
                getUserData();
              }
            }),
            child: Text(
              "Edit ✍🏻",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: user == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      top: 28,
                      bottom: 35,
                      right: 15,
                      left: 15,
                    ),
                    decoration: BoxDecoration(
                      color: R.colours.primary,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(9),
                        bottomRight: Radius.circular(9),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user!.userName!,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                user!.userAsalSekolah!,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Profile Picture
                        CircleAvatar(
                          backgroundImage: NetworkImage(user!.userFoto!),
                          radius: 40,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 7,
                            color: Colors.black.withOpacity(0.25))
                      ],
                    ),
                    margin: EdgeInsets.symmetric(vertical: 18, horizontal: 13),
                    padding: EdgeInsets.symmetric(vertical: 18, horizontal: 13),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Profile",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Full Name",
                          style: TextStyle(
                            color: R.colours.greySubtitleHome,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          user!.userName!,
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Email",
                          style: TextStyle(
                            color: R.colours.greySubtitleHome,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          user!.userEmail!,
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Gender",
                          style: TextStyle(
                            color: R.colours.greySubtitleHome,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          user!.userGender!,
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Class",
                          style: TextStyle(
                            color: R.colours.greySubtitleHome,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          user!.kelas!,
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "School",
                          style: TextStyle(
                            color: R.colours.greySubtitleHome,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          user!.userAsalSekolah!,
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: (() async {
                      await GoogleSignIn().signOut();
                      await FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          LoginPage.route, (route) => false);
                    }),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 13),
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 7,
                            color: Colors.black.withOpacity(0.25),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.exit_to_app,
                            color: Colors.red,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Log Out",
                            style: TextStyle(
                              color: Colors.red,
                              // fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
