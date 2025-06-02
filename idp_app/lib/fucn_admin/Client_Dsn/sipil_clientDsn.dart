// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:idp_app/fucn_admin/Client_Mhs/select_inforClient.dart';

// import '../../api/link.dart';

// class allDsnSipil extends StatefulWidget {
//   @override
//   State<allDsnSipil> createState() => _allDsnSipilState();
// }

// class _allDsnSipilState extends State<allDsnSipil> {
//   TextEditingController searchController = TextEditingController();
//   String filter, pickSemester;
//   String number;
//   String selectedValue;
//   String tglOut;

//   int quantity;

//   Future<List<MenuModel>> fetchMenuModels() async {
//     var response = await http.get(Uri.parse(ApiConstants.baseUrl +
//         "api/func_admin/clientLevel?level=Dosen&&jurusan=Teknik Sipil"));
//     return (json.decode(response.body)['data'] as List)
//         .map((e) => MenuModel.fromJson(e))
//         .toList();
//   }

//   DateTime now = DateTime.now();
//   String ThnMasuk = '';
//   String ThnMasukMhs = '';
//   String MySemester = '';
//   String daftar = '';
//   int semesLevel;
//   int thnAkademik;
//   String listNIM;

//   @override
//   initState() {
//     // pickSemester = "Semester 1";
//     searchController.addListener(() {
//       setState(() {
//         filter = searchController.text;
//       });
//     });

//     super.initState();
//   }

//   @override
//   void dispose() {
//     searchController.dispose();
//     super.dispose();
//   }

//   bool buttonenabled = true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         resizeToAvoidBottomInset: false,
//         appBar: AppBar(
//           title: Container(
//             decoration: BoxDecoration(
//                 color: Colors.blue.shade200,
//                 borderRadius: BorderRadius.circular(30)),
//             child: TextField(
//               onChanged: (value) {},
//               controller: searchController,
//               decoration: InputDecoration(
//                   border: InputBorder.none,
//                   errorBorder: InputBorder.none,
//                   enabledBorder: InputBorder.none,
//                   focusedBorder: InputBorder.none,
//                   contentPadding: EdgeInsets.all(15),
//                   hintText: "Cari NIDN Dosen Sipil"),
//             ),
//           ),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Expanded(
//                   child: FutureBuilder<List<MenuModel>>(
//                     future: fetchMenuModels(),
//                     builder: (context, snapshot) {
//                       if (snapshot.hasData) {
//                         List<MenuModel> menumodels =
//                             snapshot.data as List<MenuModel>;
//                         return ListView.builder(
//                           itemCount: menumodels.length,
//                           itemBuilder: (context, index) {
//                             // joinSemester("${menumodels[index].no_induk}");
//                             return filter == null || filter == ""
//                                 ? ListTile(
//                                     title: Text(
//                                         menumodels[index].name.toString(),
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 18)),
//                                     subtitle: Text(
//                                         'NIDN : ${menumodels[index].no_induk}'),
//                                   )
//                                 : '${menumodels[index].no_induk}'
//                                         .toLowerCase()
//                                         .contains(filter.toLowerCase())
//                                     ? ListTile(
//                                         title: Text(menumodels[index].name,
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 18)),
//                                         subtitle: Text(
//                                             'NIDN : ${menumodels[index].no_induk}'),
//                                       )
//                                     : new Container();
//                           },
//                         );
//                       }

//                       if (snapshot.hasError) {
//                         print(snapshot.error.toString());
//                         return Text('error');
//                       }
//                       return Center(child: CircularProgressIndicator());
//                     },
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ));
//   }
// }

// class MenuModel {
//   String id;
//   String no_induk;
//   String username;
//   String name;

//   MenuModel({
//     this.id,
//     this.no_induk,
//     this.username,
//     this.name,
//   });

//   factory MenuModel.fromJson(Map<String, dynamic> json) {
//     return MenuModel(
//       id: json['id'],
//       username: json['username'],
//       name: json['name'],
//       no_induk: json['no_induk'],
//     );
//   }
// }

import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:idp_app/fucn_admin/Client_Dsn/pop_elektoDsn.dart';
import 'package:idp_app/fucn_admin/Client_Dsn/pop_sipilDsn.dart';
import 'package:idp_app/fucn_admin/Client_Mhs/select_inforClient.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../api/link.dart';

class allDsnSipil extends StatefulWidget {
  @override
  State<allDsnSipil> createState() => _allDsnSipilState();
}

class _allDsnSipilState extends State<allDsnSipil> {
  TextEditingController searchController = TextEditingController();
  String filter, pickSemester;
  String number;
  String selectedValue;
  String tglOut;

  int quantity;

  Future<List<MenuModel>> fetchMenuModels() async {
    var response = await http.get(Uri.parse(ApiConstants.baseUrl +
        "api/func_admin/ClientLevel/index?level=Dosen&&jurusan=Teknik Sipil"));
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
  String appUser;

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

  String _savedId = "";
  String userId;
  SharedPreferences _prefs;

  List<String> filterMenu = [];
  List<String> filterClientId = [];
  List<String> _isLocked = [];

  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();

    _savedId = _prefs.getString('myId') ?? "";

    setState(() {});
  }

  Future<void> apk() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _userId = userId; // Ambil user_id dari SharedPreferences

    if (_userId != null) {
      // Langkah 1: Ambil data name_client, client_id, dan secret_id dari REST API berdasarkan user_id
      List<Map<String, String>> clientDataList =
          await getClientDataFromAPI(_userId);

      if (clientDataList != null && clientDataList.isNotEmpty) {
        // Mengisi filterMenu dengan name_client dan filterGbr dengan gambar yang sesuai
        setState(() {
          filterMenu = clientDataList
              .map((clientData) => clientData['name_client'])
              .toList();
          filterClientId = clientDataList
              .map((clientData) => clientData['client_id'])
              .toList();
          // _isLocked = List<bool>.filled(filterMenu.length, false);
          _isLocked = clientDataList
              .map((clientData) => clientData['client_secret'])
              .toList();
        });

        print('filterMenu: $filterMenu'); // Debug statement

      } else {
        print('No clients found for userId: $userId');
        setState(() {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Pendaftaran Tidak Ditemukan"),
                content: Text(
                    "Anda belum login Aplikasi Penyedia Layanan!\nsegera login dahulu!"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Tutup alert dialog
                    },
                    child: Text("OK"),
                  ),
                ],
              );
            },
          );
        });
      }
    } else {
      print('User ID not found');
    }
  }

  // Fungsi untuk mengambil data dari REST API
  Future<List<Map<String, String>>> getClientDataFromAPI(String userId) async {
    final url = Uri.parse(ApiConstants.baseUrl +
        'api/getClient/GetListClient/index?user_id=$userId');

    // Melakukan GET request ke REST API
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      // Jika permintaan berhasil, decode respons JSON
      final Map<String, dynamic> data = jsonDecode(response.body);

      // Mengakses daftar dari objek JSON
      final List<dynamic> clients = data['data'];

      // Konversi data ke List<Map<String, String>>
      return clients.map((item) {
        return {
          'name_client': item['name_client']?.toString() ?? '',
          'client_id': item['client_id']?.toString() ?? '',
          'client_secret': item['client_secret']?.toString() ?? '',
          'image': item['image']?.toString() ?? ''
        };
      }).toList();
    } else {
      // Jika gagal, kembalikan nilai kosong
      print('Failed to load client data');
      return [];
    }
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
                  hintText: "Cari NIDN Dosen Sipil"),
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
                                    title: Text(menumodels[index].name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18)),
                                    subtitle: Text(
                                        'NIDN : ${menumodels[index].no_induk}'),
                                    onTap: () {
                                      _showClientAppUser(context);
                                      appUser = "${menumodels[index].name}";
                                      userId = "${menumodels[index].id}";
                                    })
                                : '${menumodels[index].no_induk}'
                                        .toLowerCase()
                                        .contains(filter.toLowerCase())
                                    ? ListTile(
                                        title: Text(menumodels[index].name,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                        subtitle: Text(
                                            'NIDN : ${menumodels[index].no_induk}'),
                                        onTap: () {
                                          setState(() {
                                            _showClientAppUser(context);
                                            appUser =
                                                "${menumodels[index].name}";
                                            userId = "${menumodels[index].id}";
                                          });
                                        })
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

  void _showClientAppUser(BuildContext context) async {
    showLoad(context);
    await apk();
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return LockDialogSipil(
            appUser: appUser,
            userId: userId,
            isLocked: _isLocked,
            nameClient: filterMenu,
            clientId: filterClientId);
      },
    );
  }

  void showLoad(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            height: 100,
            child: Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 50.0,
              ),
            ),
          ),
        );
      },
    );
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
