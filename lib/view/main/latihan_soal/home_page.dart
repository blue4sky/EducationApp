// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:education_app/constant/r.dart';
import 'package:education_app/helpers/preference_helper.dart';
import 'package:education_app/models/banner_list.dart';
import 'package:education_app/models/mapel_list.dart';
import 'package:education_app/models/network_response.dart';
import 'package:education_app/models/user_by_email.dart';
import 'package:education_app/repository/latihan_soal_api.dart';
import 'package:education_app/view/main/latihan_soal/mapel_page.dart';
import 'package:education_app/view/main/latihan_soal/paket_soal_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static String route = "home_page";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MapelList? mapelList; // Global var
  getMapel() async {
    final mapelResult = await LatihanSoalApi().getMapel();
    if (mapelResult.status == Status.success) {
      mapelList = MapelList.fromJson(mapelResult.data!);
      setState(() {});
    }
  }

  BannerList? bannerList; // Global var
  getBanner() async {
    final banner = await LatihanSoalApi().getBanner();
    if (banner.status == Status.success) {
      bannerList = BannerList.fromJson(banner.data!);
      setState(() {});
    }
  }

  // Listening msg from firebase
  setupFCM() async {
    final tokenFcm = await FirebaseMessaging.instance.getToken();

    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    // if (initialMessage != null) {
    //   _handleMessage(initialMessage);
    // }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }

  UserData? dataUser;
  Future getDataUser() async {
    dataUser = await PreferenceHelper().getUserData();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getMapel();
    getBanner();
    setupFCM();
    getDataUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colours.grey,
      body: SafeArea(
        child: ListView(
          children: [
            _buildUserHomeProfile(),
            _buildTopBanner(context),
            _buildHomeListMapel(mapelList),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Latest News 📰",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 11),
            bannerList == null
                ? Container(
                    height: 70,
                    width: double.infinity,
                    child: Center(child: CircularProgressIndicator()),
                  )
                : Container(
                    height: 146,
                    child: ListView.builder(
                      itemCount: bannerList!.data!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: ((context, index) {
                        final currentBanner = bannerList!.data![index];
                        return Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(currentBanner.eventImage!)),
                        );
                      }),
                    ),
                  ),
            SizedBox(height: 54),
          ],
        ),
      ),
    );
  }

  Container _buildHomeListMapel(MapelList? list) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 21),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Choose Subject",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return MapelPage(mapel: mapelList!);
                  }));
                },
                child: Text(
                  "See All",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: R.colours.primary,
                  ),
                ),
              ),
            ],
          ),
          list == null
              ? Container(
                  // Loading
                  height: 70,
                  width: double.infinity,
                  child: Center(child: CircularProgressIndicator()),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: list.data!.length > 3 ? 3 : list.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    final currentMapel = list.data![index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              PaketSoalPage(id: currentMapel.courseId!),
                        ));
                      },
                      child: MapelWidget(
                        title: currentMapel.courseName!,
                        totalPacket: currentMapel.jumlahMateri!,
                        totalDone: currentMapel.jumlahDone!,
                      ),
                    );
                  },
                )
        ],
      ),
    );
  }

  Container _buildTopBanner(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20.0,
      ),
      decoration: BoxDecoration(
        color: R.colours.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      height: 147,
      width: double.infinity,
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 15,
            ),
            child: Text(
              "Which quiz do you want to do today?",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Image.asset(
              R.assets.imgHome,
              width: MediaQuery.of(context).size.width * 0.45,
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildUserHomeProfile() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 15,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hi, " + (dataUser?.userName ?? "User's Name"),
                  style: GoogleFonts.poppins()
                      .copyWith(fontSize: 12, fontWeight: FontWeight.w600),
                ),
                Text(R.strings.welcome,
                    style: GoogleFonts.poppins()
                        .copyWith(fontSize: 12, fontWeight: FontWeight.w400)),
              ],
            ),
          ),
          CircleAvatar(
            backgroundImage: NetworkImage(dataUser!.userFoto!),
            radius: 20,
          ),
        ],
      ),
    );
  }
}

class MapelWidget extends StatelessWidget {
  const MapelWidget({
    Key? key,
    required this.title,
    required this.totalDone,
    required this.totalPacket,
  }) : super(key: key);

  final String title;
  final int? totalDone;
  final int? totalPacket;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 21),
      child: Row(
        children: [
          Container(
            height: 53,
            width: 53,
            padding: EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: R.colours.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(R.assets.icAtom),
          ),
          SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                Text(
                  "$totalDone/$totalPacket Package Done",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: R.colours.greySubtitleHome,
                  ),
                ),
                SizedBox(height: 5),
                Stack(
                  children: [
                    Container(
                      height: 5,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: R.colours.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: totalDone!,
                          child: Container(
                            height: 5,
                            decoration: BoxDecoration(
                              color: R.colours.primary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: totalPacket! - totalDone!,
                          child: Container(),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
