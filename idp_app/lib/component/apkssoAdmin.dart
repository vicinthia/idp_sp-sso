import 'package:flutter/material.dart';
import 'package:idp_app/localstorage/bio_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class apkSSOAdmin extends StatefulWidget {
  @override
  _apkSSOAdminState createState() => _apkSSOAdminState();
}

class _apkSSOAdminState extends State<apkSSOAdmin> {
  List SmtAtasMenu = [
    'SIM',
    'Koperasi',
  ];

  List SmtAtasImg = [
    'sim',
    'koperasi',
  ];

  ///ELETRO ///
  List SmtAtasMenuElektro = [
    'SIM',
    'Koperasi',
  ];

  List SmtAtasImgElektro = [
    'sim',
    'koperasi',
  ];

  ///SIPIL ///
  List SmtAtasMenuSipil = [
    'SIM',
    'Koperasi',
  ];

  List SmtAtasImgSipil = [
    'sim',
    'koperasi',
  ];

  DateTime now = DateTime.now();
  String Semester;
  String ThnMasuk;
  String ThnMasukMhs;
  String MySemester;

  var filterMenu;
  var filterGbr;

  var filterMenuEletro;
  var filterGbrElktro;

  var filterMenuSipil;
  var filterGbrSipil;

  SharedPreferences _prefs;

  String _savedJurusan = "";

  String _savedLevel = "";
  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedLevel = _prefs.getString('myLevel') ?? "";

      _savedJurusan = _prefs.getString('myJurusan') ?? "";
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initSharedPreferences();
    int year = now.year;
    ThnMasuk = year.toString();
    ThnMasukMhs = ThnMasuk.substring(ThnMasuk.length - 2);

    // Semester =
    //     "${int.tryParse(ThnMasukMhs) - int.tryParse(GlobalData.getMyNoInduk().substring(0, 2))}";
    // MySemester = "${int.tryParse(Semester) * 2}";

    print(MySemester);

    switch (_savedJurusan) {
      case 'Teknik Sipil':
        filterMenu = SmtAtasMenuSipil;
        filterGbr = SmtAtasImgSipil;
        break;
      case 'Teknik Elektronika':
        filterMenu = SmtAtasMenuElektro;
        filterGbr = SmtAtasImgElektro;
        break;
      case 'Teknik Informatika':
        filterMenu = SmtAtasMenu;
        filterGbr = SmtAtasImg;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double gridSpacing = 10.0;
    int crossAxisCount = 2;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 83, 192),
        title: Text("Aplikasi SSO"),
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                    "APLIKASI TERINTEGRASI SISTEM SINGLE SIGN ON (SSO) UBHARA",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
            child: Center(
              child: Container(
                // color: Colors.pink,
                margin: EdgeInsets.only(bottom: 10),
                // width: 200,
                width: MediaQuery.of(context).size.width,
                height: 50,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    "${_savedLevel} / ${_savedJurusan}",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
              padding: EdgeInsets.all(15.0),
              child: GridView.builder(
                  itemCount: filterMenu.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount, // Jumlah kolom dalam grid
                    childAspectRatio:
                        screenWidth / (screenHeight / 2), // Rasio responsif
                    mainAxisSpacing: gridSpacing,
                    crossAxisSpacing: gridSpacing,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        if (filterGbr[index] == "sim") {
                          print("touch");
                        }
                      },
                      child: GridTile(
                          child: Image.asset(
                        "assets/${filterGbr[index]}.png", // Mengambil gambar dari assets
                        fit: BoxFit.cover,
                      )),
                    );
                    // InkWell(
                    //   onTap: () {
                    //     // if (imgList[index] == "Dashboard") {
                    //     //   // Navigator.of(context).push(MaterialPageRoute(
                    //     //   //     builder: (context) =>
                    //     //   //         WellScreen(imgList[index])));
                    //     // } else if (imgList[index] == "Alur Sistem") {
                    //     //   Navigator.of(context).push(MaterialPageRoute(
                    //     //       builder: (context) => alurSistem()));
                    //     // } else if (imgList[index] ==
                    //     //     "Aplikasi\nTerintegrasi SSO") {
                    //     //   Navigator.of(context).push(MaterialPageRoute(
                    //     //       builder: (context) => apkSSOAdmin()));
                    //     // } else if (imgList[index] == "About SSO") {
                    //     //   Navigator.of(context).push(MaterialPageRoute(
                    //     //       builder: (context) => aboutSSO()));
                    //     // }
                    //   },
                    //   child: Container(
                    //     padding:
                    //         EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(20),
                    //       color: Color.fromARGB(255, 58, 143, 204),
                    //       // gradient: LinearGradient(
                    //       //   begin: Alignment.topRight,
                    //       //   end: Alignment.bottomLeft,
                    //       //   colors: [
                    //       //     Color.fromARGB(255, 0, 83, 192),
                    //       //     Colors.red,
                    //       //   ],
                    //       // ),
                    //     ),
                    //     child: Column(
                    //       children: [
                    //         Padding(
                    //           padding: EdgeInsets.all(10),
                    //           child: Image.asset(
                    //             "assets/${filterGbr[index]}.png",
                    //             width: 100,
                    //             height: 80,
                    //           ),
                    //         ),
                    //         SizedBox(
                    //           height: 10,
                    //         ),
                    //         Text(
                    //           filterMenu[index],
                    //           style: TextStyle(
                    //               fontSize: 18,
                    //               fontWeight: FontWeight.w500,
                    //               color: Colors.black),
                    //         ),
                    //         SizedBox(
                    //           height: 10,
                    //         ),
                    //         // Text("")
                    //       ],
                    //     ),
                    //   ),
                    // );
                  }))
        ]),
      ),
    );
  }
}
