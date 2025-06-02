import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:layanan_app/api/link.dart';
import 'package:layanan_app/check_page.dart';
import 'package:layanan_app/drawer/profileKaryawan.dart';
import 'package:layanan_app/karyawan/koperasi_Kryn.dart';
import 'package:layanan_app/karyawan/sim_Kryn.dart';
import 'package:layanan_app/mahasiswa/sim.dart';
import 'package:http/http.dart' as http;
import 'package:layanan_app/model/app1/client_sim.dart';

import 'dart:convert' show ascii, base64, json, jsonDecode;

import 'package:layanan_app/pages/jwt.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:layanan_app/model/status_token.dart';

import '../mahasiswa/kkn.dart';
import '../mahasiswa/lab_ti.dart';
import '../mahasiswa/simonta.dart';

class homeKryn extends StatefulWidget {
  final data;

  homeKryn({this.data});
  @override
  _homeKrynState createState() => _homeKrynState();
}

class _homeKrynState extends State<homeKryn> {
  List<Color> setColors = [
    Color(0xFF6FE0BD),
    Color(0xFF618DFD),
    Color(0xFFFC7F7F),
    Color(0xFFCB84FB),
  ];

  List<Icon> catIcon = [
    Icon(
      Icons.category,
      color: Colors.white,
      size: 30,
    ),
    Icon(
      Icons.class_sharp,
      color: Colors.white,
      size: 30,
    ),
    Icon(
      Icons.calendar_month,
      color: Colors.white,
      size: 30,
    ),
    Icon(
      Icons.settings,
      color: Colors.white,
      size: 30,
    ),
  ];

  SharedPreferences _prefs;

  String statusInOut;
  String revokeToken;

  String _test = "";
  String ids = "";
  String sp_Name = "";
  String sp_Id = "";
  Future<void> _initSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    sp_Name = prefs.getString('sp_Name');
    sp_Id = prefs.getString('sp_Id');

    setState(() {});
  }

  String _receivedData = "No data";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initSharedPreferences();
    fetchRevoke();
    apk();
    _loadSharedPrefs();
    _loadImage();
  }

  Future<void> _loadSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final receivedData = prefs.getString('receivedData'); // Fetch the data

    // Check if data is available
    if (receivedData != null) {
      setState(() {
        _receivedData = receivedData; // Set the value after fetching
      });

      // Call your Provider logic after the value is fetched
      Provider.of<UserSIM>(context, listen: false).validateToken(_receivedData);

      // Print the value after it has been set
      print('Received Data (inside setState): $_receivedData');
    } else {
      print('No data found in SharedPreferences');
    }
  }

  List<String> filterMenu = [];
  List<String> filterGbr = [];

  Future<void> fetchRevoke() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('id') ?? null;

    if (id != null) {
      List<User> users = await User.getUsers(id);
      statusInOut = "";
      revokeToken = "";
      for (int i = 0; i < users.length; i++) {
        statusInOut += users[i].status;
      }
      if (statusInOut == "false" || revokeToken == "revoke") {
        await prefs.clear();
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => checkPage()));
      }
    }
  }

  Future<void> apk() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = sp_Id; // Ambil user_id dari SharedPreferences

    if (userId != null) {
      // Langkah 1: Ambil data name_client, client_id, dan secret_id dari REST API berdasarkan user_id
      List<Map<String, String>> clientDataList =
          await getClientDataFromAPI(userId);

      if (clientDataList != null && clientDataList.isNotEmpty) {
        // Mengisi filterMenu dengan name_client dan filterGbr dengan gambar yang sesuai
        setState(() {
          filterMenu = clientDataList
              .map((clientData) => clientData['name_client'])
              .toList();
          filterGbr =
              clientDataList.map((clientData) => clientData['image']).toList();
        });

        print('filterMenu: $filterMenu'); // Debug statement
        print('filterGbr: $filterGbr'); // Debug statement
      } else {
        print('No clients found for userId: $userId');
        setState(() {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Pendaftaran Tidak Ditemukan"),
                content: Text("Aksses Client SSO Revoke!"),
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
    final url = Uri.parse(
        ApiConstants.baseUrl + 'api/getClient/GetListClient?user_id=$userId');

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
          'secret_id': item['secret_id']?.toString() ?? '',
          'image': item['image']?.toString() ?? ''
        };
      }).toList();
    } else {
      // Jika gagal, kembalikan nilai kosong
      print('Failed to load client data');
      return [];
    }
  }

  File _image;
  _loadImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String imagePath = prefs.getString('profile_image');
    if (imagePath != null) {
      setState(() {
        _image = File(imagePath);
      });
    }
  }

  Future<void> userLogOut() async {
    final response = await http.put(
        Uri.parse(ApiConstants.baseUrl + "api/func_admin/StatusUserToken"),
        body: {"id": sp_Id, "status": 'false'});
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double gridSpacing = 10.0;
    int crossAxisCount = 2;
    List<String> validFilterGbr = filterGbr.where((imageName) {
      return imageName != "locked";
    }).toList();

    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Consumer<UserSIM>(
            builder: (context, userModel, child) {
              if (userModel.isLoading) {
                return CircularProgressIndicator(); // Show a loading spinner while fetching data
              } else if (userModel.errorMessage != null) {
                return Text(
                    'Error: ${userModel.errorMessage}'); // Display error message
              } else {
                return UserAccountsDrawerHeader(
                  accountName: Text(
                    userModel.userName ?? 'No Name',
                    style: TextStyle(color: Colors.black),
                  ),
                  accountEmail: Text(userModel.userEmail ?? 'No Email',
                      style: TextStyle(color: Colors.black)),
                  currentAccountPicture: CircleAvatar(
                    child: ClipOval(
                      child: _image == null
                          ? Image.asset("assets/user_profile.png",
                              width: 90, height: 90, fit: BoxFit.cover)
                          : Image.file(_image,
                              width: 90, height: 90, fit: BoxFit.cover),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 221, 27),
                  ),
                );
              }
            },
          ),
          // Your existing ListTile widgets
          ListTile(
            leading: Icon(Icons.apps),
            title: Text(
              "Informasi Personal",
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => dataProfileKaryawan()));
            },
          ),
          ListTile(
            leading: Icon(Icons.logout_outlined),
            title: Text(
              "Log out",
              style: TextStyle(fontSize: 18),
            ),
            onTap: () async {
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
                      MaterialPageRoute(builder: (context) => checkPage()),
                    );
                  },
                  onCancelBtnTap: () async {
                    Navigator.of(context).pop();
                  });
            },
          ),
        ],
      )),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 221, 27),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(60),
                    bottomLeft: Radius.circular(60))),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.person,
                      size: 30,
                      color: Colors.black,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.dehaze,
                        size: 30,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        _scaffoldKey.currentState
                            ?.openDrawer(); // Open the drawer
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 3, bottom: 15),
                  child: Text(
                    "Hi ${sp_Name}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                        wordSpacing: 2,
                        color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 90,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 15, right: 15),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "Penyedia Layanan",
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.all(15.0),
          //   child: GridView.builder(
          //     itemCount: filterMenu.length,
          //     shrinkWrap: true,
          //     physics: NeverScrollableScrollPhysics(),
          //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //       crossAxisCount: 2,
          //       childAspectRatio:
          //           (MediaQuery.of(context).size.height - 50 - 25) / (3 * 290),
          //       mainAxisSpacing: 10,
          //       crossAxisSpacing: 10,
          //     ),
          //     itemBuilder: (context, index) {
          //       return GestureDetector(
          //         onTap: () {
          //           switch (filterGbr[index]) {
          //             case "sim":
          //               Navigator.push(context,
          //                   MaterialPageRoute(builder: (context) => simMhs()));
          //               break;
          //             case "lab_ti":
          //               Navigator.push(
          //                   context,
          //                   MaterialPageRoute(
          //                       builder: (context) => labTIMhs()));
          //               break;
          //             // case "lab_te":
          //             //   Navigator.push(
          //             //       context,
          //             //       MaterialPageRoute(
          //             //           builder: (context) => labTEMhs()));
          //             //   break;
          //             // case "lab_sp":
          //             //   Navigator.push(
          //             //       context,
          //             //       MaterialPageRoute(
          //             //           builder: (context) => labTSMhs()));
          //             //break;
          //             case "kkn":
          //               Navigator.push(context,
          //                   MaterialPageRoute(builder: (context) => kknMhs()));
          //               break;
          //             case "simonta":
          //               Navigator.push(
          //                   context,
          //                   MaterialPageRoute(
          //                       builder: (context) => simontaMhs()));
          //               break;
          //             default:
          //           }
          //         },
          //         child: GridTile(
          //             child: Image.asset(
          //           "assets/${filterGbr[index]}.png", // Mengambil gambar dari assets
          //           fit: BoxFit.cover,
          //         )),
          //       );
          //     },
          //   ),
          // ),
          FutureBuilder<List<String>>(
            future: _filterValidImages(validFilterGbr),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              } else {
                List<String> finalValidFilterGbr = snapshot.data ?? [];
                return GridView.builder(
                  itemCount: finalValidFilterGbr
                      .length, // Gunakan list yang sudah difilter
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount, // Jumlah kolom dalam grid
                    childAspectRatio:
                        screenWidth / (screenHeight / 2), // Rasio responsif
                    mainAxisSpacing: gridSpacing,
                    crossAxisSpacing: gridSpacing,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        switch (finalValidFilterGbr[index]) {
                          case "sim":
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => simKryn()));
                            break;
                          case "koperasi":
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => koperasiKryn()));
                            break;

                          default:
                        }
                      },
                      child: GridTile(
                        child: Image.asset(
                          "assets/${finalValidFilterGbr[index]}.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  // Fungsi untuk memfilter gambar yang ada di assets
  Future<List<String>> _filterValidImages(List<String> imageNames) async {
    List<String> validImages = [];
    for (String imageName in imageNames) {
      if (await imageExists("assets/$imageName.png")) {
        validImages.add(imageName);
      }
    }
    return validImages;
  }

  // Fungsi untuk memeriksa apakah file gambar ada di assets
  Future<bool> imageExists(String path) async {
    try {
      await rootBundle.load(path);
      return true;
    } catch (e) {
      return false;
    }
  }
}
