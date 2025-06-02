import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:idp_app/auth/login_page.dart';

import '../api/link.dart';

class regisPage extends StatefulWidget {
  final typeStatus;
  regisPage({this.typeStatus});
  @override
  _regisPageState createState() => _regisPageState();
}

class _regisPageState extends State<regisPage> {
  String selectedValue;
  List categoryItemList = List();
  String selectedJurusan;
  List categoryJurusan = List();
  final _formKey = GlobalKey<FormState>();
  TextEditingController nama = new TextEditingController();
  TextEditingController no_induk = new TextEditingController();
  TextEditingController no_tlp = new TextEditingController();
  TextEditingController username = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  TextEditingController jabatan = new TextEditingController();

  var form;
  bool _showTextField = false;
  bool passenable = true;
  DateTime tgl = new DateTime.now();
  bool apiCallMade = false;
  String teks_terenkripsi;
  bool _isPasswordEightChar = false;

  onPasswordChanged(String password) {
    setState(() {
      _isPasswordEightChar = false;
      if (password.length >= 8) {
        _isPasswordEightChar = true;
      }
    });
  }

  onValidate() {}

  void addData() {
    Passencrypt = enkripsi(pass.text, 119);
    String chipertextBaru = ubahCiphertext(Passencrypt, 3);
    var url = http
        .post(Uri.parse(ApiConstants.baseUrl + "api/CrudUser/index"), body: {
      "name": "${nama.text}",
      "email": "${username.text}",
      "password": "$chipertextBaru",
      "level": selectedValue,
      "no_induk": "${no_induk.text}",
      "jurusan": selectedJurusan,
      "no_telp": "${no_tlp.text}",
      "created_at": "${tgl}",
    });
    setState(() {
      apiCallMade = true;
    });
  }

  String jbt;
  String Passencrypt;

  @override
  void initState() {
    // TODO: implement initState
    getAllCategory();
    getAllJurusan();
    super.initState();
    if (no_induk.text == null) {
      jbt = jabatan.text;
    } else {
      jbt = no_induk.text;
    }
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

  Future<List> getAllCategory() async {
    final response = await http
        .get(Uri.parse(ApiConstants.baseUrl + "api/StatusUser/index"));
    var jsonData = json.decode(response.body)['data'];

    setState(() {
      categoryItemList = jsonData;
    });
    print(categoryItemList);
  }

  Future<List> getAllJurusan() async {
    final response = await http
        .get(Uri.parse(ApiConstants.baseUrl + "api/StatusUser/index"));
    var jsonData = json.decode(response.body)['data'];

    setState(() {
      categoryJurusan = jsonData;
    });
    print(categoryJurusan);
  }

  String _email;
  String _emailError;

  Future<String> checkEmailAvailability(String email) async {
    final response = await http.post(
      Uri.parse(ApiConstants.baseUrl + 'api/EmailValid/check_email/index'),
      body: {'email': email},
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      print('respon :' + response.statusCode.toString());
      print(responseData['status']);
      if (responseData['status'] == false) {
        _showEmailRegisteredDialog();
      } else {
        addData();
        // addClientsSSO();
        setState(() {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => loginPage()));
          CoolAlert.show(
              context: context,
              type: CoolAlertType.success,
              title: "Berhasil Registrasi",
              text: "Silahkan Login!",
              confirmBtnText: "Ok");
        });
      }
    } else {
      _showErrorDialog();
    }
  }

  void _showEmailRegisteredDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Email Unavailable'),
          content: Text(
              'Email is already registered. Please use a different email.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // void _showEmailAvailableDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Email Available'),
  //         content: Text('Email is available.'),
  //         actions: <Widget>[
  //           TextButton(
  //             child: Text('OK'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(
              'Unable to check email availability. Please try again later.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    username.dispose();
    super.dispose();
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // padding: EdgeInsets.only(top: 40.0),

        // padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
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
                  "Registrasi User SSO",
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
                padding: EdgeInsets.only(left: 67),
                child: Text(
                  "Status",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),

              SizedBox(
                child: Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: DropdownButtonFormField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.account_circle)),
                        hint: Text("Sesuaikan Status!"),
                        value: selectedValue,
                        items: categoryItemList.map((category) {
                          return DropdownMenuItem(
                              value: category['user'],
                              child: Text(category['user']));
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;

                            _showTextField = true;
                          });
                        }),
                  ),
                ),
              ),
              SizedBox(height: 30.0),

              selectedValue == "Mahasiswa"
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text("Nama Lengkap"),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: Flexible(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: TextFormField(
                                controller: nama,
                                autofocus: true,
                                // keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  hintText: "Masukkan Nama Anda...",
                                  // labelText: "Nama",
                                  prefixIcon: Icon(Icons.person),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Mohon masukkan nama!";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text("NIM"),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: Flexible(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: TextFormField(
                                controller: no_induk,
                                autofocus: true,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  hintText: "Masukkan NIM Anda...",
                                  // labelText: "Nama",
                                  prefixIcon: Icon(Icons.library_books),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Mohon masukkan nim!";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text("Jurusan"),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: Flexible(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.account_circle)),
                                hint: Text("Sesuaikan Jurusan!"),
                                value: selectedJurusan,
                                items: categoryJurusan.map((category) {
                                  return DropdownMenuItem(
                                      value: category['jurusan'],
                                      child: Text(category['jurusan']));
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedJurusan = value;
                                    _showTextField = true;
                                  });
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return "Jurusan belum dipilih!";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text("No Telp Mahasiswa"),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: Flexible(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: TextFormField(
                                controller: no_tlp,
                                autofocus: true,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  hintText: "Masukkan Nomor Anda...",
                                  // labelText: "Nama",
                                  prefixIcon: Icon(Icons.local_phone),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Mohon masukkan nomor";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text("Email"),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: Flexible(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: TextFormField(
                                  controller: username,
                                  autofocus: true,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    hintText: "Masukkan Email Anda...",
                                    // labelText: "Nama",
                                    prefixIcon: Icon(Icons.verified_user),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Email tidak boleh kosong';
                                    } else if (!isEmail(value)) {
                                      return 'Format email tidak valid';
                                    }

                                    return null;
                                  }),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text("Password"),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: Flexible(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: TextFormField(
                                onChanged: (password) =>
                                    onPasswordChanged(password),
                                controller: pass,
                                obscureText: passenable,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    isDense: true,
                                    contentPadding:
                                        EdgeInsets.fromLTRB(10, 10, 10, 0),
                                    hintText: "Masukkan Password Anda...",
                                    // labelText: "Password",
                                    prefixIcon: Icon(Icons.lock),
                                    suffix: IconButton(
                                        onPressed: () {
                                          //add Icon button at end of TextField
                                          setState(() {
                                            //refresh UI
                                            if (passenable) {
                                              //if passenable == true, make it false
                                              passenable = false;
                                            } else {
                                              passenable =
                                                  true; //if passenable == false, make it true
                                            }
                                          });
                                        },
                                        icon: Icon(passenable == true
                                            ? Icons.remove_red_eye
                                            : Icons.password))),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Mohon masukkan password!";
                                  } else if (_isPasswordEightChar == false) {
                                    return "Mohon password minimal 8 karakter!";
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            children: [
                              AnimatedContainer(
                                duration: Duration(milliseconds: 500),
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: _isPasswordEightChar
                                      ? Colors.green
                                      : Colors.transparent,
                                  border: _isPasswordEightChar
                                      ? Border.all(color: Colors.transparent)
                                      : Border.all(color: Colors.grey.shade400),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              Text("Contains at least 8 chracters")
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Center(
                          child: SizedBox(
                            height: 40,
                            width: 260,
                            child: ElevatedButton(
                              onPressed: () async {
                                // JIKA DATA TERVALIDASI

                                if (_formKey.currentState.validate()) {
                                  checkEmailAvailability(username.text);

                                  // Jika registrasi gagal

                                } else if (!_formKey.currentState.validate()) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text('Gagal Registrasi'),
                                      content:
                                          Text('Data belum terisi lengkap'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('OK'),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                "Registrasi",
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
                                          color:
                                              Color.fromARGB(255, 0, 83, 192),
                                          decoration: TextDecoration.underline),
                                      //make link blue and underline
                                      text: "Back to Login Page",
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      loginPage()));
                                        }),

                                  //more text paragraph, sentences here.
                                ]))),
                        SizedBox(
                          height: 400,
                        )
                      ],
                    )
                  : SizedBox(),

///// REGIS DOSEN ///////
              selectedValue == "Dosen"
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text("Nama Lengkap"),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: Flexible(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: TextFormField(
                                controller: nama,
                                autofocus: true,
                                // keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  hintText: "Masukkan Nama Anda...",
                                  // labelText: "Nama",
                                  prefixIcon: Icon(Icons.person),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Mohon masukkan nama!";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text("NIDN"),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: Flexible(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: TextFormField(
                                controller: no_induk,
                                autofocus: true,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  hintText: "Masukkan NIDN Anda...",
                                  // labelText: "Nama",
                                  prefixIcon: Icon(Icons.library_books),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Mohon masukkan nidn!";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text("Jurusan"),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: Flexible(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.account_circle)),
                                hint: Text("Sesuaikan Jurusan!"),
                                value: selectedJurusan,
                                items: categoryJurusan.map((category) {
                                  return DropdownMenuItem(
                                      value: category['jurusan'],
                                      child: Text(category['jurusan']));
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedJurusan = value;

                                    _showTextField = true;
                                  });
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return "Jurusan belum dipilih!";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text("No Telp"),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: Flexible(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: TextFormField(
                                controller: no_tlp,
                                autofocus: true,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  hintText: "Masukkan Nomor Anda...",
                                  // labelText: "Nama",
                                  prefixIcon: Icon(Icons.local_phone),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Mohon masukkan nomor";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text("Email"),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: Flexible(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: TextFormField(
                                controller: username,
                                autofocus: true,
                                keyboardType: TextInputType.emailAddress,
                                // keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  hintText: "Masukkan Email Anda...",
                                  // labelText: "Nama",
                                  prefixIcon: Icon(Icons.verified_user),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Email tidak boleh kosong';
                                  } else if (!isEmail(value)) {
                                    return 'Format email tidak valid';
                                  }

                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text("Password"),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: Flexible(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: TextFormField(
                                onChanged: (password) =>
                                    onPasswordChanged(password),
                                controller: pass,
                                obscureText: passenable,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    isDense: true,
                                    contentPadding:
                                        EdgeInsets.fromLTRB(10, 10, 10, 0),
                                    hintText: "Masukkan Password Anda...",
                                    // labelText: "Password",
                                    prefixIcon: Icon(Icons.lock),
                                    suffix: IconButton(
                                        onPressed: () {
                                          //add Icon button at end of TextField
                                          setState(() {
                                            //refresh UI
                                            if (passenable) {
                                              //if passenable == true, make it false
                                              passenable = false;
                                            } else {
                                              passenable =
                                                  true; //if passenable == false, make it true
                                            }
                                          });
                                        },
                                        icon: Icon(passenable == true
                                            ? Icons.remove_red_eye
                                            : Icons.password))),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Mohon masukkan password!";
                                  } else if (_isPasswordEightChar == false) {
                                    return "Mohon password minimal 8 karakter!";
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            children: [
                              AnimatedContainer(
                                duration: Duration(milliseconds: 500),
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: _isPasswordEightChar
                                      ? Colors.green
                                      : Colors.transparent,
                                  border: _isPasswordEightChar
                                      ? Border.all(color: Colors.transparent)
                                      : Border.all(color: Colors.grey.shade400),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              Text("Contains at least 8 chracters")
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Center(
                          child: SizedBox(
                            height: 40,
                            width: 260,
                            child: ElevatedButton(
                              onPressed: () async {
                                // JIKA DATA TERVALIDASI
                                if (_formKey.currentState.validate()) {
                                  checkEmailAvailability(username.text);

                                  // Jika registrasi gagal

                                } else if (!_formKey.currentState.validate()) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text('Gagal Registrasi'),
                                      content:
                                          Text('Data belum terisi lengkap'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('OK'),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                "Registrasi",
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
                                          color:
                                              Color.fromARGB(255, 0, 83, 192),
                                          decoration: TextDecoration.underline),
                                      //make link blue and underline
                                      text: "Back to Login Page",
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      loginPage()));
                                        }),

                                  //more text paragraph, sentences here.
                                ]))),
                        SizedBox(
                          height: 400,
                        )
                      ],
                    )
                  : SizedBox(),
///// REGIS KARYAWAN /////
              selectedValue == "Karyawan"
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text("Nama Lengkap"),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: Flexible(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: TextFormField(
                                controller: nama,
                                autofocus: true,
                                // keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  hintText: "Masukkan Nama Anda...",
                                  // labelText: "Nama",
                                  prefixIcon: Icon(Icons.person),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Mohon masukkan nama!";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text("Jabatan"),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: Flexible(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: TextFormField(
                                controller: no_induk,
                                autofocus: true,
                                // keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  hintText: "Masukkan Jabatan Anda...",
                                  // labelText: "Nama",
                                  prefixIcon: Icon(Icons.library_books),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Mohon masukkan jabatan!";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text("Jurusan"),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: Flexible(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.account_circle)),
                                hint: Text("Sesuaikan Jurusan!"),
                                value: selectedJurusan,
                                items: categoryJurusan.map((category) {
                                  return DropdownMenuItem(
                                      value: category['jurusan'],
                                      child: Text(category['jurusan']));
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedJurusan = value;

                                    _showTextField = true;
                                  });
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return "Jurusan belum dipilih!";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text("No Telp"),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: Flexible(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: TextFormField(
                                controller: no_tlp,
                                autofocus: true,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  hintText: "Masukkan Nomor Anda...",
                                  // labelText: "Nama",
                                  prefixIcon: Icon(Icons.local_phone),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Mohon masukkan nomor";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text("Email"),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: Flexible(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: TextFormField(
                                controller: username,
                                autofocus: true,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  hintText: "Masukkan Email Anda...",
                                  // labelText: "Nama",
                                  prefixIcon: Icon(Icons.verified_user),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Email tidak boleh kosong';
                                  } else if (!isEmail(value)) {
                                    return 'Format email tidak valid';
                                  }

                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text("Password"),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: Flexible(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: TextFormField(
                                onChanged: (password) =>
                                    onPasswordChanged(password),
                                controller: pass,
                                obscureText: passenable,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    isDense: true,
                                    contentPadding:
                                        EdgeInsets.fromLTRB(10, 10, 10, 0),
                                    hintText: "Masukkan Password Anda...",
                                    // labelText: "Password",
                                    prefixIcon: Icon(Icons.lock),
                                    suffix: IconButton(
                                        onPressed: () {
                                          //add Icon button at end of TextField
                                          setState(() {
                                            //refresh UI
                                            if (passenable) {
                                              //if passenable == true, make it false
                                              passenable = false;
                                            } else {
                                              passenable =
                                                  true; //if passenable == false, make it true
                                            }
                                          });
                                        },
                                        icon: Icon(passenable == true
                                            ? Icons.remove_red_eye
                                            : Icons.password))),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Mohon masukkan password!";
                                  } else if (_isPasswordEightChar == false) {
                                    return "Mohon password minimal 8 karakter!";
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            children: [
                              AnimatedContainer(
                                duration: Duration(milliseconds: 500),
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: _isPasswordEightChar
                                      ? Colors.green
                                      : Colors.transparent,
                                  border: _isPasswordEightChar
                                      ? Border.all(color: Colors.transparent)
                                      : Border.all(color: Colors.grey.shade400),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              Text("Contains at least 8 chracters")
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Center(
                          child: SizedBox(
                            height: 40,
                            width: 260,
                            child: ElevatedButton(
                              onPressed: () async {
                                // JIKA DATA TERVALIDASI
                                if (_formKey.currentState.validate()) {
                                  checkEmailAvailability(username.text);

                                  // Jika registrasi gagal

                                } else if (!_formKey.currentState.validate()) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text('Gagal Registrasi'),
                                      content:
                                          Text('Data belum terisi lengkap'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('OK'),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                "Registrasi",
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
                                          color:
                                              Color.fromARGB(255, 0, 83, 192),
                                          decoration: TextDecoration.underline),
                                      //make link blue and underline
                                      text: "Back to Login Page",
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      loginPage()));
                                        }),

                                  //more text paragraph, sentences here.
                                ]))),
                        SizedBox(
                          height: 400,
                        )
                      ],
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  bool isEmail(String email) {
    String regex = "[a-z0-9]+@[a-z0-9]+\\.[a-z]+";
    RegExp regExp = new RegExp(regex);
    return regExp.hasMatch(email);
  }
}
