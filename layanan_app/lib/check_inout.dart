import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:layanan_app/model/client_model.dart';
import 'package:layanan_app/model/status_token.dart';
import 'package:layanan_app/pages/home.dart';
import 'package:uni_links/uni_links.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:awesome_dialog/awesome_dialog.dart';

class check_inout extends StatefulWidget {
  @override
  _check_inoutState createState() => _check_inoutState();
}

class _check_inoutState extends State<check_inout> {
  Map<String, dynamic> payload;
  bool _dataProcessed = false;
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

  Future<void> addClientsSSOMhs() async {
    var userStatus = payload['data']['level'];
    var nim = payload['data']['no_induk'];
    var userJurusan = payload['data']['jurusan'];

    int year = now.year;
    ThnMasuk = year.toString();
    ThnMasukMhs = ThnMasuk.substring(ThnMasuk.length - 2);
    Induk = nim.substring(0, 2);

    setState(() {
      Semester = "${int.tryParse(ThnMasukMhs) - int.tryParse(Induk)}";
      MySemester = "${int.tryParse(Semester) * 2}";
    });

    List<String> nameClients;
    switch (userJurusan) {
      case 'Teknik Sipil':
        if (int.tryParse(MySemester) <= 2) {
          nameClients = ["Sistem Informasi Manajemen"];
        } else if (int.tryParse(MySemester) == 3) {
          nameClients = ["Sistem Informasi Manajemen", "Lab Teknik Sipil"];
        } else if (int.tryParse(MySemester) > 3) {
          nameClients = [
            "Sistem Informasi Manajemen",
            "Lab Teknik Sipil",
            "Kuliah Kerja Nyata",
            "Sistem Monitoring Tugas Akhir"
          ];
        }
        break;
      case 'Teknik Elektronika':
        if (int.tryParse(MySemester) <= 2) {
          nameClients = ["Sistem Informasi Manajemen"];
        } else if (int.tryParse(MySemester) == 3) {
          nameClients = [
            "Sistem Informasi Manajemen",
            "Lab Teknik Elektronika"
          ];
        } else if (int.tryParse(MySemester) > 3) {
          nameClients = [
            "Sistem Informasi Manajemen",
            "Lab Teknik Elektronika",
            "Kuliah Kerja Nyata",
            "Sistem Monitoring Tugas Akhir"
          ];
        }
        break;
      case 'Teknik Informatika':
        if (int.tryParse(MySemester) <= 2) {
          nameClients = ["Sistem Informasi Manajemen"];
        } else if (int.tryParse(MySemester) == 3) {
          nameClients = [
            "Sistem Informasi Manajemen",
            "Lab Teknik Informatika"
          ];
        } else if (int.tryParse(MySemester) > 3) {
          nameClients = [
            "Sistem Informasi Manajemen",
            "Lab Teknik Informatika",
            "Kuliah Kerja Nyata",
            "Sistem Monitoring Tugas Akhir"
          ];
        }
        break;
    }

    //Loop
    for (var nameClient in nameClients) {
      var url = await http.post(
        Uri.parse(
            "http://0331kebonagung.ikc.co.id/api/ssoClients/create_applicationMahasiswa"),
        body: {
          "name_client": nameClient,
          "user_id": "${payload['data']['id']}",
          "user_status": "${userStatus}",
          "create_at": "${tgl}",
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
    switch (userJurusan) {
      case 'Teknik Sipil':
        nameClients = [
          "Sistem Informasi Manajemen",
          "Lab Teknik Sipil",
          "Kuliah Kerja Nyata",
          "Sistem Monitoring Tugas Akhir",
          "SISTER",
          "SINTA"
        ];
        break;
      case 'Teknik Elektronika':
        nameClients = [
          "Sistem Informasi Manajemen",
          "Lab Teknik Eletronika",
          "Kuliah Kerja Nyata",
          "Sistem Monitoring Tugas Akhir",
          "SISTER",
          "SINTA"
        ];
        break;
      case 'Teknik Informatika':
        nameClients = [
          "Sistem Informasi Manajemen",
          "Lab Teknik Informatika",
          "Kuliah Kerja Nyata",
          "Sistem Monitoring Tugas Akhir",
          "SISTER",
          "SINTA"
        ];
        break;
    }

    //Loop
    for (var nameClient in nameClients) {
      var url = await http.post(
        Uri.parse(
            "http://0331kebonagung.ikc.co.id/api/ssoClients/create_applicationDosen"),
        body: {
          "name_client": nameClient,
          "user_id": "${payload['data']['id']}",
          "user_status": "${userStatus}",
          "create_at": "${tgl}",
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
    if (userStatus == "Karyawan") {
      nameClients = [
        "Sistem Informasi Manajemen",
        "Koperasi",
      ];
    } else {
      nameClients = ["Some Other Value"];
    }

    //Loop
    for (var nameClient in nameClients) {
      var url = await http.post(
        Uri.parse(
            "http://0331kebonagung.ikc.co.id/api/ssoClients/create_applicationKryn"),
        body: {
          "name_client": nameClient,
          "user_id": "${payload['data']['id']}",
          "user_status": "${userStatus}",
          "create_at": "${tgl}",
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

    showLoad(context);
    await Future.delayed(Duration(seconds: 2));

    final response = await http.post(
      Uri.parse(
          'http://0331kebonagung.ikc.co.id/api/clientvalid/check_client/'),
      body: {'user_id': "${perIdn}"},
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      print('respon :' + response.statusCode.toString());
      print(responseData['status']);
      if (responseData['status'] == false) {
        // _showEmailRegisteredDialog();
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => homePage()));
        CoolAlert.show(
            context: context,
            type: CoolAlertType.success,
            title: "Berhasil Masuk",
            text: "Aplikasi Penyedia Layanan",
            confirmBtnText: "Ok");
      } else {
        setState(() async {
          if (perLevel == "Mahasiswa") {
            addClientsSSOMhs();
          } else if (perLevel == "Dosen") {
            addClientsSSODsn();
          } else if (perLevel == "Karyawan") {
            addClientsSSOKryn();
          }
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => homePage()));
          CoolAlert.show(
              context: context,
              type: CoolAlertType.success,
              title: "Berhasil Masuk",
              text: "Aplikasi Penyedia Layanan",
              confirmBtnText: "Ok");
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            Image.asset('assets/bg.png',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity),
            SizedBox(
              height: 80,
            ),
            Center(
              child: FutureBuilder(
                future: http.read(
                  Uri.parse(
                      'http://0331kebonagung.ikc.co.id/ssoauth/validate_token/'),
                  headers: {"Authorization": "${_receivedData}"},
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text("An error occurred: ${snapshot.error}");
                  } else if (snapshot.hasData) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 80,
                        ),
                        Center(
                          child: Text(
                            "Sistem Layanan\nUniversitas Bhayangkara\nSurabaya\nIn Out",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          // width: MediaQuery.of(context).size.width,
                          // height: MediaQuery.of(context).size.height / 1.6,
                          child: Center(
                            child: Image.asset(
                              "assets/ubhara.png",
                              scale: 3.2,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 80,
                        ),
                        Expanded(
                          flex: 7,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(60.0),
                                topRight: Radius.circular(60.0),
                              ),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 50),
                                  child: Text(
                                    "Sign In",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 40,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                                SizedBox(
                                  height: 30,
                                  child: Text(
                                    "use one of your sso profile",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Center(
                                  child: SizedBox(
                                    width: 350,
                                    height: 50,
                                    child: Builder(
                                      builder: (BuildContext innerContext) {
                                        return ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              CoolAlert.show(
                                                context: innerContext,
                                                type: CoolAlertType.error,
                                                title: 'Regis/Login IdP!',
                                                text:
                                                    'Pastikan punya akun IdP!',
                                                confirmBtnText: 'Login IdP',
                                                onConfirmBtnTap: () {
                                                  _launchIdP();
                                                },
                                              );
                                            });
                                          },
                                          child: Text('SSO Internal UBHARA'),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
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
