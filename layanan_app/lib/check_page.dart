import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:layanan_app/dosen/home_Dsn.dart';
import 'package:layanan_app/karyawan/home_Kryn.dart';
import 'package:layanan_app/mahasiswa/home_Mhs.dart';
import 'package:layanan_app/model/client_model.dart';
import 'package:layanan_app/model/status_token.dart';
import 'package:layanan_app/pages/home.dart';
import 'package:layanan_app/tautanPerangkat/scanQR.dart';
import 'package:uni_links/uni_links.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:url_launcher/url_launcher.dart';

import 'api/link.dart';
// import 'package:awesome_dialog/awesome_dialog.dart';

class checkPage extends StatefulWidget {
  final bool flagStatus;
  final String penandaOut;

  checkPage({this.flagStatus, this.penandaOut});
  @override
  _checkPageState createState() => _checkPageState();
}

class _checkPageState extends State<checkPage> {
  Map<String, dynamic> payload;
  bool _dataProcessed = false;
  String penandaOut;
  bool _pilihAkun = false;
  bool _isFirstLaunch = true;
  DateTime now = DateTime.now();

  String Semester;
  String ThnMasuk;
  String ThnMasukMhs;
  String MySemester;
  String Induk = "";

  @override
  void initState() {
    super.initState();
    _loadReceivedData();
    _initUniLinks();
    // penandaOut = widget.penandaOut;
    // if (penandaOut == "user logout") {
    //   _dataProcessed = widget.flagStatus;
    // } else {
    //   _loadReceivedData();
    //   _initUniLinks();
    // }
  }

  Future<void> _loadReceivedData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _receivedData = prefs.getString('receivedData') ?? "No data";
      if (_receivedData != "No data" && !JwtDecoder.isExpired(_receivedData)) {
        _decodeToken();
      }
    });
  }

  Future<void> _saveReceivedData(String data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('receivedData', data);
  }

  String _receivedData = "No data";
  String _userId = "No user";
  void _decodeToken() async {
    // Pastikan bahwa _receivedData memiliki nilai valid sebelum melanjutkan
    if (_receivedData != "No data") {
      try {
        final parts = _receivedData.split(".");
        assert(parts.length == 3, "Token tidak valid");

        final payloadPart = parts[1];
        final normalized = base64Url.normalize(payloadPart);
        final decodedBytes = base64Url.decode(normalized);
        final decodedString = utf8.decode(decodedBytes);

        setState(() {
          payload = jsonDecode(decodedString) as Map<String, dynamic>;
          _dataProcessed = true;
        });

        print(
            'Decoded payload: $payload'); // Anda bisa menghapus ini setelah debugging
      } catch (e) {
        // Tangani kesalahan decoding di sini
        print('Error decoding token: $e');
        setState(() {
          _dataProcessed = false;
        });
      }
    } else {
      setState(() {
        _dataProcessed = false;
      });
    }
  }

  Future<void> _initUniLinks() async {
    try {
      // Handle initial link
      final initialLink = await getInitialLink();
      if (initialLink != null) {
        _handleIncomingLink(initialLink);
      }
      // Handle incoming links
      linkStream.listen((String link) {
        if (link != null) {
          _handleIncomingLink(link);
        }
      });
    } on Exception {
      // Handle exception
    }
  }

  void _handleIncomingLink(String link) {
    final uri = Uri.parse(link);
    final data = uri.queryParameters['data'] ?? 'No data';

    setState(() {
      _receivedData = data;

      _saveReceivedData(data);
      _decodeToken();
    });
  }

  String output = "";

  void _launchIdP() async {
    final idpAppUrl = 'idpapp://login';
    // String url = deepLinkUri.toString();
    String url = idpAppUrl;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  DateTime tgl = new DateTime.now();

  final List<Product> products = [
    Product(nameClient: 'Sistem Informasi Manajemen'),
    Product(nameClient: 'Kuliah Kerja Nyata'),
  ];

  int semesterBerjalan;
  Future<void> addClientsSSOMhs() async {
    var userStatus = payload['data']['level'];
    var nim = payload['data']['no_induk'];
    var userJurusan = payload['data']['jurusan'];

    // int year = now.year;
    // ThnMasuk = year.toString();
    // ThnMasukMhs = ThnMasuk.substring(ThnMasuk.length - 2);
    // Induk = nim.substring(0, 2);
    int year = now.year;
    ThnMasuk = year.toString();
    //Tahun Sekarang
    ThnMasukMhs = ThnMasuk.substring(ThnMasuk.length - 2);
    Induk = nim.substring(0, 2);

    setState(() {
      Semester =
          "${int.tryParse(ThnMasukMhs) - int.tryParse(nim.substring(0, 2))}";
      MySemester = "${int.tryParse(Semester) * 2}";
      semesterBerjalan = int.tryParse(MySemester);
      if (DateTime.now().month > 6) {
        semesterBerjalan += 1;
      }
    });

    // setState(() {
    //   Semester = "${int.tryParse(ThnMasukMhs) - int.tryParse(Induk)}";
    //   MySemester = "${int.tryParse(Semester) * 2}";
    // });

    List<String> nameClients;
    List<String> imageClients;
    switch (userJurusan) {
      case 'Teknik Sipil':
        if (semesterBerjalan <= 2) {
          nameClients = ["Sistem Informasi Manajemen"];
          imageClients = ["sim"];
        } else if (semesterBerjalan == 3) {
          nameClients = ["Sistem Informasi Manajemen", "Lab Teknik Sipil"];
          imageClients = ["sim", "lab_sp"];
        } else if (semesterBerjalan > 3) {
          nameClients = [
            "Sistem Informasi Manajemen",
            "Lab Teknik Sipil",
            "Kuliah Kerja Nyata",
            "Sistem Monitoring Tugas Akhir"
          ];
          imageClients = ["sim", "lab_sp", "kkn", "simonta"];
        }
        break;
      case 'Teknik Elektronika':
        if (semesterBerjalan <= 2) {
          nameClients = ["Sistem Informasi Manajemen"];
          imageClients = ["sim"];
        } else if (semesterBerjalan == 3) {
          nameClients = [
            "Sistem Informasi Manajemen",
            "Lab Teknik Elektronika"
          ];
          imageClients = [
            "sim",
            "lab_sp",
          ];
        } else if (semesterBerjalan > 3) {
          nameClients = [
            "Sistem Informasi Manajemen",
            "Lab Teknik Elektronika",
            "Kuliah Kerja Nyata",
            "Sistem Monitoring Tugas Akhir"
          ];
          imageClients = ["sim", "lab_te", "kkn", "simonta"];
        }
        break;
      case 'Teknik Informatika':
        if (semesterBerjalan <= 2) {
          nameClients = ["Sistem Informasi Manajemen"];
          imageClients = ["sim"];
        } else if (semesterBerjalan == 3) {
          nameClients = [
            "Sistem Informasi Manajemen",
            "Lab Teknik Informatika"
          ];
          imageClients = [
            "sim",
            "lab_ti",
          ];
        } else if (semesterBerjalan > 3) {
          nameClients = [
            "Sistem Informasi Manajemen",
            "Lab Teknik Informatika",
            "Kuliah Kerja Nyata",
            "Sistem Monitoring Tugas Akhir"
          ];
          imageClients = ["sim", "lab_ti", "kkn", "simonta"];
        }
        break;
    }

    //Loop
    for (int i = 0; i < nameClients.length; i++) {
      var nameClient = nameClients[i];
      var imageClient = imageClients[i];
      var url = await http.post(
        Uri.parse(ApiConstants.baseUrl +
            "api/SSOClients/create_applicationMahasiswa"),
        body: {
          "name_client": nameClient,
          "user_id": "${payload['data']['id']}",
          "user_status": "${userStatus}",
          "create_at": "${tgl}",
          "image": imageClient
        },
      );
      if (url.statusCode == 200) {
        // Berhasil
        print('Data untuk $nameClient berhasil dikirim');
      } else {
        // Gagal
        print('Gagal mengirim data untuk $nameClient');
      }

      //Tambahkan penundaan kecil jika perlu
      await Future.delayed(Duration(milliseconds: 500));
    }
  }

  Future<void> addClientsSSODsn() async {
    var userStatus = payload['data']['level'];
    var userJurusan = payload['data']['jurusan'];

    List<String> nameClients;
    List<String> imageClients;
    switch (userJurusan) {
      case 'Teknik Sipil':
        nameClients = [
          "Sistem Informasi Manajemen",
          "Lab Teknik Sipil",
          "Kuliah Kerja Nyata",
          "Sistem Monitoring Tugas Akhir",
          "SISTER",
          // "SINTA",
          "SIMPEL"
        ];
        imageClients = [
          "sim",
          "lab_sp",
          "kkn",
          "simonta",
          "sister",
          // "sinta",
          "simpel"
        ];
        break;
      case 'Teknik Elektronika':
        nameClients = [
          "Sistem Informasi Manajemen",
          "Lab Teknik Elektronika",
          "Kuliah Kerja Nyata",
          "Sistem Monitoring Tugas Akhir",
          "SISTER",
          // "SINTA",
          "SIMPEL"
        ];
        imageClients = [
          "sim",
          "lab_te",
          "kkn",
          "simonta",
          "sister",
          // "sinta",
          "simpel"
        ];
        break;
      case 'Teknik Informatika':
        nameClients = [
          "Sistem Informasi Manajemen",
          "Lab Teknik Informatika",
          "Kuliah Kerja Nyata",
          "Sistem Monitoring Tugas Akhir",
          "SISTER",
          // "SINTA",
          "SIMPEL"
        ];
        imageClients = [
          "sim",
          "lab_ti",
          "kkn",
          "simonta",
          "sister",
          // "sinta",
          "simpel"
        ];
        break;
    }

    //Loop
    for (int i = 0; i < nameClients.length; i++) {
      var nameClient = nameClients[i];
      var imageClient = imageClients[i];
      var url = await http.post(
        Uri.parse(
            ApiConstants.baseUrl + "api/SSOClients/create_applicationDosen"),
        body: {
          "name_client": nameClient,
          "user_id": "${payload['data']['id']}",
          "user_status": "${userStatus}",
          "create_at": "${tgl}",
          "image": imageClient
        },
      );
      if (url.statusCode == 200) {
        // Berhasil
        print('Data untuk $nameClient berhasil dikirim');
      } else {
        // Gagal
        print('Gagal mengirim data untuk $nameClient');
      }

      await Future.delayed(Duration(milliseconds: 500));
    }
  }

  Future<void> addClientsSSOKryn() async {
    var userStatus = payload['data']['level'];
    var userJurusan = payload['data']['jurusan'];

    List<String> nameClients;
    List<String> imageClients;
    if (userStatus == "Karyawan") {
      nameClients = [
        "Sistem Informasi Manajemen",
        "Koperasi",
      ];
      imageClients = [
        "sim",
        "koperasi",
      ];
    } else {
      nameClients = ["Some Other Value"];
    }

    //Loop
    for (int i = 0; i < nameClients.length; i++) {
      var nameClient = nameClients[i];
      var imageClient = imageClients[i];
      var url = await http.post(
        Uri.parse(
            ApiConstants.baseUrl + "api/SSOClients/create_applicationKryn"),
        body: {
          "name_client": nameClient,
          "user_id": "${payload['data']['id']}",
          "user_status": "${userStatus}",
          "create_at": "${tgl}",
          "image": imageClient
        },
      );
      if (url.statusCode == 200) {
        // Berhasil
        print('Data untuk $nameClient berhasil dikirim');
      } else {
        // Gagal
        print('Gagal mengirim data untuk $nameClient');
      }

      //Tambahkan penundaan kecil jika perlu
      await Future.delayed(Duration(milliseconds: 500));
    }
  }

  Future<String> checkClientAvailability() async {
    var perLevel = payload['data']['level'];
    var perIdn = payload['data']['id'];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('sp_Name', '${payload['data']['name']}');
    await prefs.setString('sp_Id', '${payload['data']['id']}');
    await prefs.setString('perLevel', '${payload['data']['level']}');

    showLoad(context);
    await Future.delayed(Duration(seconds: 2));

    final response = await http.post(
      Uri.parse(
          ApiConstants.baseUrl + 'api/ClientValid/check_client/${perIdn}'),
      body: {'user_id': "${perIdn}"},
    );
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      print('respon :' + response.statusCode.toString());
      print(responseData['status']);
      if (responseData['status'] == false) {
        switch (perLevel) {
          case "Mahasiswa":
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => homeMhs()));
            CoolAlert.show(
                context: context,
                type: CoolAlertType.success,
                title: "Berhasil Masuk",
                text: "Aplikasi Penyedia Layanan",
                confirmBtnText: "Ok");
            break;
          case "Dosen":
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => homeDsn()));
            CoolAlert.show(
                context: context,
                type: CoolAlertType.success,
                title: "Berhasil Masuk",
                text: "Aplikasi Penyedia Layanan",
                confirmBtnText: "Ok");
            break;
          case "Karyawan":
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => homeKryn()));
            CoolAlert.show(
                context: context,
                type: CoolAlertType.success,
                title: "Berhasil Masuk",
                text: "Aplikasi Penyedia Layanan",
                confirmBtnText: "Ok");
            break;
          default:
        }
      } else {
        setState(() async {
          switch (perLevel) {
            case "Mahasiswa":
              await addClientsSSOMhs();
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => homeMhs()));
              CoolAlert.show(
                  context: context,
                  type: CoolAlertType.success,
                  title: "Berhasil Masuk",
                  text: "Aplikasi Penyedia Layanan",
                  confirmBtnText: "Ok");
              break;
            case "Dosen":
              await addClientsSSODsn();
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => homeDsn()));
              CoolAlert.show(
                  context: context,
                  type: CoolAlertType.success,
                  title: "Berhasil Masuk",
                  text: "Aplikasi Penyedia Layanan",
                  confirmBtnText: "Ok");
              break;
            case "Karyawan":
              await addClientsSSOKryn();
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => homeKryn()));
              CoolAlert.show(
                  context: context,
                  type: CoolAlertType.success,
                  title: "Berhasil Masuk",
                  text: "Aplikasi Penyedia Layanan",
                  confirmBtnText: "Ok");
              break;
            default:
          }
        });
      }
    } else {
      // _showErrorDialog();
    }
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

  String statusInOut;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: _dataProcessed
            ? Stack(
                children: [
                  Image.asset(
                    'assets/bg.png',
                    fit: BoxFit.cover,
                    width: screenWidth,
                    height: screenHeight,
                  ),
                  SizedBox(height: screenHeight * 0.1),
                  Center(
                    child: FutureBuilder(
                      future: http.get(
                        Uri.parse(ApiConstants.baseUrl +
                            'SSOAuth/validate_token/index'),
                        headers: {"Authorization": "${_receivedData}"},
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text("An error occurred: ${snapshot.error}");
                        } else if (snapshot.hasData) {
                          return SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(height: screenHeight * 0.1),
                                Center(
                                  child: Text(
                                    "Sistem Layanan\nUniversitas Bhayangkara\nSurabaya",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: screenHeight * 0.04,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.05),
                                Image.asset(
                                  "assets/ubhara.png",
                                  scale: 3.2,
                                ),
                                SizedBox(height: screenHeight * 0.1),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(60.0),
                                      topRight: Radius.circular(60.0),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: screenWidth * 0.05,
                                      vertical: screenHeight * 0.05,
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          "Sign In",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: screenHeight * 0.05,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: screenHeight * 0.05),
                                        Text(
                                          "use one of your sso profile",
                                          style: TextStyle(
                                              fontSize: screenHeight * 0.025),
                                        ),
                                        SizedBox(height: screenHeight * 0.02),
                                        Center(
                                          child: SizedBox(
                                            width: screenWidth * 0.8,
                                            height: screenHeight * 0.07,
                                            child: Builder(
                                              builder:
                                                  (BuildContext innerContext) {
                                                return ElevatedButton(
                                                  onPressed: () {
                                                    setState(
                                                      () {
                                                        CoolAlert.show(
                                                          context: innerContext,
                                                          type: CoolAlertType
                                                              .info,
                                                          title:
                                                              'Pilih Akun SSO',
                                                          text:
                                                              'untuk lanjut ke aplikasi SP',
                                                          widget: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Flexible(
                                                                child: ListTile(
                                                                  leading: Icon(
                                                                    Icons
                                                                        .account_circle,
                                                                    size: 50,
                                                                  ),
                                                                  title: Text(
                                                                    '${payload['data']['name']}',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            20),
                                                                  ),
                                                                  subtitle:
                                                                      Text(
                                                                    "${payload['data']['email']}",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            18),
                                                                  ),
                                                                  onTap:
                                                                      () async {
                                                                    SharedPreferences
                                                                        prefs =
                                                                        await SharedPreferences
                                                                            .getInstance();
                                                                    await prefs
                                                                        .setBool(
                                                                            'pilihAkun',
                                                                            true);
                                                                    await prefs.setString(
                                                                        'refresh_token',
                                                                        '${payload['data']['refresh_token']}');
                                                                    await prefs
                                                                        .setString(
                                                                            'id',
                                                                            '${payload['data']['id']}');
                                                                    await prefs.setString(
                                                                        'email',
                                                                        '${payload['data']['email']}');

                                                                    setState(
                                                                        () {
                                                                      _pilihAkun =
                                                                          true;
                                                                      checkClientAvailability();
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          confirmBtnText: '',
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: Text(
                                                      'SSO Internal UBHARA'),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: screenHeight * 0.02),
                                        Center(
                                            child: RichText(
                                                text: TextSpan(
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                    ),
                                                    children: [
                                              TextSpan(
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 0, 83, 192),
                                                      decoration: TextDecoration
                                                          .underline),
                                                  //make link blue and underline
                                                  text:
                                                      "Tautkan Perangkat Multi Device",
                                                  recognizer:
                                                      TapGestureRecognizer()
                                                        ..onTap = () {
                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          scanQR()));
                                                        }),

                                              //more text paragraph, sentences here.
                                            ])))
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        } else {
                          return Text("No data found");
                        }
                      },
                    ),
                  ),
                ],
              )
            : Stack(
                children: [
                  Image.asset(
                    'assets/bg.png',
                    fit: BoxFit.cover,
                    width: screenWidth,
                    height: screenHeight,
                  ),
                  SizedBox(height: screenHeight * 0.1),
                  Center(
                    child: FutureBuilder(
                      future: http.get(
                        Uri.parse(ApiConstants.baseUrl +
                            'SSOAuth/validate_token/index'),
                        headers: {"Authorization": "${_receivedData}"},
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text("An error occurred: ${snapshot.error}");
                        } else if (snapshot.hasData) {
                          return SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(height: screenHeight * 0.1),
                                Text(
                                  "Sistem Layanan\nUniversitas Bhayangkara\nSurabaya",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: screenHeight * 0.04,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.05),
                                Image.asset(
                                  "assets/ubhara.png",
                                  scale: 3.2,
                                ),
                                SizedBox(height: screenHeight * 0.1),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(60.0),
                                      topRight: Radius.circular(60.0),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: screenWidth * 0.05,
                                      vertical: screenHeight * 0.05,
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          "Sign In",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: screenHeight * 0.05,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: screenHeight * 0.05),
                                        Text(
                                          "use one of your sso profile",
                                          style: TextStyle(
                                              fontSize: screenHeight * 0.025),
                                        ),
                                        SizedBox(height: screenHeight * 0.02),
                                        Center(
                                          child: SizedBox(
                                            width: screenWidth * 0.8,
                                            height: screenHeight * 0.07,
                                            child: Builder(
                                              builder:
                                                  (BuildContext innerContext) {
                                                return ElevatedButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      CoolAlert.show(
                                                        context: innerContext,
                                                        type:
                                                            CoolAlertType.error,
                                                        title:
                                                            'Regis/Login IdP!',
                                                        text:
                                                            'Pastikan punya akun IdP!',
                                                        confirmBtnText:
                                                            'Login IdP',
                                                        onConfirmBtnTap: () {
                                                          _launchIdP();
                                                        },
                                                      );
                                                    });
                                                  },
                                                  child: Text(
                                                      'SSO Internal UBHARA'),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: screenHeight * 0.02),
                                        Center(
                                            child: RichText(
                                                text: TextSpan(
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                    ),
                                                    children: [
                                              TextSpan(
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 0, 83, 192),
                                                      decoration: TextDecoration
                                                          .underline),
                                                  //make link blue and underline
                                                  text:
                                                      "Tautkan Perangkat Multi Device",
                                                  recognizer:
                                                      TapGestureRecognizer()
                                                        ..onTap = () {
                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          scanQR()));
                                                        }),

                                              //more text paragraph, sentences here.
                                            ]))
                                            // ElevatedButton(
                                            //   onPressed: () {
                                            //     Navigator.of(context).push(
                                            //         MaterialPageRoute(
                                            //             builder: (context) =>
                                            //                 scanQR()));
                                            //   },
                                            //   child: Text(
                                            //       'Tautkan Perangkat Multi Device'),
                                            // ),
                                            )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        } else {
                          return Text("No data found");
                        }
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// void main() {
//   runApp(ReceiverApp());
// }

// class ReceiverApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Receiver App',
//       home: ReceiverScreen(),
//     );
//   }
// }

// class ReceiverScreen extends StatefulWidget {
//   @override
//   _ReceiverScreenState createState() => _ReceiverScreenState();
// }

// class _ReceiverScreenState extends State<ReceiverScreen> {
//   String _token = '';

//   @override
//   void initState() {
//     super.initState();
//     _loadToken();
//   }

//   void _loadToken() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _token = prefs.getString('token') ?? '';
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Receiver App'),
//       ),
//       body: Center(
//         child: Text(
//           'Token from Sender: $_token',
//           style: TextStyle(fontSize: 20.0),
//         ),
//       ),
//     );
//   }
// }
