import 'dart:math';

import 'package:flutter/material.dart';
import 'package:idp_app/fucn_admin/Client_Mhs/elektro_client.dart';
import 'package:idp_app/fucn_admin/Client_Mhs/infor_client.dart';
import 'package:idp_app/fucn_admin/Client_Mhs/sipil_client.dart';
import 'package:simple_icons/simple_icons.dart';

import '../Client_Dsn/elektro_clientDsn.dart';
import '../Client_Dsn/infor_clientDsn.dart';
import '../Client_Dsn/sipil_clientDsn.dart';
import '../modelCountUser.dart';

class brndClientDosen extends StatefulWidget {
  @override
  _brndClientDosenState createState() => _brndClientDosenState();
}

class _brndClientDosenState extends State<brndClientDosen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 83, 192),
        title: Text('Client SSO Dosen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            cardDsnInfor(),
            SizedBox(height: 20),
            cardDsnElektro(),
            SizedBox(height: 20),
            cardDsnSipil(),
          ],
        ),
      ),
    );
  }
}

class cardDsnInfor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, int>>(
      future: fetchSumData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final userCounts = snapshot.data;
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(80.0),
                  topLeft: Radius.circular(15.0),
                  bottomLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ]),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(90.0),
                topLeft: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0),
                bottomRight: Radius.circular(20.0),
              ),
              child: GestureDetector(
                onTap: () {
                  // print("oked");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => allDsnInfor()));
                },
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Prodi',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            Icon(
                              SimpleIcons.databricks,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              'Teknik Informatika',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Total User Dosen Informatika : ${userCounts['Dosen_Teknik_Informatika'] ?? 0}',
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.04,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

class cardDsnElektro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, int>>(
      future: fetchSumData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final userCounts = snapshot.data;
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(80.0),
                  topLeft: Radius.circular(15.0),
                  bottomLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ]),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(90.0),
                topLeft: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0),
                bottomRight: Radius.circular(20.0),
              ),
              child: GestureDetector(
                onTap: () {
                  // print("oked");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => allDsnElektro()));
                },
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Prodi',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            Icon(
                              SimpleIcons.databricks,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              'Teknik Elektro',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Total User Dosen Elektronika : ${userCounts['Dosen_Teknik_Elektronika'] ?? 0}',
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.04,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

class cardDsnSipil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, int>>(
      future: fetchSumData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final userCounts = snapshot.data;
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(80.0),
                  topLeft: Radius.circular(15.0),
                  bottomLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ]),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(90.0),
                topLeft: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0),
                bottomRight: Radius.circular(20.0),
              ),
              child: GestureDetector(
                onTap: () {
                  // print("oked");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => allDsnSipil()));
                },
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Prodi',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            Icon(
                              SimpleIcons.databricks,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              'Teknik Sipil',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Total User Dosen Sipil : ${userCounts['Dosen_Teknik_Sipil'] ?? 0}',
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.04,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
