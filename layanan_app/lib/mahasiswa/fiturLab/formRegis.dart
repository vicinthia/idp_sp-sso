import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:layanan_app/api/link_sp.dart';

class formPraktikum extends StatefulWidget {
  final userNim;
  final userName;
  final userId;
  formPraktikum({this.userNim, this.userName, this.userId});
  @override
  _formPraktikumState createState() => _formPraktikumState();
}

class _formPraktikumState extends State<formPraktikum> {
  final TextEditingController _semesterController = TextEditingController();
  final TextEditingController _studentIdController = TextEditingController();
  String _selectedPraktikum;
  final List<String> _praktikumOptions = [
    'Algoritma Pemrograman',
    'Infrastruktur Teknologi Informasi',
    'Arsitektur Teknologi Informasi',
    'Pemrograman IoT',
  ];

  void _register() async {
    final name = widget.userName;
    final studentId = widget.userNim;
    final semester = _semesterController.text;

    if (name.isEmpty ||
        studentId.isEmpty ||
        _selectedPraktikum == null ||
        semester.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    addData();
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text('Successfully registered for $_selectedPraktikum!'),
    //   ),
    // );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchRegistrationData();
  }

  bool apiCallMade = false;
  DateTime tgl = DateTime.now();

  void addData() async {
    await Future.delayed(Duration(seconds: 1));

    var url = Uri.parse(AksesLabTi.UrlLabTi_Sp + "api/RegisPrak/create");

    // Kirim permintaan HTTP POST ke server
    var response = await http.post(
      url,
      body: {
        "user_id": widget.userId,
        "name": widget.userName,
        "no_induk": widget.userNim,
        "semester": _semesterController.text,
        "matkul_prak": "${_selectedPraktikum}",
        "tgl_regis": "$tgl",
        "ket_acc": "0",
      },
    );

    // Periksa status code dan respons dari server
    if (response.statusCode == 200) {
      // Jika statusnya OK (200), parse respons JSON
      var responseBody = jsonDecode(response.body);

      // Cek apakah status false dan pesan menunjukkan data sudah ada
      if (responseBody['status'] == false) {
        // Tampilkan pop-up alert jika data sudah ada
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: "Gagal Registrasi",
          text: responseBody['message'], // Pesan dari server
          confirmBtnText: "Ok",
        );
      } else {
        // Jika berhasil, tampilkan pop-up alert sukses
        CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          title: "Sukses Registrasi",
          text: "Sukses Registrasi Praktikum",
          confirmBtnText: "Ok",
        );
      }
    }

    // Mengubah state setelah API call selesai
    setState(() {
      apiCallMade = true;
    });
  }

  Future<void> fetchRegistrationData() async {
    try {
      final response = await http.get(Uri.parse(
          '${AksesLabTi.UrlLabTi_Sp}api/RegisPrak/?no_induk=${widget.userNim}'));

      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);

        // Cek apakah status true dan ada data
        if (decodedResponse['status'] == true &&
            decodedResponse['data'] != null &&
            decodedResponse['data'].isNotEmpty) {
          setState(() {
            registrationData = decodedResponse['data']; // Ambil seluruh data
            isLoading = false;
          });
        } else {
          setState(() {
            registrationData = []; // Tidak ada data
            isLoading = false;
          });
        }
      } else {
        setState(() {
          registrationData = []; // Respons gagal
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        registrationData = []; // Error
        isLoading = false;
      });
      print("Error fetching data: $e");
    }
  }

  List<dynamic> registrationData;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: Text(
          'Register for Praktikum',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 255, 221, 27),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Praktikum Registration',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  TextField(
                    enabled: false,
                    controller: TextEditingController(
                        text: widget.userName ?? 'Nama Lengkap'),
                    decoration: InputDecoration(
                      labelText: 'Nama Lengkap',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    enabled: false,
                    controller: TextEditingController(
                        text: widget.userNim ?? 'No Induk'),
                    decoration: InputDecoration(
                      labelText: 'NIM',
                      prefixIcon: Icon(Icons.school),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _semesterController,
                    decoration: InputDecoration(
                      labelText: 'Semester',
                      prefixIcon: Icon(Icons.book),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _selectedPraktikum,
                    decoration: InputDecoration(
                      labelText: 'Pilih Praktikum',
                      prefixIcon: Icon(Icons.list),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    items: _praktikumOptions.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedPraktikum = value;
                      });
                    },
                  ),
                  SizedBox(height: 24),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _register,
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 255, 221, 27),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Register',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  if (!isLoading &&
                      registrationData != null &&
                      registrationData.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: registrationData.map((data) {
                        return Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Data Registrasi",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8),
                                Text("Nama: ${data['name']}"),
                                Text("NIM: ${data['no_induk']}"),
                                Text("Semester: ${data['semester']}"),
                                Text("Praktikum: ${data['matkul_prak']}"),
                                Text(
                                    "Tanggal Registrasi: ${data['tgl_regis']}"),
                                SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    // Tambahkan aksi jika diperlukan
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          "${data['ket_acc']}" == "0"
                                              ? Colors.red
                                              : Colors.green),
                                  child: Text("${data['ket_acc']}" == "0"
                                      ? "Status : Belum ACC"
                                      : "Status : ACC"),
                                )
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  if (isLoading)
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
