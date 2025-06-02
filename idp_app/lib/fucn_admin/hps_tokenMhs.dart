import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:cool_alert/cool_alert.dart';
import 'package:idp_app/fucn_admin/kendali_tokenMhs.dart';

import '../api/link.dart';

class hpsTokenMhs extends StatefulWidget {
  List list;
  int index;
  hpsTokenMhs({this.index, this.list});

  @override
  State<hpsTokenMhs> createState() => _hpsTokenMhsState();
}

class _hpsTokenMhsState extends State<hpsTokenMhs> {
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

  int semesterBerjalan;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // int year = now.year;
    // ThnMasuk = year.toString();
    // ThnMasukMhs = ThnMasuk.substring(ThnMasuk.length - 2);
    // Induk = widget.list[widget.index]['no_induk'].substring(0, 2);
    int year = now.year;
    ThnMasuk = year.toString();
    //Tahun Sekarang
    ThnMasukMhs = ThnMasuk.substring(ThnMasuk.length - 2);
    Induk = widget.list[widget.index]['no_induk'].substring(0, 2);

    setState(() {
      Semester =
          "${int.tryParse(ThnMasukMhs) - int.tryParse(widget.list[widget.index]['no_induk'].substring(0, 2))}";
      MySemester = "${int.tryParse(Semester) * 2}";
      semesterBerjalan = int.tryParse(MySemester);
      if (DateTime.now().month > 6) {
        semesterBerjalan += 1;
      }
    });
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
                  "Nomor Induk Mahasiswa : ${widget.list[widget.index]['no_induk']}",
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                    child: Text("Semester : ${semesterBerjalan}",
                        style: TextStyle(fontSize: 18.0))),
                Padding(padding: const EdgeInsets.only(top: 30.0)),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
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
                                              kendaliTokenMhs()),
                                    );
                                  },
                                  onCancelBtnTap: () async {
                                    Navigator.pop(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => hpsTokenMhs()),
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
