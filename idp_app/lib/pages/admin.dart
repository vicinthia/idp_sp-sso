import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:idp_app/auth/login_page.dart';
import 'package:idp_app/component/aboutsso.dart';
import 'package:idp_app/component/brndAdminDsn.dart';
import 'package:idp_app/component/brndAdminMhs.dart';
import 'package:idp_app/component/alursistem.dart';
import 'package:idp_app/component/apksso.dart';
import 'package:idp_app/component/dashboardAdmin.dart';
import 'package:idp_app/component/widget/brnd_dashboard.dart';
import 'package:idp_app/component/widget/grafik.dart';
import 'package:idp_app/component/widget/model/test_grafik.dart';
import 'package:idp_app/localstorage/bio_user.dart';
import 'package:idp_app/localstorage/profileuser.dart';
import 'package:idp_app/main.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../component/apkssoAdmin.dart';
import '../component/brndAdminKryn.dart';

import '../localstorage/profileuserAdmin.dart';

// import 'package:flutter_background_service/flutter_background_service.dart';

class adminPage extends StatefulWidget {
  final cekMyExp;
  final myToken;

  adminPage({this.cekMyExp, this.myToken});
  // adminPage(this.jwt, this.payload);

  // factory adminPage.fromBase64(String jwt) {
  //   // Dekode payload dari JWT
  //   final parts = jwt.split(".");
  //   assert(parts.length == 3);

  //   final payload = parts[1];
  //   final normalized = base64Url.normalize(payload);
  //   final decodedBytes = base64Url.decode(normalized);
  //   final decodedString = utf8.decode(decodedBytes);

  //   return adminPage(jwt, json.decode(decodedString));
  // }

  // final String jwt;
  // final Map<String, dynamic> payload;

  @override
  _adminPageState createState() => _adminPageState();
}

class _adminPageState extends State<adminPage> {
  List imgList = [
    'Dashboard',
    'Kelola Akun\nMahasiswa',
    'Kelola Akun\nDosen',
    'Kelola Akun\nKaryawan'
  ];

  List imgApp = ['Dashboard', 'mhs', 'doss', 'staff'];
  final storage = FlutterSecureStorage();

  void sendStatus() {
    // checkValid();
  }

  SharedPreferences _prefs;

  String _savedNama = "";
  String _savedLevel = "";
  String _savedNoInduk = "";
  String _test = "";
  String _savedId = "";
  String _token = "";
  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();

    // print("Nama saved in SharedPreferences: $_savedNamaWP");
    _savedNama = _prefs.getString('myNama') ?? "";
    _savedLevel = _prefs.getString('myLevel') ?? "";
    _savedNoInduk = _prefs.getString('myNoInduk') ?? "";
    _test = _prefs.getString('myTest') ?? "";
    _savedId = _prefs.getString('myId') ?? "";
    _token = _prefs.getString('token') ?? "";

    setState(() {});
  }

  var cekName;
  String shareNama;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initSharedPreferences();

    // Workmanager().initialize(
    //   callbackDispatcher,
    // );

    setState(() {
      const duration = const Duration(minutes: 2);

      Timer.periodic(duration, (Timer timer) {
        sendStatus();
      });
    });
  }

  bool _dataSent = false;

  Future<void> saveData(String data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('data', data);
  }

  @override
  Widget build(BuildContext context) {
    // final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 83, 192),
        leading: null,
        actions: [
          IconButton(
              iconSize: 35,
              onPressed: () {
                // _launchURL();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => profileUserAdmin()),
                );
              },
              icon: Icon(LineAwesomeIcons.user))
        ],
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 50, left: 15, right: 15, bottom: 10),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 0, 83, 192),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(40),
                    bottomLeft: Radius.circular(40))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Text(
                      "Hi, ${_savedNama}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                          wordSpacing: 2,
                          color: Colors.white),
                    ),
                  ),
                ),
                // Animasi,
                Center(
                  child: Container(
                    // color: Colors.pink,
                    margin: EdgeInsets.only(top: 5, bottom: 10),
                    width: 200,
                    // width: MediaQuery.of(context).size.width,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      "Aplikasi Identity Provider\n${_savedLevel}",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // SizedBox(
          //   height: 20,
          // ),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 15, right: 15),
            child: Column(
              children: [
                Container(
                  width: 320,
                  height: 130,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          15) // Adjust the radius as needed
                      ),
                  child: Image.asset(
                    'assets/ubharanew.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [],
                ),
                SizedBox(
                  height: 10,
                ),
                GridView.builder(
                    itemCount: imgList.length,
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
                      return InkWell(
                        onTap: () {
                          if (imgList[index] == "Dashboard") {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => dashboard()));
                          } else if (imgList[index] ==
                              "Kelola Akun\nMahasiswa") {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => brndAdminMhs()));
                          } else if (imgList[index] == "Kelola Akun\nDosen") {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => brndAdminDsn()));
                          } else if (imgList[index] ==
                              "Kelola Akun\nKaryawan") {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => brndAdminKryn()));
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Color.fromARGB(255, 0, 83, 192),
                                Colors.red,
                              ],
                            ),
                          ),
                          child: Column(
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Image.asset(
                                    "assets/${imgApp[index]}.png",
                                    width: 100,
                                    height: 80,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                imgList[index],
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              // Text("")
                            ],
                          ),
                        ),
                      );
                    })
              ],
            ),
          )
        ],
      ),
    );
  }
}
