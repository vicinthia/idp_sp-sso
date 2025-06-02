import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:idp_app/auth/login_page.dart';

import 'package:idp_app/localstorage/bio_user.dart';
import 'package:idp_app/pages/mahasiswa.dart';
import 'package:idp_app/registrasi/regis.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences _prefs = await SharedPreferences.getInstance();

  runApp(MyApp(
    cekMyExp: _prefs.getString('myVlds') ?? "",
  ));

  // Workmanager().initialize(callbackDispatcher);
}

class MyApp extends StatefulWidget {
  final cekMyExp;

  final validToken;

  final exp;
  final begintoken;
  MyApp({this.validToken, this.exp, this.begintoken, this.cekMyExp});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<Widget> checkValid() async {
    final response = await http.get(
      Uri.parse(
          'http://0331kebonagung.ikc.co.id/ssoauth/decode_token/${widget.cekMyExp}'),
      // headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      print('Response status: ${response.statusCode}');
      print('Response data: ${responseData}');
      if (responseData['status'] == false) {
        print('Error: ${responseData['status']}');
        return loginPage();
      } else {
        _prefs.setString('mySts', "true");
        return mahasiswaPage();
      }
    } else {
      print('Error: ${response.reasonPhrase}');
      return loginPage();
    }
  }

  SharedPreferences _prefs;

  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initSharedPreferences();

    // startRealTimeValidation();
  }

  @override
  Widget build(BuildContext context) {
    String token = GlobalData.getMyToken();
    String validTokenx = GlobalData.getMyExp();
    return MaterialApp(
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      title: 'SSO IdP',

      // home: FutureBuilder<Widget>(
      //   future: checkValid(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return CircularProgressIndicator();
      //     } else {
      //       return snapshot.data ?? loginPage();
      //     }
      //   },
      // ),
      home: (widget.cekMyExp) == "true" ? mahasiswaPage() : loginPage(),
    );
  }
}
