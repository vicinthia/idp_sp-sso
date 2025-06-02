import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:idp_app/fucn_admin/Client_Mhs/select_inforClient.dart';

import '../../api/link.dart';

class allKrynInfor extends StatefulWidget {
  @override
  State<allKrynInfor> createState() => _allKrynInforState();
}

class _allKrynInforState extends State<allKrynInfor> {
  TextEditingController searchController = TextEditingController();
  String filter, pickSemester;
  String number;
  String selectedValue;
  String tglOut;

  int quantity;

  Future<List<MenuModel>> fetchMenuModels() async {
    var response = await http.get(Uri.parse(ApiConstants.baseUrl +
        "api/func_admin/ClientLevel/index?level=Karyawan&&jurusan=Teknik Informatika"));
    return (json.decode(response.body)['data'] as List)
        .map((e) => MenuModel.fromJson(e))
        .toList();
  }

  DateTime now = DateTime.now();
  String ThnMasuk = '';
  String ThnMasukMhs = '';
  String MySemester = '';
  String daftar = '';
  int semesLevel;
  int thnAkademik;
  String listNIM;

  @override
  initState() {
    // pickSemester = "Semester 1";
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

  bool buttonenabled = true;

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
                  hintText: "Cari Nama Karyawan Informatika"),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: FutureBuilder<List<MenuModel>>(
                    future: fetchMenuModels(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<MenuModel> menumodels =
                            snapshot.data as List<MenuModel>;
                        return ListView.builder(
                          itemCount: menumodels.length,
                          itemBuilder: (context, index) {
                            // joinSemester("${menumodels[index].no_induk}");
                            return filter == null || filter == ""
                                ? ListTile(
                                    title: Text(
                                        menumodels[index].name.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18)),
                                    subtitle: Text(
                                        'Jabatan : ${menumodels[index].no_induk}'),
                                  )
                                : '${menumodels[index].name}'
                                        .toLowerCase()
                                        .contains(filter.toLowerCase())
                                    ? ListTile(
                                        title: Text(menumodels[index].name,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                        subtitle: Text(
                                            'Jabatan : ${menumodels[index].no_induk}'),
                                      )
                                    : new Container();
                          },
                        );
                      }

                      if (snapshot.hasError) {
                        print(snapshot.error.toString());
                        return Text('error');
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class MenuModel {
  String id;
  String no_induk;
  String username;
  String name;

  MenuModel({
    this.id,
    this.no_induk,
    this.username,
    this.name,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    return MenuModel(
      id: json['id'],
      username: json['username'],
      name: json['name'],
      no_induk: json['no_induk'],
    );
  }
}
