import 'package:flutter/material.dart';

class aboutSSO extends StatefulWidget {
  @override
  _aboutSSOState createState() => _aboutSSOState();
}

class _aboutSSOState extends State<aboutSSO> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 83, 192),
        title: Text("About"),
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
                      "ABOUT SINGLE SIGN ON (SSO) UBHARA",
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
                            "assets/about.png",
                            width: 300,
                            height: 300,
                          ),
                        ),
                        Center(
                          child: Text(
                            'Kemajuan teknologi memberi kemudahan bagi manusia untuk menyelesaikan segala bentuk pekerjaannya. Banyak aplikasi yang pada akhirnya lahir untuk memenuhi kebutuhan. Namun, dengan banyaknya aplikasi kadang membuat penggunanya sering lupa dengan akun dan password yang digunakannya. Dari problematika inilah kemudian muncul sistem login yang dikenal dengan Single Sign On (SSO) sebagai solusi atas isu tersebut.\n\nSebagai sebuah sistem layanan autentikasi, Single Sign On berperan untuk menanggulangi masalah lupa password serta mempermudah proses masuk ke suatu situs atau aplikasi. Dengan sistem ini, pengguna hanya perlu login sekali untuk masuk ke beberapa aplikasi sekaligus.',
                            textAlign: TextAlign.left,
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
