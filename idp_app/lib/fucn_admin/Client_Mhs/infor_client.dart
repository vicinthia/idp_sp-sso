import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:idp_app/fucn_admin/Client_Mhs/select_inforClient.dart';

import '../../api/link.dart';

class allMhsInfor extends StatefulWidget {
  @override
  State<allMhsInfor> createState() => _allMhsInforState();
}

class _allMhsInforState extends State<allMhsInfor> {
  TextEditingController searchController = TextEditingController();
  String filter, pickSemester;
  String number;
  String selectedValue;
  String tglOut;

  int quantity;
  List<String> semesterList;

  bool isOddSemester() {
    int month = DateTime.now().month;
    return month >= 9 || month <= 12;
  }

  List<String> getSemesterList() {
    if (isOddSemester()) {
      return [
        'Semester 1',
        'Semester 3',
        'Semester 5',
        'Semester 7',
        'Semester 9',
        'Semester 11',
        'Semester 13'
      ];
    } else {
      return [
        'Semester 2',
        'Semester 4',
        'Semester 6',
        'Semester 8',
        'Semester 10',
        'Semester 12',
        'Semester 14'
      ];
    }
  }

  Future<List<MenuModel>> fetchMenuModels() async {
    var response = await http.get(Uri.parse(ApiConstants.baseUrl +
        "api/func_admin/ClientLevel/index?level=Mahasiswa&&jurusan=Teknik Informatika"));
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
    semesterList = getSemesterList();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  bool buttonenabled = true;

  Future<void> joinSemester(String pick) async {
    int year = now.year;

    ThnMasuk = year.toString();
    ThnMasukMhs = ThnMasuk.substring(ThnMasuk.length - 2);
    print("ThnMasukMhsku: $ThnMasukMhs");

    switch (pick) {
      case "Semester 1":
        semesLevel = 1;
        break;
      case "Semester 2":
        semesLevel = 2;
        break;
      case "Semester 3":
        semesLevel = 3;
        break;
      case "Semester 4":
        semesLevel = 4;
        break;
      case "Semester 5":
        semesLevel = 5;
        break;
      case "Semester 6":
        semesLevel = 6;
        break;
      case "Semester 7":
        semesLevel = 7;
        break;
      case "Semester 8":
        semesLevel = 8;
        break;
      case "Semester 9":
        semesLevel = 9;
        break;
      case "Semester 10":
        semesLevel = 10;
        break;
      case "Semester 11":
        semesLevel = 11;
        break;
      case "Semester 12":
        semesLevel = 12;
        break;
      case "Semester 13":
        semesLevel = 13;
        break;
      case "Semester 14":
        semesLevel = 14;
        break;
      default:
    }

    setState(() {
      thnAkademik = (semesLevel / 2).toInt();
      // Jika smester ganjil
      if (semesLevel % 2 != 0) {
        daftar =
            (int.tryParse(ThnMasukMhs) - thnAkademik + 0.5).toInt().toString();
        print("Akademik " + daftar);
      } else {
        daftar = (int.tryParse(ThnMasukMhs) - thnAkademik).toString();
        print("Akademik" + daftar);
      }
    });
  }

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
                  hintText: "Cari NIM Mahasiswa Informatika"),
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
                FutureBuilder<List<MenuModel>>(
                  future: fetchMenuModels(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<MenuModel> menumodels =
                          snapshot.data as List<MenuModel>;
                      return DropdownButton<String>(
                        isExpanded: true,
                        hint: Text('Pilih Semester'),
                        value: pickSemester,
                        onChanged: (String newValue) {
                          setState(() {
                            pickSemester = newValue;
                            if (menumodels.isNotEmpty) {
                              joinSemester(pickSemester).then((_) {
                                print("Daftar sebelum navigasi: $daftar");
                                print(pickSemester);
                              });
                            }
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        selectMhsInfor(menuName: daftar)));
                            setState(() {});
                          });
                        },
                        items: semesterList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      );
                    }
                    if (snapshot.hasError) {
                      print(snapshot.error.toString());
                      return Text('error');
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
                SizedBox(height: 20),
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
                                        'NIM : ${menumodels[index].no_induk}'),
                                  )
                                : '${menumodels[index].no_induk}'
                                        .toLowerCase()
                                        .contains(filter.toLowerCase())
                                    ? ListTile(
                                        title: Text(menumodels[index].name,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                        subtitle: Text(
                                            'NIM : ${menumodels[index].no_induk}'),
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
