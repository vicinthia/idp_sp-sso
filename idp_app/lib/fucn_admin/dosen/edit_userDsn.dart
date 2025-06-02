import 'dart:convert';
import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:idp_app/auth/login_page.dart';
import 'package:idp_app/fucn_admin/dosen/list_userdsn.dart';
import 'package:idp_app/fucn_admin/list_usermhs.dart';
import 'package:idp_app/localstorage/profileuser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:idp_app/localstorage/bio_user.dart';

import '../../api/link.dart';

class editUserDsn extends StatefulWidget {
  final nameController;
  final noIndukController;
  final noTelpController;
  final emailController;
  final id;
  final dynamic user;

  editUserDsn(
      {this.nameController,
      this.emailController,
      this.noIndukController,
      this.noTelpController,
      this.id,
      this.user});
  @override
  _editUserDsnState createState() => _editUserDsnState();
}

class _editUserDsnState extends State<editUserDsn> {
  File _image;
  final picker = ImagePicker();

  TextEditingController nama;
  TextEditingController nim;
  TextEditingController no_telp;
  TextEditingController usernameEmail;
  String id;
  // TextEditingController pass;
  // TextEditingController jabatan;

  String induk;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      // _getData();
      nama = TextEditingController(text: widget.nameController);
      nim = TextEditingController(text: widget.noIndukController);
      no_telp = TextEditingController(text: widget.noTelpController);
      usernameEmail = TextEditingController(text: widget.emailController);
      id = widget.id;
    });
  }

  void editData() {
    var url = Uri.parse(
        ApiConstants.baseUrl + "api/func_admin/ListLevel/index/${id}");
    http.put(url, body: {
      "id": "${id}",
      "name": nama.text,
      "no_induk": nim.text,
      "no_telp": no_telp.text,
      "email": usernameEmail.text,
    });
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
              MaterialPageRoute(builder: (context) => adminDsn()),
            );
          },
          icon: Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text(
          "Edit User Profile",
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            // Stack(
            //   children: [
            //     SizedBox(
            //       width: 120,
            //       height: 120,
            //       child: ClipRRect(
            //         borderRadius: BorderRadius.circular(100),
            //         // child: Image(image: AssetImage("assets/ubhara.jpg"))),
            //         child: _image == null
            //             ? Image.asset("assets/user_profile.png")
            //             : Image.file(_image),
            //       ),
            //     ),
            //   ],
            // ),
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
                    controller: nim,
                    keyboardType: TextInputType.number,
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
                      labelText: induk,
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => adminDsn()));
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
