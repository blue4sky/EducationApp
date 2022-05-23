// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:education_app/view/home_page.dart';
import 'package:education_app/view/main/discussion/discussion_page.dart';
import 'package:education_app/view/main/profile/profile_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  static const String route = "main_page";

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _pc = PageController();
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => DiscussionPage()));
      }),
      bottomNavigationBar: _buildBottomNavigation(),
      body: PageView(
          controller: _pc,
          physics:
              const NeverScrollableScrollPhysics(), // disable page view scroll
          children: const [
            HomePage(),
            ProfilePage(),
          ]),
    );
  }

  Container _buildBottomNavigation() {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.grey,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: BottomAppBar(
        color: Colors.white,
        child: Container(
          height: 60,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    // Animation Swipe
                    onTap: () {
                      index = 0;
                      setState(() {});
                      _pc.animateToPage(
                        0, curve: Curves.easeInOut, duration: Duration(microseconds: 1),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.home),
                        Text(
                          "Home",
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: null,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Opacity(
                        opacity: 0,
                        child: Icon(Icons.home),
                      ),
                      Text(
                        "Diskusi",
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      index = 1;
                      setState(() {});
                      _pc.animateToPage(
                        1, curve: Curves.easeInOut, duration: Duration(microseconds: 1),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.person),
                        Text(
                          "My Menu",
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
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