import 'dart:convert';
import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:idp_app/auth/login_page.dart';
import 'package:idp_app/localstorage/profileuser.dart';
import 'package:idp_app/localstorage/profileuserKryn.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:idp_app/localstorage/bio_user.dart';

import '../api/link.dart';

class updateProfileKryn extends StatefulWidget {
  final nameController;
  final noIndukController;
  final noTelpController;
  final emailController;

  updateProfileKryn(
      {this.nameController,
      this.emailController,
      this.noIndukController,
      this.noTelpController});
  @override
  _updateProfileKrynState createState() => _updateProfileKrynState();
}

class _updateProfileKrynState extends State<updateProfileKryn> {
  File _image;
  final picker = ImagePicker();

  TextEditingController nama;
  TextEditingController nidn;
  TextEditingController no_telp;
  TextEditingController usernameEmail;
  // TextEditingController pass;
  // TextEditingController jabatan;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadImage();
    setState(() {
      // _getData();
      nama = TextEditingController(text: widget.nameController);
      nidn = TextEditingController(text: widget.noIndukController);
      no_telp = TextEditingController(text: widget.noTelpController);
      usernameEmail = TextEditingController(text: widget.emailController);
      _initSharedPreferences();
    });
  }

  void editData() {
    var url =
        Uri.parse(ApiConstants.baseUrl + "api/CrudUser/index/${_savedId}");
    http.put(url, body: {
      "id": "${_savedId}",
      "name": nama.text,
      "no_induk": nidn.text,
      "no_telp": no_telp.text,
      "email": usernameEmail.text,
    });
    setState(() {
      _saveNama("${nama.text}");
      _saveNoInduk("${nidn.text}");
      _saveNoTelp("${no_telp.text}");
      _saveEmail("${usernameEmail.text}");
    });
  }

  String _savedNama = "";
  String _savedNoInduk = "";
  String _savedNoTelp = "";
  String _savedEmail = "";
  String _savedId = "";
  SharedPreferences _prefs;

  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();

    // print("Nama saved in SharedPreferences: $_savedNamaWP");
    _savedNama = _prefs.getString('myNama') ?? "";
    _savedNoInduk = _prefs.getString('myNoInduk') ?? "";
    _savedNoTelp = _prefs.getString('myNoTelp') ?? "";
    _savedEmail = _prefs.getString('myEmail') ?? "";
    _savedId = _prefs.getString('myId') ?? "";
    setState(() {});
  }

  //// Nama WP /////
  Future<void> _saveNama(String text) async {
    await _prefs.setString('myNama', text);
    print("Nama saved in SharedPreferences: $text");
    setState(() {
      _savedNama = text;
      GlobalData.setMyNama("${_savedNama}");
      // print("DIGET ${GlobalData.getMyNama()}");
    });
  }

  //// NoInduk WP /////
  Future<void> _saveNoInduk(String text) async {
    await _prefs.setString('myNoInduk', text);
    // print("Alamat saved in SharedPreferences: $text");
    setState(() {
      _savedNoInduk = text;
      GlobalData.setMyNoInduk("${_savedNoInduk}");
    });
  }

  //// No Telp /////
  Future<void> _saveNoTelp(String text) async {
    await _prefs.setString('myNoTelp', text);
    // print("Alamat saved in SharedPreferences: $text");
    setState(() {
      _savedNoTelp = text;
      GlobalData.setMyNoTelp("${_savedNoTelp}");
    });
  }

  //// Email /////
  Future<void> _saveEmail(String text) async {
    await _prefs.setString('myEmail', text);
    // print("Alamat saved in SharedPreferences: $text");
    setState(() {
      _savedEmail = text;
      GlobalData.setMyEmail("${_savedEmail}");
    });
  }

  _loadImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String imagePath = prefs.getString('profile_image');
    if (imagePath != null) {
      setState(() {
        _image = File(imagePath);
      });
    }
  }

  Future _getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _saveImage(_image.path);
      }
    });
  }

  _saveImage(String imagePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('profile_image', imagePath);
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
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
          "Edit Profile",
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                  isDark ? LineAwesomeIcons.moon_o : LineAwesomeIcons.sun_o))
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    // child: Image(image: AssetImage("assets/ubhara.jpg"))),
                    child: _image == null
                        ? Image.asset("assets/user_profile.png")
                        : Image.file(_image),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Color.fromARGB(255, 0, 83, 192)),
                      child: IconButton(
                          iconSize: 20,
                          onPressed: () {
                            _getImage();
                          },
                          icon: Icon(LineAwesomeIcons.camera,
                              color: Colors.white))),
                )
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: nama,
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
                      labelText: "Nama Lengkap",
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: nidn,
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
                    controller: no_telp,
                    keyboardType: TextInputType.number,
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
                    controller: usernameEmail,
                    keyboardType: TextInputType.emailAddress,
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
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  editData();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => profileUserKryn()));
                  await CoolAlert.show(
                      context: context,
                      type: CoolAlertType.success,
                      title: "Berhasil Edit Profile",
                      text: "Data terupdate!",
                      confirmBtnText: "Ok");
                  setState(() {});
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 0, 83, 192),
                  side: BorderSide.none,
                  shape: StadiumBorder(),
                ),
                child: Text(
                  "Edit Profile",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
