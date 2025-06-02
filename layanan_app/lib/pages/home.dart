import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:layanan_app/check_page.dart';
import 'package:layanan_app/mahasiswa/sim.dart';
import 'package:http/http.dart' as http;

import 'dart:convert' show json, base64, ascii;

import 'package:layanan_app/pages/jwt.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:layanan_app/model/status_token.dart';

import '../mahasiswa/kkn.dart';
import '../mahasiswa/lab_ti.dart';
import '../mahasiswa/simonta.dart';

class homePage extends StatefulWidget {
  final data;

  homePage({this.data});
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  List imgList = [
    'Dashboard',
    'Alur Sistem',
    'Aplikasi\nTerintegrasi SSO',
    'About SSO'
  ];

  List imgApp = ['Dashboard', 'Alur Sistem', 'app', 'info'];

  List SmtAtasMenu = [
    'SIM',
    'Laboratorium',
    'KKN',
    'SIMONTA',
  ];

  List SmtAtasImg = [
    'sim',
    'lab_ti',
    'kkn',
    'simonta',
  ];

  List catNames = [
    "Category",
    "Classes",
    "Schedule",
    "About",
  ];

  List<Color> setColors = [
    Color(0xFF6FE0BD),
    Color(0xFF618DFD),
    Color(0xFFFC7F7F),
    Color(0xFFCB84FB),
  ];

  List<Icon> catIcon = [
    Icon(
      Icons.category,
      color: Colors.white,
      size: 30,
    ),
    Icon(
      Icons.class_sharp,
      color: Colors.white,
      size: 30,
    ),
    Icon(
      Icons.calendar_month,
      color: Colors.white,
      size: 30,
    ),
    Icon(
      Icons.settings,
      color: Colors.white,
      size: 30,
    ),
  ];

  SharedPreferences _prefs;

  String statusInOut;
  String revokeToken;

  String _test = "";
  String ids = "";
  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    String ids = _prefs.getString('id') ?? null;

    _test = _prefs.getString('myTest') ?? "";
    String id = _prefs.getString('id') ?? null;
    User.getUsers(id).then((users) async {
      statusInOut = "";

      for (int i = 0; i < users.length; i++)
        statusInOut = statusInOut + users[i].status;
    });

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initSharedPreferences();
    fetchData();
  }

  Future<void> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('id') ?? null;

    if (id != null) {
      List<User> users = await User.getUsers(id);
      statusInOut = "";
      revokeToken = "";
      for (int i = 0; i < users.length; i++) {
        statusInOut += users[i].status;
      }
      if (statusInOut == "false" || revokeToken == "revoke") {
        await prefs.clear();
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => checkPage()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 221, 27),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(60),
                    bottomLeft: Radius.circular(60))),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.person,
                      size: 30,
                      color: Colors.black,
                    ),
                    Icon(
                      Icons.dehaze,
                      size: 30,
                      color: Colors.black,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 3, bottom: 15),
                  child: Text(
                    "Hi ${statusInOut}\n${ids}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                        wordSpacing: 2,
                        color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 90,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 15, right: 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "Penyedia Layanan",
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                GridView.builder(
                    itemCount: SmtAtasMenu.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio:
                          (MediaQuery.of(context).size.height - 50 - 25) /
                              (3 * 290),
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          if (SmtAtasImg[index] == "sim") {
                            String id = _prefs.getString('id') ?? null;
                            User.getUsers(id).then((users) async {
                              statusInOut = "";

                              for (int i = 0; i < users.length; i++)
                                statusInOut = statusInOut + users[i].status;
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        simMhs(status: statusInOut)));
                          } else if (SmtAtasImg[index] == "lab_ti") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => labTIMhs()));
                          } else if (SmtAtasImg[index] == "kkn") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => kknMhs()));
                          } else if (SmtAtasImg[index] == "simonta") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => simontaMhs()));
                          } else {
                            print("error");
                          }

                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => simMhs()));
                        },
                        child: GridTile(
                            child: Image.asset(
                          "assets/${SmtAtasImg[index]}.png", // Mengambil gambar dari assets
                          fit: BoxFit.cover,
                        )),
                      );
                    }),
                SizedBox(
                  height: 30,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
