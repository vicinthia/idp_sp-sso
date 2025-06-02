import 'package:flutter/material.dart';
import 'package:idp_app/localstorage/bio_user.dart';
import 'package:idp_app/localstorage/profileuser.dart';
import 'package:idp_app/localstorage/profileuserKryn.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class dataProfileKryn extends StatefulWidget {
  @override
  _dataProfileKrynState createState() => _dataProfileKrynState();
}

class _dataProfileKrynState extends State<dataProfileKryn> {
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
        backgroundColor: Color.fromARGB(255, 0, 83, 192),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => profileUserKryn()),
            );
          },
          icon: Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text(
          "Biodata Karyawan",
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    enabled: false,
                    controller: TextEditingController(text: _savedLevel),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      prefixIconColor: Color.fromARGB(255, 0, 83, 192),
                      prefixIcon: Icon(LineAwesomeIcons.user),
                      floatingLabelStyle:
                          TextStyle(color: Color.fromARGB(255, 0, 83, 192)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 0, 83, 192))),
                      labelText: "User",
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    enabled: false,
                    controller: TextEditingController(text: _savedNama),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      prefixIconColor: Color.fromARGB(255, 0, 83, 192),
                      prefixIcon: Icon(LineAwesomeIcons.user_secret),
                      floatingLabelStyle:
                          TextStyle(color: Color.fromARGB(255, 0, 83, 192)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 0, 83, 192))),
                      labelText: "Nama Lengkap",
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    enabled: false,
                    controller: TextEditingController(text: _savedNoInduk),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      prefixIconColor: Color.fromARGB(255, 0, 83, 192),
                      prefixIcon: Icon(LineAwesomeIcons.book),
                      floatingLabelStyle:
                          TextStyle(color: Color.fromARGB(255, 0, 83, 192)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 0, 83, 192))),
                      labelText: "Jabatan",
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    enabled: false,
                    controller: TextEditingController(text: _savedJurusan),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      prefixIconColor: Color.fromARGB(255, 0, 83, 192),
                      prefixIcon: Icon(LineAwesomeIcons.bookmark_o),
                      floatingLabelStyle:
                          TextStyle(color: Color.fromARGB(255, 0, 83, 192)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 0, 83, 192))),
                      labelText: "Jurusan",
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    enabled: false,
                    controller: TextEditingController(text: _savedNoTelp),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      prefixIconColor: Color.fromARGB(255, 0, 83, 192),
                      prefixIcon: Icon(LineAwesomeIcons.phone),
                      floatingLabelStyle:
                          TextStyle(color: Color.fromARGB(255, 0, 83, 192)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 0, 83, 192))),
                      labelText: "Nomor Telp",
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    enabled: false,
                    controller: TextEditingController(text: _savedEmail),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      prefixIconColor: Color.fromARGB(255, 0, 83, 192),
                      prefixIcon: Icon(LineAwesomeIcons.mail_forward),
                      floatingLabelStyle:
                          TextStyle(color: Color.fromARGB(255, 0, 83, 192)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 0, 83, 192))),
                      labelText: "Username (email)",
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
    ;
  }
}
