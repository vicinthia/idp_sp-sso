import 'dart:async';
import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:idp_app/api/link.dart';
import 'package:idp_app/ddd.dart';
import 'package:idp_app/model/login_bloc.dart';
import 'package:idp_app/localstorage/bio_user.dart';
import 'package:idp_app/pages/admin.dart';
import 'package:idp_app/pages/karyawan.dart';
import 'package:idp_app/pages/mahasiswa.dart';
import 'package:idp_app/pages/dosen.dart';
import 'package:idp_app/registrasi/regis.dart';
import 'package:http/http.dart' as http;
import 'package:cool_alert/cool_alert.dart';
import 'package:idp_app/main.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:url_launcher/url_launcher.dart';

class loginPage extends StatefulWidget {
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  bool passenable = true;
  bool _isNotValidate = false;
  TextEditingController usernameInput = new TextEditingController();
  TextEditingController passwordInput = new TextEditingController();
  TextEditingController statusInput = new TextEditingController();
  String typeStatus;
  String alert = "Siap Login";
  String selectedValue;
  List categoryItemList = List();
  var sts;
  String username, password, name;
  String Passencrypt;

  final storage = FlutterSecureStorage();
  String _errorMessage = '';

  void openSPApp(String token) async {
    final spAppUrl = 'spapp://login?data=data dari apk 1';
    print('Trying to launch: $spAppUrl');
    if (await canLaunch(spAppUrl)) {
      await launch(spAppUrl);
      print('Launched: $spAppUrl');
    } else {
      print('Could not launch $spAppUrl');
      throw 'Could not launch $spAppUrl';
    }
  }

  Future<void> userLogIn() async {
    final response = await http.put(
        Uri.parse(ApiConstants.baseUrl +
            "api/func_admin/StatusUserToken/index/${_saveId}"),
        body: {"id": _savedId, "status": 'true'});
  }

  Future<void> prosesLogin() async {
    // buat sebuah variable untuk menampung proses request
    Passencrypt = enkripsi(passwordInput.text, 119);
    String chipertextBaru = ubahCiphertext(Passencrypt, 3);
    final dataLogin = await http.post(
        Uri.parse(ApiConstants.baseUrl + "api/UserSSO/login/index"),
        body: {"email": usernameInput.text, "password": chipertextBaru});

    if (dataLogin.statusCode == 200) {
      var dataAdmin = json.decode(dataLogin.body);
      if (dataAdmin['message'] == "Invalid email or password") {
        // jika user tidak ada, tampilkan alert data user tidak ada

        await CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            title: "Gagal Masuk ",
            text: "Username / Password Anda Salah!",
            confirmBtnText: "Ok");
        clearValues();
      } else {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', dataAdmin['token']);
        // await prefs.setString('refresh_token', dataAdmin['refresh_token']);
        await prefs.setString('switchLevel', dataAdmin['user']['level']);
        await prefs.setString('savedStatus', dataAdmin['user']['status']);

        await prefs.setString('refreshUsername', dataAdmin['user']['email']);
        await prefs.setString('refreshPass', dataAdmin['user']['password']);

        setState(() {
          username = dataAdmin['user']["email"];
          password = dataAdmin['user']["password"];
          _saveNama("${dataAdmin['user']["name"]}");
          _saveLevel("${dataAdmin['user']["level"]}");
          _saveNoInduk("${dataAdmin['user']["no_induk"]}");
          _saveNoTelp("${dataAdmin['user']["no_telp"]}");
          _saveEmail("${dataAdmin['user']["email"]}");
          _saveJurusan("${dataAdmin['user']["jurusan"]}");
          _saveId("${dataAdmin['user']["id"]}");
          _saveTest("Data dari aplikasi 1");
          http.put(
              Uri.parse(ApiConstants.baseUrl +
                  "api/func_admin/StatusUserToken/index/${dataAdmin['user']["id"]}"),
              body: {"id": "${dataAdmin['user']["id"]}", "status": 'true'});
        });

        switch (dataAdmin['user']["level"]) {
          case 'Admin':
            _launchURL();
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => adminPage()),
            );
            await CoolAlert.show(
                context: context,
                type: CoolAlertType.success,
                title: "Berhasil Masuk ",
                text: "Selamat Datang Admin!",
                confirmBtnText: "Ok");

            break;
          case 'Mahasiswa':
            _launchURL();

            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => mahasiswaPage()),
            );

            await CoolAlert.show(
                context: context,
                type: CoolAlertType.success,
                title: "Berhasil Masuk ",
                text: "Selamat Datang Mahasiswa!",
                confirmBtnText: "Ok");
            break;
          case 'Dosen':
            _launchURL();
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => dosenPage()),
            );
            await CoolAlert.show(
                context: context,
                type: CoolAlertType.success,
                title: "Berhasil Masuk ",
                text: "Selamat Datang Dosen!",
                confirmBtnText: "Ok");
            break;
          case 'Karyawan':
            _launchURL();
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => karyawanPage()),
            );
            await CoolAlert.show(
                context: context,
                type: CoolAlertType.success,
                title: "Berhasil Masuk ",
                text: "Selamat Datang!",
                confirmBtnText: "Ok");
            break;
          default:
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Error'),
                  content: Text('Unknown user role'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('OK'),
                    ),
                  ],
                );
              },
            );
        }
      }
    }
  }

  clearValues() {
    usernameInput.text = '';
    passwordInput.text = '';
  }

  String _savedNama = "";
  String _savedLevel = "";
  String _savedNoInduk = "";
  String _savedNoTelp = "";
  String _savedEmail = "";
  String _savedJurusan = "";
  String _savedId = "";
  String _savedToken = "";
  String _savedExp = "";
  String _savedStatus = "";
  String _test = "";
  SharedPreferences _prefs;

  int _pollingInterval = 60000; // 60 seconds

  ///// NAMA WP///////
  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();

    // print("Nama saved in SharedPreferences: $_savedNamaWP");
    _savedNama = _prefs.getString('myNama') ?? "";
    _savedLevel = _prefs.getString('myLevel') ?? "";
    _savedNoInduk = _prefs.getString('myNoInduk') ?? "";
    _savedNoTelp = _prefs.getString('myNoTelp') ?? "";
    _savedEmail = _prefs.getString('myEmail') ?? "";
    _savedJurusan = _prefs.getString('myJurusan') ?? "";
    _savedId = _prefs.getString('myId') ?? "";
    _savedToken = _prefs.getString('myToken') ?? "";
    _savedExp = _prefs.getString('myExp') ?? "";
    _test = _prefs.getString('myTest') ?? "";
    _savedStatus = _prefs.getString('myStatus') ?? "";

    setState(() {});
  }

  // Exp WP /////
  Future<void> _saveTest(String text) async {
    await _prefs.setString('myTest', text);
    print("Validasiyess $text");
    setState(() {
      _test = text;
      // print("DIGET ${GlobalData.getMyNama()}");
    });
  }

  // Exp WP /////
  Future<void> _saveExp(String text) async {
    await _prefs.setString('myExp', text);
    print("Validasiyess $text");
    setState(() {
      _savedExp = text;
      GlobalData.setMyExp("${_savedExp}");
      // print("DIGET ${GlobalData.getMyNama()}");
    });
  }

  //// Token WP /////
  Future<void> _saveToken(String text) async {
    await _prefs.setString('myToken', text);
    print("Nama saved in SharedPreferences: $text");
    setState(() {
      _savedToken = text;
      GlobalData.setMyToken("${_savedToken}");
      // print("DIGET ${GlobalData.getMyNama()}");
    });
  }

  //// Nama WP /////
  Future<void> _saveNama(String text) async {
    await _prefs.setString('myNama', text);
    print("Nama saved in SharedPreferences: $text");
    setState(() {
      _savedNama = text;
      GlobalData.setMyNama("${_savedNama}");
      storage.write(key: "namaKey", value: "${_savedNama}");
      // print("DIGET ${GlobalData.getMyNama()}");
    });
  }

  //// Level WP /////
  Future<void> _saveLevel(String text) async {
    await _prefs.setString('myLevel', text);
    // print("Level saved in SharedPreferences: $text");
    setState(() {
      _savedLevel = text;
      GlobalData.setMyLevel("${_savedLevel}");
    });
  }

  //// NoInduk WP /////
  Future<void> _saveNoInduk(String text) async {
    await _prefs.setString('myNoInduk', text);
    print("NIM SharedPreferences: $text");
    setState(() {
      _savedNoInduk = text;
      GlobalData.setMyNoInduk("${_savedNoInduk}");
    });
  }

  //// No Telp /////
  Future<void> _saveNoTelp(String text) async {
    await _prefs.setString('myNoTelp', text);
    // print("Alamat saved in SharedPreferences: $text");
    setState(() {
      _savedNoTelp = text;
      GlobalData.setMyNoTelp("${_savedNoTelp}");
    });
  }

  //// Email /////
  Future<void> _saveEmail(String text) async {
    await _prefs.setString('myEmail', text);
    // print("Alamat saved in SharedPreferences: $text");
    setState(() {
      _savedEmail = text;
      GlobalData.setMyEmail("${_savedEmail}");
    });
  }

  //// Jurusan /////
  Future<void> _saveJurusan(String text) async {
    await _prefs.setString('myJurusan', text);
    // print("Alamat saved in SharedPreferences: $text");
    setState(() {
      _savedJurusan = text;
      GlobalData.setMyJurusan("${_savedJurusan}");
    });
  }

  //// ID User /////
  Future<void> _saveId(String text) async {
    await _prefs.setString('myId', text);
    // print("Alamat saved in SharedPreferences: $text");
    setState(() {
      _savedId = text;
      GlobalData.setMyId("${_savedId}");
      print(_savedId);
    });
  }

  Future<List> getAllCategory() async {
    final response = await http
        .get(Uri.parse(ApiConstants.baseUrl + "api/StatusUser/index"));
    var jsonData = json.decode(response.body)['data'];

    setState(() {
      categoryItemList = jsonData;
    });
    print(categoryItemList);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllCategory();
    _initSharedPreferences();

    // add your code here.

    // if (_savedToken != null) {
    //   checkValid(_savedToken);
    // }
  }

  String enkripsi(String plaintext, int kunci) {
    String ciphertext = '';
    for (int i = 0; i < plaintext.length; i++) {
      // Mendapatkan kode ASCII asli dari karakter
      int kode_ascii_asli = plaintext.codeUnitAt(i);
      // Mengenkripsi kode ASCII dengan menggunakan kunci (dengan modulus 93 untuk loop)
      int enkripsi = (kode_ascii_asli + kunci) % 93;
      // Mengembalikan karakter terenkripsi dari enkripsi
      String karakter_terenkripsi = String.fromCharCode(33 + enkripsi);
      // Menambahkan karakter terenkripsi ke dalam teks terenkripsi
      ciphertext += karakter_terenkripsi;
    }
    return ciphertext;
  }

  String ubahCiphertext(String ciphertext, int kunci) {
    List<String> arrayBaris = List.filled(
        kunci, ''); // Inisialisasi array untuk menampung baris-baris ciphertext
    bool turun =
        true; // Inisialisasi variabel untuk menentukan apakah kita sedang bergerak ke bawah atau ke atas
    int barisSekarang = 0;

    // Menyusun ciphertext menjadi pola zig-zag
    for (int i = 0; i < ciphertext.length; i++) {
      arrayBaris[barisSekarang] +=
          ciphertext[i]; // Menambahkan karakter ke baris saat ini
      if (barisSekarang == 0) {
        turun = true;
      } else if (barisSekarang == kunci - 1) {
        turun = false;
      }
      if (turun) {
        barisSekarang++;
      } else {
        barisSekarang--;
      }
    }

    // Mengambil karakter dari setiap baris sesuai jumlah karakter di baris tersebut
    String chipertextBaru = '';
    for (int i = 0; i < arrayBaris.length; i++) {
      chipertextBaru += arrayBaris[i];
    }

    return chipertextBaru;
  }

// KIRIM TOKEN BY APP
  void _launchURL() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    final spAppUrl = 'spapp://login?data=${token}';

    String url = spAppUrl;
    if (await canLaunch(url)) {
      await launch(url);
      _navigateToMainAppAfterDelay();
    } else {
      throw 'Could not launch $url';
    }
  }

  void _launchCallBack() async {
    final idpAppUrl = 'idpapp://login';

    String url = idpAppUrl;
    if (await canLaunch(url)) {
      await launch(url);
      // _navigateToMainAppAfterDelay();
    } else {
      throw 'Could not launch $url'; // Kalau tidak ada / tidak punya SP APP
    }
  }

  Future<void> _navigateToMainAppAfterDelay() async {
    await Future.delayed(Duration(seconds: 1));
    _launchCallBack();
  }

  @override
  Widget build(BuildContext context) {
    // final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        // padding: EdgeInsets.only(top: 40.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          // padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 220,
                decoration:
                    BoxDecoration(color: Color.fromARGB(255, 222, 222, 222)),
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Center(
                      child: Image.asset(
                    "assets/sso.png",
                    height: 200,
                  )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "Welcome to SSO\nInternal UBHARA",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  "Sign In",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text("Username"),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                child: Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      controller: usernameInput,
                      autofocus: true,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        hintText: "Masukkan Username Anda...",
                        // labelText: "Username",
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Mohon masukkan username!";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text("Password"),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                child: Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      controller: passwordInput,
                      obscureText: passenable,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          isDense: true,
                          contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          hintText: "Masukkan Password Anda...",
                          // labelText: "Password",
                          prefixIcon: Icon(Icons.lock),
                          suffix: IconButton(
                              onPressed: () {
                                setState(() {
                                  if (passenable) {
                                    passenable = false;
                                  } else {
                                    passenable = true;
                                  }
                                });
                              },
                              icon: Icon(passenable == true
                                  ? Icons.remove_red_eye
                                  : Icons.password))),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Mohon masukkan password!";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 28,
              ),
              Center(
                child: SizedBox(
                  height: 40,
                  width: 260,
                  child: ElevatedButton(
                    onPressed: () async {
                      prosesLogin();
                      // _launchURL();
                    },
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 0, 83, 192),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
              if (_errorMessage.isNotEmpty)
                Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              SizedBox(
                height: 28,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: RichText(
                      text: TextSpan(
                          style: TextStyle(
                            fontSize: 15,
                          ),
                          children: [
                        TextSpan(
                            style: TextStyle(
                                color: Color.fromARGB(255, 0, 83, 192),
                                decoration: TextDecoration.underline),
                            //make link blue and underline
                            text: "Belum punya akun ? ",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => regisPage()));
                              }),

                        //more text paragraph, sentences here.
                      ]))),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 150,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
