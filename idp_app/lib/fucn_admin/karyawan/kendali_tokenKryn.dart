import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'package:idp_app/component/brndAdminDsn.dart';
import 'package:idp_app/component/brndAdminKryn.dart';
import 'package:idp_app/component/brndAdminMhs.dart';
import 'package:idp_app/fucn_admin/edit_userMhs.dart';
import 'package:idp_app/fucn_admin/hps_tokenMhs.dart';
import 'package:idp_app/model/m_editprofile.dart';
import 'package:intl/intl.dart';

import '../../api/link.dart';
import 'hps_tokenKryn.dart';

class kendaliTokenKryn extends StatefulWidget {
  const kendaliTokenKryn({Key key}) : super(key: key);

  @override
  State<kendaliTokenKryn> createState() => _kendaliTokenKrynState();
}

class _kendaliTokenKrynState extends State<kendaliTokenKryn> {
  String Harga;
  TextEditingController Hargacontroller = new TextEditingController();

  Future<List> getData() async {
    final response = await http.get(Uri.parse(
        ApiConstants.baseUrl + "api/func_admin/ListLevel/index/Karyawan"));
    return json.decode(response.body)['data'];
  }

  String stsToken;
  String dataToken;

  @override
  void initState() {
    getData();
    searchController.addListener(() {
      setState(() {
        filter = searchController.text;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  TextEditingController searchController = TextEditingController();
  String filter, menuName;
  String selectedValue;
  String tglOut;
  List categoryItemList = [
    "Makanan",
    "Snack",
    "Chinese Food",
    "Minuman Dingin",
    "Minuman Hangat"
  ];
  // List categoryItemList = List();
  List categoryType = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 0, 83, 192),
          title: Container(
            decoration: BoxDecoration(
                color: Colors.blue.shade200,
                borderRadius: BorderRadius.circular(30)),
            child: TextField(
              onChanged: (value) {},
              controller: searchController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.all(15),
                  hintText: "Cari Username"),
            ),
          ),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => brndAdminKryn()));
              })),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FutureBuilder<List>(
                future: getData(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);
                  return snapshot.hasData
                      ? Text("Kelola Akun Token User Karyawan",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold))
                      : const Center(
                          child: Text(
                            "Loading..",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                backgroundColor: Colors.yellow),
                          ),
                        );
                },
              ),
              SizedBox(height: 20),
              Expanded(
                child: FutureBuilder<List>(
                  future: getData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);
                    return snapshot.hasData
                        ? ListView.builder(
                            physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, i) {
                              return filter == null || filter == ""
                                  ? Container(
                                      child: GestureDetector(
                                      onTap: () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  hpsTokenKryn(
                                                    list: snapshot.data,
                                                    index: i,
                                                  ))),
                                      child: Card(
                                          child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                // Image.asset("assets/burger.png", height: 70, width: 100),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Username : ${snapshot.data[i]['email']}",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        "Nama Karyawan : ${snapshot.data[i]['name']}",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        "Refresh Token : ${snapshot.data[i]['refresh_token']}",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: Container(
                                                          width: 180,
                                                          height: 35,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: snapshot.data[
                                                                            i][
                                                                        'refresh_token'] ==
                                                                    'revoke'
                                                                ? Colors.red
                                                                : snapshot.data[i]
                                                                            [
                                                                            'refresh_token'] ==
                                                                        null
                                                                    ? Colors
                                                                        .grey
                                                                    : Colors
                                                                        .green,
                                                            borderRadius: BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        20),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        20)),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 6.0),
                                                            child: Text(
                                                              snapshot.data[i][
                                                                          'refresh_token'] ==
                                                                      'revoke'
                                                                  ? 'Token Revoke'
                                                                  : snapshot.data[i]
                                                                              [
                                                                              'refresh_token'] ==
                                                                          null
                                                                      ? 'Token Not Created'
                                                                      : 'Token Active',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 18,
                                                                  fontFamily:
                                                                      'Poppins-Medium',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width: 20),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      )),
                                    ))
                                  : '${snapshot.data[i]['email']}'
                                          .toLowerCase()
                                          .contains(filter.toLowerCase())
                                      ? Container(
                                          child: GestureDetector(
                                          onTap: () => Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          hpsTokenKryn(
                                                            list: snapshot.data,
                                                            index: i,
                                                          ))),
                                          child: Card(
                                              child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    // Image.asset("assets/burger.png", height: 70, width: 100),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Username : ${snapshot.data[i]['email']}",
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            "Nama Karyawan : ${snapshot.data[i]['name']}",
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            "Refresh Token : ${snapshot.data[i]['refresh_token']}",
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Align(
                                                            alignment: Alignment
                                                                .centerRight,
                                                            child: Container(
                                                              width: 180,
                                                              height: 35,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: snapshot.data[i]
                                                                            [
                                                                            'refresh_token'] ==
                                                                        'revoke'
                                                                    ? Colors.red
                                                                    : snapshot.data[i]['refresh_token'] ==
                                                                            null
                                                                        ? Colors
                                                                            .grey
                                                                        : Colors
                                                                            .green,
                                                                borderRadius: BorderRadius.only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            20),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            20)),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            6.0),
                                                                child: Text(
                                                                  snapshot.data[i]
                                                                              [
                                                                              'refresh_token'] ==
                                                                          'revoke'
                                                                      ? 'Token Revoke'
                                                                      : snapshot.data[i]['refresh_token'] ==
                                                                              null
                                                                          ? 'Token Not Created'
                                                                          : 'Token Active',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          18,
                                                                      fontFamily:
                                                                          'Poppins-Medium',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(width: 20),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          )),
                                        ))
                                      : new Container();
                            },
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          );
                  },
                ),
              )
            ]),
      ),
    );
  }
}
