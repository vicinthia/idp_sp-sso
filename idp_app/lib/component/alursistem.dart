import 'package:flutter/material.dart';

class alurSistem extends StatefulWidget {
  @override
  _alurSistemState createState() => _alurSistemState();
}

class _alurSistemState extends State<alurSistem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 83, 192),
        title: Text("Alur Sistem"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: Container(
                  // color: Colors.pink,
                  margin: EdgeInsets.only(top: 5, bottom: 10),
                  // width: 200,
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Text(
                      "ALUR SISTEM SINGLE SIGN ON (SSO) UBHARA",
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  color: Colors.white,
                  // width: MediaQuery.of(context).size.width,
                  // height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.all(20.0),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.asset(
                            "assets/alur_satu.png",
                            width: 300,
                            height: 300,
                          ),
                        ),
                        // SizedBox(height: 10.0),
                        Center(
                          child: Text(
                            'Pengguna membuka aplikasi Penyedia Identitas (IdP) dan Klik menu Registrasi User yang terdapat pada halaman login aplikasi.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                        Center(
                          child: Image.asset(
                            "assets/alur_dua.png",
                            width: 300,
                            height: 300,
                          ),
                        ),
                        Center(
                          child: Text(
                            'Kemudian isi data - data sesuai formulir isian online. User perorangan wajib diisi data NIM / NIDN, Username, Password, dll.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                        Center(
                          child: Image.asset(
                            "assets/alur_tiga.png",
                            width: 300,
                            height: 300,
                          ),
                        ),
                        Center(
                          child: Text(
                            'Setelah registrasi berhasil, lakukan login User. Anda dapat secara otomatis masuk ke layanan aplikasi apa saja di Ubhara yang telah terintegrasi dengan SSO. Aplikasi Penyedia Layanan tersebut bisa diakses pada Aplikasi Penyedia Layanan (SP).',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
