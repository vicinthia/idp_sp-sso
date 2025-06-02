import 'package:flutter/material.dart';
import 'package:idp_app/localstorage/bio_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../api/link.dart';

class apkSSO extends StatefulWidget {
  final no_induk;

  apkSSO({this.no_induk});
  @override
  _apkSSOState createState() => _apkSSOState();
}

class _apkSSOState extends State<apkSSO> {
  DateTime now = DateTime.now();
  String Semester;
  String ThnMasuk;
  String ThnMasukMhs;
  String MySemester;

  List<String> filterMenu = [];
  List<String> filterGbr = [];

  SharedPreferences _prefs;
  String _savedNama = "";
  String _savedLevel = "";
  String _savedNoInduk = "";
  String _savedNoTelp = "";
  String _savedEmail = "";
  String _savedJurusan = "";
  String _savedId = "";
  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();

    _savedNama = _prefs.getString('myNama') ?? "";
    _savedLevel = _prefs.getString('myLevel') ?? "";
    _savedNoInduk = _prefs.getString('myNoInduk') ?? "";
    _savedNoTelp = _prefs.getString('myNoTelp') ?? "";
    _savedEmail = _prefs.getString('myEmail') ?? "";
    _savedJurusan = _prefs.getString('myJurusan') ?? "";
    _savedId = _prefs.getString('myId') ?? "";

    setState(() {});
  }

  String Induk = "";
  String ind;
  int semesterBerjalan;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initSharedPreferences();

    int year = now.year;
    ThnMasuk = year.toString();
    //Tahun Sekarang
    ThnMasukMhs = ThnMasuk.substring(ThnMasuk.length - 2);
    Induk = widget.no_induk.substring(0, 2);

    String ind = "okeh ${_savedNoInduk}";
    var Var;

    setState(() {
      Semester =
          "${int.tryParse(ThnMasukMhs) - int.tryParse(widget.no_induk.substring(0, 2))}";
      MySemester = "${int.tryParse(Semester) * 2}";
      semesterBerjalan = int.tryParse(MySemester);
      if (DateTime.now().month > 6) {
        semesterBerjalan += 1;
      }
    });

    print("Masa" + Induk);
    print(Var);

    print(MySemester);
    apk();
  }

  Future<void> apk() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = _savedId; // Ambil user_id dari SharedPreferences

    if (userId != null) {
      // Langkah 1: Ambil data name_client, client_id, dan secret_id dari REST API berdasarkan user_id
      List<Map<String, String>> clientDataList =
          await getClientDataFromAPI(userId);

      if (clientDataList != null && clientDataList.isNotEmpty) {
        // Mengisi filterMenu dengan name_client dan filterGbr dengan gambar yang sesuai
        setState(() {
          filterMenu = clientDataList
              .map((clientData) => clientData['name_client'])
              .toList();
          filterGbr =
              clientDataList.map((clientData) => clientData['image']).toList();
        });

        print('filterMenu: $filterMenu'); // Debug statement
        print('filterGbr: $filterGbr'); // Debug statement
      } else {
        print('No clients found for userId: $userId');
        setState(() {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Pendaftaran Tidak Ditemukan"),
                content: Text(
                    "Anda belum login Aplikasi Penyedia Layanan!\nsegera login dahulu!"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Tutup alert dialog
                    },
                    child: Text("OK"),
                  ),
                ],
              );
            },
          );
        });
      }
    } else {
      print('User ID not found');
    }
  }

  // Fungsi untuk mengambil data dari REST API
  Future<List<Map<String, String>>> getClientDataFromAPI(String userId) async {
    final url = Uri.parse(
        ApiConstants.baseUrl + 'api/getClient/GetListClient?user_id=$userId');

    // Melakukan GET request ke REST API
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      // Jika permintaan berhasil, decode respons JSON
      final Map<String, dynamic> data = jsonDecode(response.body);

      // Mengakses daftar dari objek JSON
      final List<dynamic> clients = data['data'];

      // Konversi data ke List<Map<String, String>>
      return clients.map((item) {
        return {
          'name_client': item['name_client']?.toString() ?? '',
          'client_id': item['client_id']?.toString() ?? '',
          'secret_id': item['secret_id']?.toString() ?? '',
          'image': item['image']?.toString() ?? ''
        };
      }).toList();
    } else {
      // Jika gagal, kembalikan nilai kosong
      print('Failed to load client data');
      return [];
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
                    "Pada Semester : ${semesterBerjalan} / ${_savedJurusan} / ${_savedNoInduk}",
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
                    // if (filterGbr[index] == "sim") {
                    //   print("touch");
                    // }
                  },
                  child: GridTile(
                      child: Image.asset(
                    "assets/${filterGbr[index]}.png", // Mengambil gambar dari assets
                    fit: BoxFit.cover,
                  )),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
