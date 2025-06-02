import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../api/link_sp.dart';

class listBimbingan extends StatefulWidget {
  final userName;
  listBimbingan({this.userName});
  @override
  _listBimbinganState createState() => _listBimbinganState();
}

class _listBimbinganState extends State<listBimbingan> {
  // final ApiService apiService = ApiService();
  Future<List<dynamic>> futureData;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  // final String apiUrl =
  //   AksesSimonta.UrlSimonta_Sp + "api/DaftarTA/anakBimbingan?dospem1=${widget.userName}";

  Future<List> fetchData() async {
    final response = await http.get(Uri.parse(AksesSimonta.UrlSimonta_Sp +
        "api/DaftarTA/anakBimbingan?dospem1=${widget.userName}"));

    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to load data');
    }
  }

  // void editData() {
  //   var url = Uri.parse(
  //       AksesSimonta.UrlSimonta_Sp + "api/DaftarTA/${widget.userName}");
  //   http.put(url, body: {
  //     "id": widget.list[widget.index]["id"],
  //     "kamar": _menuController.text,
  //     "harga": _hargaController.text,
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bimbingan Tugas Akhir',
            style: TextStyle(color: Colors.black)),
        backgroundColor: Color.fromARGB(255, 255, 221, 27),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchData(),
        builder: (context, snapshot) {
          // Jika sedang memuat data
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          // Jika ada error
          else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          // Jika data kosong
          else if (!snapshot.hasData || snapshot.data.isEmpty) {
            return Center(child: Text('Tidak ada data tersedia'));
          }

          // Jika data berhasil dimuat
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              final item = snapshot.data[index];

              return Card(
                margin: EdgeInsets.all(10),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Gambar kecil (placeholder)
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage('assets/TA.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      // Kolom teks
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Mahasiswa : " + item['name'] ??
                                  'No Title', // Ambil title dari API
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              item['no_induk'] ??
                                  'No Data', // Ambil deskripsi dari API
                              style: TextStyle(
                                  color: Colors.grey[700], fontSize: 16),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Semester : " + item['semester'] ??
                                  'No Data', // Ambil deskripsi dari API
                              style: TextStyle(
                                  color: Colors.grey[700], fontSize: 16),
                            ),
                            SizedBox(height: 15),
                            Text(
                              "Judul TA : \n" + item['judul'] ??
                                  'No Data', // Ambil deskripsi dari API
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 15),
                            Text(
                              "Tgl Pengajuan Judul : " + item['tgl_ajuan'] ??
                                  'No Data', // Ambil deskripsi dari API
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            SizedBox(height: 15),
                            SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () async {
                                // Tambahkan aksi jika diperlukan
                                void editData() {
                                  var url = Uri.parse(
                                      AksesSimonta.UrlSimonta_Sp +
                                          "api/DaftarTA/update/${item['id']}");
                                  http.put(url, body: {
                                    "id": item['id'],
                                    "ket_acc": "1",
                                  });
                                }

                                await editData();
                                await CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.success,
                                  title: "Sukses ACC",
                                  text: "Sukses ACC Tugas Akhir!",
                                  confirmBtnText: "Ok",
                                );
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (BuildContext context) =>
                                //         FormKamar()));
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: "${item['ket_acc']}" == "0"
                                      ? Colors.red
                                      : Colors.green),
                              child: Text("${item['ket_acc']}" == "0"
                                  ? "ACC Judul Sekarang"
                                  : "Sudah ACC"),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// class ApiService {
//   final String apiUrl =
//       AksesSimonta.UrlSimonta_Sp + "api/DaftarTA/anakBimbingan?dospem1=${widget.}";

//   Future<List<dynamic>> fetchData() async {
//     final response = await http.get(Uri.parse(apiUrl));

//     if (response.statusCode == 200) {
//       return json.decode(response.body);
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }
// }
