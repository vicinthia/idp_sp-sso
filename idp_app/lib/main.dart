import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:idp_app/component/widget/grafik.dart';
import 'package:idp_app/pages/admin.dart';
import 'package:idp_app/pages/dosen.dart';
import 'package:idp_app/pages/karyawan.dart';
import 'package:idp_app/pages/mahasiswa.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'api/link.dart';
import 'auth/login_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // checkConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SSO UBHARA',
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
    _checkToken();
  }

  Future<void> refreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String refreshUsername = prefs.getString('refreshUsername');
    String refreshPass = prefs.getString('refreshPass');

    if (token != null && JwtDecoder.isExpired(token)) {
      final response = await http.post(
          Uri.parse(ApiConstants.baseUrl + "api/UserSSO/login/index"),
          body: {"email": refreshUsername, "password": refreshPass});
      // Uri.parse(
      //     ApiConstants.baseUrl +'api/usersso/refresh_token'),
      // body: {'refresh_token': refreshToken});

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        String newToken = data['token'];

        await prefs.setString('token', newToken);
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => loginPage()));
        // Handle refresh token error

      }
    }
  }

  Future<void> _checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String switchLevel = prefs.getString('switchLevel');

    if (token != null && !JwtDecoder.isExpired(token) && isOnline) {
      // Token masih valid, navigasi ke halaman home
      switch (switchLevel) {
        case 'Admin':
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => adminPage(),
          ));
          break;
        case 'Mahasiswa':
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => mahasiswaPage(),
          ));
          break;
        case 'Dosen':
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => dosenPage(),
          ));
          break;
        case 'Karyawan':
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => karyawanPage(),
          ));
          break;
        default:
      }
    } else if (!isOnline) {
      // Token tidak ada atau sudah kedaluwarsa, navigasi ke halaman login
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => OfflineMessage()));
    } else {
      // Navigator.of(context).pushReplacement(
      //     MaterialPageRoute(builder: (context) => loginPage()));
      // Token expired, try to refresh it
      await refreshToken();

      // Recheck the token after attempting to refresh
      token = prefs.getString('token');
      if (token != null && !JwtDecoder.isExpired(token)) {
        switch (switchLevel) {
          case 'Admin':
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => adminPage(),
            ));
            break;
          case 'Mahasiswa':
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => mahasiswaPage(),
            ));
            break;
          case 'Dosen':
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => dosenPage(),
            ));
            break;
          case 'Karyawan':
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => karyawanPage(),
            ));
            break;
          default:
        }
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => loginPage()));
      }
    }
  }

  Future<http.Response> get() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');

    if (token != null && JwtDecoder.isExpired(token)) {
      await refreshToken();
      // token = prefs.setString('token');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
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
