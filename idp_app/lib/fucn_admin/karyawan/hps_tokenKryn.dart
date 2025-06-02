import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:cool_alert/cool_alert.dart';
import 'package:idp_app/fucn_admin/dosen/kendali_tokenDsn.dart';
import 'package:idp_app/fucn_admin/karyawan/kendali_tokenKryn.dart';
import 'package:idp_app/fucn_admin/kendali_tokenMhs.dart';

import '../../api/link.dart';

class hpsTokenKryn extends StatefulWidget {
  List list;
  int index;
  hpsTokenKryn({this.index, this.list});

  @override
  State<hpsTokenKryn> createState() => _hpsTokenKrynState();
}

class _hpsTokenKrynState extends State<hpsTokenKryn> {
  void revokeToken() {
    var url = Uri.parse(ApiConstants.baseUrl +
        "api/func_admin/RevokeToken/index/${widget.list[widget.index]['id']}");
    http.put(url, body: {
      "id": "${widget.list[widget.index]['id']}",
      "refresh_token": "revoke",
    });
  }

  DateTime now = DateTime.now();
  String Semester;
  String ThnMasuk;
  String ThnMasukMhs;
  String MySemester;
  String Induk = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 0, 83, 192),
          title: Text("Data ID Master ${widget.list[widget.index]['id']}"),
        ),
        body: new Container(
          height: 300.0,
          padding: const EdgeInsets.all(10.0),
          child: Card(
            child: Center(
              child: Column(children: <Widget>[
                Padding(padding: const EdgeInsets.only(top: 30.0)),
                Text(
                  "ID User : ${widget.list[widget.index]['id']}",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Username : ${widget.list[widget.index]['email']}",
                  style: TextStyle(fontSize: 18.0),
                ),
                Text(
                  "Nama : ${widget.list[widget.index]['name']}",
                  style: TextStyle(fontSize: 18.0),
                ),
                Text(
                  "Jabatan : ${widget.list[widget.index]['no_induk']}",
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(
                  height: 20,
                ),
                // Center(
                //     child: Text("Semester : ${MySemester}",
                //         style: TextStyle(fontSize: 18.0))),
                Padding(padding: const EdgeInsets.only(top: 30.0)),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // ElevatedButton(
                    //   onPressed: () => Navigator.of(context).push(
                    //       MaterialPageRoute(
                    //           builder: (BuildContext context) => EditMenu(
                    //               list: widget.list, index: widget.index))),
                    //   child: Text("EDIT",
                    //       style: TextStyle(
                    //           fontSize: 20,
                    //           fontWeight: FontWeight.w500,
                    //           color: Colors.white)),
                    //   style: ElevatedButton.styleFrom(
                    //     primary: Colors.green,
                    //   ),
                    // ),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      onPressed: widget.list[widget.index]['refresh_token'] ==
                              'revoke'
                          ? null
                          : () async {
                              await CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.confirm,
                                  text: "Apakah yakin revoke access token ?",
                                  confirmBtnText: 'Yes',
                                  cancelBtnText: "Cancel",
                                  onConfirmBtnTap: () async {
                                    revokeToken();
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              kendaliTokenKryn()),
                                    );
                                  },
                                  onCancelBtnTap: () async {
                                    Navigator.pop(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => hpsTokenKryn()),
                                    );
                                  });
                            },
                      child: Text("REVOKE TOKEN",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.redAccent,
                      ),
                    )
                  ],
                ),
              ]),
            ),
          ),
        ));
  }
}
