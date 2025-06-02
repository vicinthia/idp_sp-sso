import 'package:flutter/material.dart';
import 'package:idp_app/component/aboutsso.dart';
import 'package:idp_app/component/alursistem.dart';
import 'package:idp_app/component/apksso.dart';
import 'package:idp_app/component/apkssoDsn.dart';
import 'package:idp_app/component/dashboardAdmin.dart';
import 'package:idp_app/localstorage/bio_user.dart';
import 'package:idp_app/localstorage/profileuser.dart';
import 'package:idp_app/localstorage/profileuserDsn.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class dosenPage extends StatefulWidget {
  @override
  _dosenPageState createState() => _dosenPageState();
}

class _dosenPageState extends State<dosenPage> {
  List imgList = ['Alur Sistem', 'Aplikasi\nTerintegrasi SSO', 'About SSO'];

  List imgApp = ['Alur Sistem', 'app', 'info'];

  SharedPreferences _prefs;
  String _savedNama = "";
  String _savedLevel = "";
  String _savedNoInduk = "";
  String _savedNoTelp = "";
  String _savedEmail = "";
  String _savedJurusan = "";
  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();

    _savedNama = _prefs.getString('myNama') ?? "";
    _savedLevel = _prefs.getString('myLevel') ?? "";
    _savedNoInduk = _prefs.getString('myNoInduk') ?? "";
    _savedNoTelp = _prefs.getString('myNoTelp') ?? "";
    _savedEmail = _prefs.getString('myEmail') ?? "";
    _savedJurusan = _prefs.getString('myJurusan') ?? "";

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        backgroundColor: Color.fromARGB(255, 0, 83, 192),
        actions: [
          IconButton(
              iconSize: 35,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => profileUserDsn()),
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
                          // if (imgList[index] == "Dashboard") {
                          //   Navigator.of(context).push(MaterialPageRoute(
                          //       builder: (context) => dashboard()));
                          if (imgList[index] == "Alur Sistem") {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => alurSistem()));
                          } else if (imgList[index] ==
                              "Aplikasi\nTerintegrasi SSO") {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => apkSSODsn()));
                          } else if (imgList[index] == "About SSO") {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => aboutSSO()));
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
