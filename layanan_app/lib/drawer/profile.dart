import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../mahasiswa/home_Mhs.dart';
import '../model/app1/client_sim.dart';

class dataProfile extends StatefulWidget {
  @override
  _dataProfileState createState() => _dataProfileState();
}

class _dataProfileState extends State<dataProfile> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _loadImage();
  }

  File _image;
  final picker = ImagePicker();

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
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 221, 27),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => homeMhs()),
            );
          },
          icon: Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text(
          "Biodata Mahasiswa",
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
            Consumer<UserSIM>(
              builder: (context, userModel, child) {
                if (userModel.isLoading) {
                  return CircularProgressIndicator(); // Show a loading spinner while fetching data
                } else if (userModel.errorMessage != null) {
                  return Text(
                      'Error: ${userModel.errorMessage}'); // Display error message
                } else {
                  return Form(
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
                                      color: Color.fromARGB(255, 255, 221, 27)),
                                  child: IconButton(
                                      iconSize: 20,
                                      onPressed: () {
                                        _getImage();
                                      },
                                      icon: Icon(LineAwesomeIcons.pencil,
                                          color: Colors.black))),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        TextFormField(
                          enabled: false,
                          controller: TextEditingController(
                              text: userModel.userLevel ?? 'No Status'),
                          decoration: InputDecoration(
                            // hintText: _savedLevel,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            prefixIconColor: Color.fromARGB(255, 255, 221, 27),
                            prefixIcon: Icon(LineAwesomeIcons.user),
                            floatingLabelStyle: TextStyle(
                                color: Color.fromARGB(255, 255, 221, 27)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 255, 221, 27))),
                            labelText: "User",
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          enabled: false,
                          controller: TextEditingController(
                              text: userModel.userName ?? 'No Nama'),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            prefixIconColor: Color.fromARGB(255, 255, 221, 27),
                            prefixIcon: Icon(LineAwesomeIcons.user_secret),
                            floatingLabelStyle: TextStyle(
                                color: Color.fromARGB(255, 255, 221, 27)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 255, 221, 27))),
                            labelText: "Nama Lengkap",
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          enabled: false,
                          controller: TextEditingController(
                              text: userModel.userInduk ?? 'No Induk'),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            prefixIconColor: Color.fromARGB(255, 255, 221, 27),
                            prefixIcon: Icon(LineAwesomeIcons.book),
                            floatingLabelStyle: TextStyle(
                                color: Color.fromARGB(255, 255, 221, 27)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 255, 221, 27))),
                            labelText: "NIM/NIDN",
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          enabled: false,
                          controller: TextEditingController(
                              text: userModel.userJurusan ?? 'No Jurusan'),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            prefixIconColor: Color.fromARGB(255, 255, 221, 27),
                            prefixIcon: Icon(LineAwesomeIcons.bookmark_o),
                            floatingLabelStyle: TextStyle(
                                color: Color.fromARGB(255, 255, 221, 27)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 255, 221, 27))),
                            labelText: "Jurusan",
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          enabled: false,
                          controller: TextEditingController(
                              text: userModel.userEmail ?? 'No Email'),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            prefixIconColor: Color.fromARGB(255, 255, 221, 27),
                            prefixIcon: Icon(LineAwesomeIcons.mail_forward),
                            floatingLabelStyle: TextStyle(
                                color: Color.fromARGB(255, 255, 221, 27)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 255, 221, 27))),
                            labelText: "Username (email)",
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
    ;
  }
}
