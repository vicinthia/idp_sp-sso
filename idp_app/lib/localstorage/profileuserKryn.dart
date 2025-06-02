import 'package:flutter/material.dart';
import 'package:idp_app/auth/login_page.dart';
import 'package:idp_app/localstorage/bio_user.dart';
import 'package:idp_app/localstorage/biodataDsn.dart';
import 'package:idp_app/localstorage/biodataKryn.dart';
import 'package:idp_app/localstorage/biodataMhs.dart';
import 'package:idp_app/localstorage/updateprofile.dart';
import 'package:idp_app/localstorage/updateprofileKryn.dart';
import 'package:idp_app/model/m_editprofile.dart';
import 'package:idp_app/pages/karyawan.dart';
import 'package:idp_app/pages/mahasiswa.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:http/http.dart' as http;
import 'package:idp_app/localstorage/multiDevice/sendToken.dart';

import '../api/link.dart';

class profileUserKryn extends StatefulWidget {
  @override
  _profileUserKrynState createState() => _profileUserKrynState();
}

class _profileUserKrynState extends State<profileUserKryn> {
  File _image;
  final picker = ImagePicker();

  SharedPreferences _prefs;
  String _savedNama = "";

  String _savedEmail = "";
  String _savedId = "";

  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();

    _savedNama = _prefs.getString('myNama') ?? "";

    _savedEmail = _prefs.getString('myEmail') ?? "";
    _savedId = _prefs.getString('myId') ?? "";

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadImage();
    _initSharedPreferences();
  }

  Future<void> userLogOut() async {
    final response = await http.put(
        Uri.parse(ApiConstants.baseUrl +
            "api/func_admin/StatusUserToken/index/${_savedId}"),
        body: {"id": _savedId, "status": 'false'});
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

  String namaUser;
  String noIndukUser;
  String noTelpUser;
  String emailUser;

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 83, 192),
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => karyawanPage()));
          },
          icon: Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text(
          "Profile",
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
        padding: const EdgeInsets.all(30),
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
                          icon: Icon(LineAwesomeIcons.pencil,
                              color: Colors.white))),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "${_savedNama}",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              "${_savedEmail}",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  User.getUsers(_savedId).then((users) {
                    namaUser = "";
                    noIndukUser = "";
                    noTelpUser = "";
                    emailUser = "";
                    for (int i = 0; i < users.length; i++)
                      namaUser = namaUser + users[i].name;
                    for (int i = 0; i < users.length; i++)
                      noIndukUser = noIndukUser + users[i].no_induk;
                    for (int i = 0; i < users.length; i++)
                      noTelpUser = noTelpUser + users[i].no_telp;
                    for (int i = 0; i < users.length; i++)
                      emailUser = emailUser + users[i].user_email;

                    setState(() {
                      setState(() {
                        // ppnInt = int.tryParse(m_Laporan.sum * 10);
                        // ppndob = ppnInt / 10;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => updateProfileKryn(
                                    nameController: namaUser,
                                    noIndukController: noIndukUser,
                                    noTelpController: noTelpUser,
                                    emailController: emailUser,
                                  )),
                        );
                      });
                    });
                  });
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
            Divider(),
            SizedBox(
              height: 10,
            ),
            ProfileMenuWidget(
                title: "Biodata",
                icon: LineAwesomeIcons.info,
                onPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => dataProfileKryn()));
                }),
            Divider(
              color: Colors.grey,
            ),
            SizedBox(
              height: 10,
            ),
            ProfileMenuWidget(
              title: "Perangkat Tertaut",
              icon: LineAwesomeIcons.mobile_phone,
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => sendQR()),
                );
              },
            ),
            Divider(
              color: Colors.grey,
            ),
            SizedBox(
              height: 10,
            ),
            ProfileMenuWidget(
              title: "Logout",
              icon: LineAwesomeIcons.sign_out,
              textColor: Colors.red,
              endIcon: false,
              onPress: () async {
                await CoolAlert.show(
                    context: context,
                    type: CoolAlertType.confirm,
                    text: "Apakah yakin logout aplikasi ?",
                    confirmBtnText: 'Yes',
                    cancelBtnText: "Cancel",
                    onConfirmBtnTap: () async {
                      setState(() {
                        userLogOut();
                      });
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.clear();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => loginPage()),
                      );
                    },
                    onCancelBtnTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => profileUserKryn()),
                      );
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color textColor;

  ProfileMenuWidget(
      {this.title,
      this.icon,
      this.onPress,
      this.endIcon = true,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    var iconColor = isDark ? Colors.blueAccent : Colors.white;
    return ListTile(
        onTap: onPress,
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.blueAccent.withOpacity(0.1),
          ),
          child: Icon(
            icon,
            color: Colors.blueAccent,
          ),
        ),
        title: Text(title,
            style:
                Theme.of(context).textTheme.bodyText1?.apply(color: textColor)),
        trailing: endIcon
            ? Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.grey.withOpacity(0.1),
                ),
                child: Icon(
                  LineAwesomeIcons.angle_right,
                  size: 18.0,
                  color: Colors.grey,
                ),
              )
            : null);
  }
}
