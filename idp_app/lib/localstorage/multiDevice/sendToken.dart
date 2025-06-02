import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:cool_alert/cool_alert.dart';

import '../../api/link.dart';
import 'dart:convert';

import '../profileuser.dart';

class sendQR extends StatefulWidget {
  @override
  _sendQRState createState() => _sendQRState();
}

class _sendQRState extends State<sendQR> {
  // Fungsi untuk merefresh token
  Future<String> refreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String refreshUsername = prefs.getString('refreshUsername');
    String refreshPass = prefs.getString('refreshPass');

    if (refreshUsername != null && refreshPass != null) {
      final response = await http.post(
        Uri.parse(ApiConstants.baseUrl + "api/UserSSO/login/index"),
        body: {"email": refreshUsername, "password": refreshPass},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        String storedToken = data['token'];

        // Simpan token baru ke SharedPreferences
        await prefs.setString('token', storedToken);

        return storedToken;
      }
    }
    return null; // Return null jika gagal mendapatkan token
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 83, 192),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => profileUser()),
            );
          },
          icon: Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text("Perangkat Tertaut", style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: FutureBuilder<String>(
            future:
                refreshToken(), // Memanggil refreshToken() untuk mendapatkan token
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(); // Tampilkan loading saat menunggu data
              }
              if (snapshot.hasError || !snapshot.hasData) {
                return Text("Gagal memuat token",
                    style: TextStyle(color: Colors.red));
              }

              // Tampilkan QR Code jika token tersedia
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 250,
                    height: 450,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.black, width: 4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 4),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 20),
                          child: QrImage(
                            data: snapshot.data ??
                                "No Token", // Ambil token dari FutureBuilder
                            version: QrVersions.auto,
                            size: 200.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20), // Spasi antara Container dan teks
                  Text(
                    "Login ke Service Provider",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "1. Buka Service Provider di perangkat device Anda",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "2. Ketuk 'Tautkan Perangkat Multi Device' lalu Tautkan perangkat",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "3. Arahkan perangkat Anda di layar ini untuk memindai kode QR",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
