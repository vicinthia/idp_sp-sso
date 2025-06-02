import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:layanan_app/check_inout.dart';
import 'package:layanan_app/check_page.dart';
import 'package:layanan_app/model/app1/client_sim.dart';
import 'package:layanan_app/pages/home.dart';
import 'package:layanan_app/model/status_token.dart';
import 'package:layanan_app/test.dart';
import 'package:lottie/lottie.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

import 'package:layanan_app/dosen/home_Dsn.dart';
import 'package:layanan_app/karyawan/home_Kryn.dart';
import 'package:layanan_app/mahasiswa/home_Mhs.dart';
import 'package:provider/provider.dart';

import 'api/link.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserSIM(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SP UBHARA',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

DateTime tgl;

class _SplashScreenState extends State<SplashScreen> {
  bool isOnline = true;

  void checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      isOnline = connectivityResult != ConnectivityResult.none;
    });

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        isOnline = result != ConnectivityResult.none;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    checkConnectivity();
    // fetchData();
    _checkToken();
    tgl = DateTime.now();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   fetchData();
    // });
    //Akun();
  }

  void Akun() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String _receivedData = prefs.getString('receivedData') ?? "";
    if (JwtDecoder.isExpired(_receivedData)) {
      await prefs.setBool('pilihAkun', false);
    }
  }

  // Future<void> fetchData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String id = prefs.getString('id') ?? null;
  //   String _receivedData = prefs.getString('receivedData') ?? "";

  //   if (id != null) {
  //     User.getUsers(id).then((users) async {
  //       statusInOut = "";

  //       for (int i = 0; i < users.length; i++)
  //         statusInOut = statusInOut + users[i].status;
  //       _checkToken();
  //     });
  //   } else {
  //     Navigator.of(context).pushReplacement(
  //         MaterialPageRoute(builder: (context) => checkPage()));
  //   }

  // }

  String statusInOut;
  Future<void> _checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String _receivedData = prefs.getString('receivedData') ?? "";
    // String statusInOut = prefs.getString('statusInOut') ?? "";

    bool _pilihAkun = prefs.getBool('pilihAkun') ?? false;
    String id = prefs.getString('id') ?? null;
    String perLevel = prefs.getString('perLevel') ?? null;

    if (_receivedData != null &&
        _receivedData.isNotEmpty &&
        !JwtDecoder.isExpired(_receivedData) &&
        _pilihAkun == true &&
        isOnline) {
      // Token masih valid, navigasi ke halaman home
      // Navigator.of(context).pushReplacement(MaterialPageRoute(
      //   builder: (context) => homePage(),
      // ));
      switch (perLevel) {
        case "Mahasiswa":
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => homeMhs()));

          break;
        case "Dosen":
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => homeDsn()));

          break;
        case "Karyawan":
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => homeKryn()));

          break;
        default:
      }
    } else if (!isOnline) {
      // Token tidak ada atau sudah kedaluwarsa, navigasi ke halaman login
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => OfflineMessage()));
    } else if (_receivedData != null &&
        _receivedData.isNotEmpty &&
        JwtDecoder.isExpired(_receivedData) &&
        _pilihAkun == true &&
        isOnline) {
      // buat cetak refresh token baru / update refresh time, tunggu token exp selama 15 menit dulu
      await createRefresh();

      _receivedData = prefs.getString('receivedData');
      if (_receivedData != null &&
          _receivedData.isNotEmpty &&
          !JwtDecoder.isExpired(_receivedData) &&
          _pilihAkun == true &&
          isOnline) {
        // Token masih valid, navigasi ke halaman home
        // Navigator.of(context).pushReplacement(MaterialPageRoute(
        //   builder: (context) => homePage(),
        // ));
        switch (perLevel) {
          case "Mahasiswa":
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => homeMhs()));

            break;
          case "Dosen":
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => homeDsn()));

            break;
          case "Karyawan":
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => homeKryn()));

            break;
          default:
        }
      } else if (!isOnline) {
        // Token tidak ada atau sudah kedaluwarsa, navigasi ke halaman login
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => OfflineMessage()));
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => checkPage()));
      }
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => checkPage()));
    }
  }

// Create Token baru dari ID dari createTefresh
  Future<void> refreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String paramCreate = prefs.getString('newCreate');

    if (paramCreate != null && !JwtDecoder.isExpired(paramCreate)) {
      final response = await http.post(
          Uri.parse(ApiConstants.baseUrl + "api/UserSSO/refresh_token"),
          body: {"refresh_token": "${paramCreate}", "time_refresh": "${tgl}"});

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        String newToken = data['newtoken'];
        await prefs.setString('receivedData', newToken);

        print("new Token" + newToken);
      } else {
        print("Error buat token baru");
      }
    }
  }

// Create ID Token untuk Refresh Token
  Future<void> createRefresh() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('id');
    String _receivedData = prefs.getString('receivedData');

    final response = await http.post(
        Uri.parse(ApiConstants.baseUrl + "api/UserSSO/create_refresh"),
        body: {"id": id, "time_refresh": '${tgl}'});
    // User.getUsers(id).then((users) async {
    //   statusInOut = "";

    //   for (int i = 0; i < users.length; i++)
    //     statusInOut = statusInOut + users[i].status;
    //   ;
    // });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      String newCreate = data['newCreate'];

      print("new ID" + newCreate);
      await prefs.setString('newCreate', newCreate);
      // await prefs.setString('statusInOut', '${statusInOut}');
      print(newCreate);
      await refreshToken();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

class OfflineMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Lottie.asset(
                'assets/animations/offline.json',
                width: 200,
                height: 200,
              ),
              SizedBox(height: 20),
              Text(
                'You are offline!',
                style: TextStyle(fontSize: 24, color: Colors.red),
              ),
            ],
          ),
        ));
  }
}
