import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // Untuk describeEnum
import 'package:qr_code_scanner/qr_code_scanner.dart'; // Jika Anda menggunakan package ini
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../api/link.dart';
import '../dosen/home_Dsn.dart';
import '../karyawan/home_Kryn.dart';
import '../mahasiswa/home_Mhs.dart';

class scanQR extends StatefulWidget {
  @override
  _scanQRState createState() => _scanQRState();
}

class _scanQRState extends State<scanQR> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode result;
  QRViewController controller;
  String validationMessage;

  @override
  void reassemble() {
    super.reassemble();
    if (controller != null) {
      controller.pauseCamera();
      controller.resumeCamera();
    }
  }

  String Semester;
  String ThnMasuk;
  String ThnMasukMhs;
  String MySemester;
  String Induk = "";
  int semesterBerjalan;
  DateTime now = DateTime.now();
  bool _pilihAkun = false;
  // Fungsi Validasi Token
  Future<void> validateToken(String token) async {
    final String apiUrl = ApiConstants.baseUrl + 'SSOAuth/validate_token/';
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {"Authorization": token},
      );

      if (response.statusCode == 200) {
        final payload = json.decode(response.body);
        print("Payload: $payload");

        String userName = payload['data']['data']['name'];
        if (userName != null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('sp_Name', userName);
          await prefs.setString('sp_Id', payload['data']['data']['id']);
          await prefs.setString('perLevel', payload['data']['data']['level']);
          await prefs.setString('email', payload['data']['data']['email']);
          await prefs.setString('id', payload['data']['data']['id']);
          await prefs.setString('receivedData', token);
          await prefs.setBool('pilihAkun', true);

          setState(() {
            validationMessage = "Valid Token!\nName: $userName";
          });

          await checkClientAvailability(payload['data']['data']);

          // Navigasi ke halaman sesuai level
          _navigateToHome(payload['data']['data']['level']);
        } else {
          setState(() {
            validationMessage = "Name is missing in the response.";
          });
        }
      } else {
        setState(() {
          validationMessage = "Invalid Token!";
        });
      }
    } catch (e) {
      setState(() {
        validationMessage = "Error: $e";
      });
    } finally {
      setState(() {
        _isProcessing = false; // Reset flag setelah selesai
      });
    }
  }

  // Fungsi Check Client Availability
  Future<void> checkClientAvailability(Map<String, dynamic> data) async {
    String perLevel = data['level'];
    String perIdn = data['id'];
    String nim = data['no_induk'];

    String userJurusan = data['jurusan'];

    final response = await http.post(
      Uri.parse(ApiConstants.baseUrl + 'api/ClientValid/check_client/$perIdn'),
      body: {'user_id': "$perIdn"},
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print('Respon: ${response.statusCode}');
      print(responseData['status']);

      if (responseData['status'] == false) {
        // Jika client tidak tersedia, panggil fungsi untuk menambah client

        _navigateToHome(perLevel);
      } else {
        switch (perLevel) {
          case 'Mahasiswa':
            await addClientsSSOMhs(userJurusan, perIdn, nim);
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => homeMhs()));
            CoolAlert.show(
                context: context,
                type: CoolAlertType.success,
                title: "Berhasil Masuk",
                text: "Aplikasi Penyedia Layanan",
                confirmBtnText: "Ok");
            break;
          case 'Dosen':
            await addClientsSSODsn(userJurusan, perIdn);
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => homeDsn()));
            CoolAlert.show(
                context: context,
                type: CoolAlertType.success,
                title: "Berhasil Masuk",
                text: "Aplikasi Penyedia Layanan",
                confirmBtnText: "Ok");
            break;
          case 'Karyawan':
            await addClientsSSOKryn(perIdn);
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => homeKryn()));
            CoolAlert.show(
                context: context,
                type: CoolAlertType.success,
                title: "Berhasil Masuk",
                text: "Aplikasi Penyedia Layanan",
                confirmBtnText: "Ok");
            break;
        }
      }
    } else {
      setState(() {
        validationMessage = "Error validating client.";
      });
    }
  }

  // Fungsi Menambah Clients untuk Mahasiswa
  Future<void> addClientsSSOMhs(
      String userJurusan, String perIdn, String nim) async {
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
    List<String> nameClients;
    List<String> imageClients;
    var userStatus = "Mahasiswa"; // atau status lain jika diperlukan

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

    // Kirim data ke server
    for (int i = 0; i < nameClients.length; i++) {
      var nameClient = nameClients[i];
      var imageClient = imageClients[i];
      var url = await http.post(
        Uri.parse(ApiConstants.baseUrl +
            "api/SSOClients/create_applicationMahasiswa"),
        body: {
          "name_client": nameClient,
          "user_id": perIdn,
          "user_status": userStatus,
          "create_at": DateTime.now().toString(),
          "image": imageClient
        },
      );
      if (url.statusCode == 200) {
        print('Data untuk $nameClient berhasil dikirim');
      } else {
        print('Gagal mengirim data untuk $nameClient');
      }

      await Future.delayed(Duration(milliseconds: 500));
    }
  }

  // Fungsi Menambah Clients untuk Dosen
  Future<void> addClientsSSODsn(String userJurusan, String perIdn) async {
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

    for (int i = 0; i < nameClients.length; i++) {
      var nameClient = nameClients[i];
      var imageClient = imageClients[i];
      var url = await http.post(
        Uri.parse(
            ApiConstants.baseUrl + "api/SSOClients/create_applicationDosen"),
        body: {
          "name_client": nameClient,
          "user_id": perIdn,
          "user_status": "Dosen",
          "create_at": DateTime.now().toString(),
          "image": imageClient
        },
      );
      if (url.statusCode == 200) {
        print('Data untuk $nameClient berhasil dikirim');
      } else {
        print('Gagal mengirim data untuk $nameClient');
      }

      await Future.delayed(Duration(milliseconds: 500));
    }
  }

  // Fungsi Menambah Clients untuk Karyawan
  Future<void> addClientsSSOKryn(String perIdn) async {
    List<String> nameClients = ["Sistem Informasi Manajemen", "Koperasi"];
    List<String> imageClients = ["sim", "koperasi"];

    for (int i = 0; i < nameClients.length; i++) {
      var nameClient = nameClients[i];
      var imageClient = imageClients[i];
      var url = await http.post(
        Uri.parse(
            ApiConstants.baseUrl + "api/SSOClients/create_applicationKryn"),
        body: {
          "name_client": nameClient,
          "user_id": perIdn,
          "user_status": "Karyawan",
          "create_at": DateTime.now().toString(),
          "image": imageClient
        },
      );
      if (url.statusCode == 200) {
        print('Data untuk $nameClient berhasil dikirim');
      } else {
        print('Gagal mengirim data untuk $nameClient');
      }

      await Future.delayed(Duration(milliseconds: 500));
    }
  }

  // Fungsi Navigasi berdasarkan Level
  void _navigateToHome(String level) {
    switch (level) {
      case "Mahasiswa":
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => homeMhs()));
        CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          title: "Berhasil Masuk",
          text: "Aplikasi Penyedia Layanan",
          confirmBtnText: "Ok",
        );
        break;
      case "Dosen":
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => homeDsn()));
        CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          title: "Berhasil Masuk",
          text: "Aplikasi Penyedia Layanan",
          confirmBtnText: "Ok",
        );
        break;
      case "Karyawan":
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => homeKryn()));
        CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          title: "Berhasil Masuk",
          text: "Aplikasi Penyedia Layanan",
          confirmBtnText: "Ok",
        );
        break;
      default:
        print("Unknown Level");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tautkan Perangkat',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color.fromARGB(255, 255, 221, 27),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("Buka Identify Provider pada perangkat lain")],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Color.fromARGB(255, 255, 221, 27),
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: MediaQuery.of(context).size.width * 0.8,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // if (result != null)
                  //   Text(
                  //     'Data: ${result.code}',
                  //     style: TextStyle(fontSize: 16),
                  //   ),
                  // SizedBox(height: 10),
                  // ElevatedButton(
                  //   onPressed: result != null
                  //       ? () => validateToken(result.code)
                  //       : null,
                  //   child: Text('Validate Token'),
                  // ),
                  // if (validationMessage != null)
                  //   Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: Text(
                  //       validationMessage,
                  //       textAlign: TextAlign.center,
                  //       style: TextStyle(
                  //         color: Colors.green,
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //   ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk menangani data QR yang dipindai
  bool _isProcessing =
      false; // Tambahkan flag untuk menghindari pemrosesan ulang

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.resumeCamera();
    controller.scannedDataStream.listen((scanData) {
      if (!_isProcessing) {
        // Hanya proses jika tidak sedang memproses
        setState(() {
          _isProcessing = true; // Set flag menjadi true
          result = scanData;
        });
        validateToken(result.code);
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
