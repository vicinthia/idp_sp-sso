import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:layanan_app/api/link_sp.dart';

class regisSimpel extends StatefulWidget {
  final userNidn;
  final userName;
  final userId;
  final userNoTelp;
  final userEmail;
  regisSimpel(
      {this.userNidn,
      this.userName,
      this.userId,
      this.userNoTelp,
      this.userEmail});
  @override
  _regisSimpelState createState() => _regisSimpelState();
}

class _regisSimpelState extends State<regisSimpel> {
  final TextEditingController _idSintaController = TextEditingController();
  final TextEditingController _idScoopusController = TextEditingController();
  final TextEditingController _idGarudaController = TextEditingController();
  final TextEditingController _idGoogleSchoolarController =
      TextEditingController();
  final TextEditingController _noTelpController = TextEditingController();
  String _selectedPraktikum;
  final List<String> _praktikumOptions = [
    'Hukum',
    'Administrasi Publik',
    'Komunikasi',
    'Manajemen',
    'Akuntansi',
    'Ekonomi Pembangunan',
    'Elektro',
    'Informatika',
    'Sipil',
  ];

  void _register() async {
    final name = widget.userName;
    final studentId = widget.userNidn;
    final telp = _noTelpController.text;
    final email = widget.userNoTelp;
    final sinta = _idSintaController.text;
    final scoopus = _idScoopusController.text;
    final garuda = _idGarudaController.text;
    final google = _idGoogleSchoolarController.text;

    if (name.isEmpty ||
        studentId.isEmpty ||
        _selectedPraktikum == null ||
        sinta.isEmpty ||
        scoopus.isEmpty ||
        garuda.isEmpty ||
        google.isEmpty) {
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

    var url = Uri.parse(AksesSimpel.UrlSimpel_Sp + "api/RegisSimpel/create");

    // Kirim permintaan HTTP POST ke server
    var response = await http.post(
      url,
      body: {
        "user_id": widget.userId,
        "name": widget.userName,
        "nidn": widget.userNidn,
        "fakultas": "${_selectedPraktikum}",
        "email": widget.userEmail,
        "no_hp": _noTelpController.text,
        "id_sinta": _idSintaController.text,
        "id_scoopus": _idScoopusController.text,
        "id_garuda": _idGarudaController.text,
        "id_googleschol": _idGoogleSchoolarController.text,
        "tgl_regis": "$tgl",
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
          '${AksesSimpel.UrlSimpel_Sp}api/RegisSimpel/?nidn=${widget.userNidn}'));

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
          'Register Sistem Informasi Penelitian Pengabdian',
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
                    'SIMPEL Registrasi',
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
                        text: widget.userNidn ?? 'No Induk'),
                    decoration: InputDecoration(
                      labelText: 'NIDN',
                      prefixIcon: Icon(Icons.school),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
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
                  DropdownButtonFormField<String>(
                    value: _selectedPraktikum,
                    decoration: InputDecoration(
                      labelText: 'Pilih Falkutas',
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
                  SizedBox(height: 16),
                  TextField(
                    enabled: false,
                    controller: TextEditingController(
                        text: widget.userEmail ?? 'Email'),
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _noTelpController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'No HP',
                      prefixIcon: Icon(Icons.phone),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _idSintaController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'ID SINTA',
                      prefixIcon: Icon(Icons.numbers),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _idScoopusController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'ID SCOOPUS',
                      prefixIcon: Icon(Icons.numbers_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _idGarudaController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'ID GARUDA',
                      prefixIcon: Icon(Icons.numbers_sharp),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _idGoogleSchoolarController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'ID GOOGLE SCHOOLAR',
                      prefixIcon: Icon(Icons.numbers),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
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
                                Text("NIDN: ${data['nidn']}"),
                                Text("Fakultas: ${data['fakultas']}"),
                                Text("Email: ${data['email']}"),
                                Text("No. HP: ${data['no_hp']}"),
                                SizedBox(height: 10),
                                Text("ID SINTA: ${data['id_sinta']}"),
                                Text("ID SCOOPUS: ${data['id_scoopus']}"),
                                Text("ID GARUDA: ${data['id_garuda']}"),
                                Text(
                                    "ID GOOGLE SCHOOLAR: ${data['id_gooleschol']}"),
                                SizedBox(height: 10),
                                Text(
                                    "Tanggal Registrasi: ${data['tgl_regis']}"),
                                SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    // Tambahkan aksi jika diperlukan
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green),
                                  child: Text(
                                      "Status : Berhasil Registrasi SIMPEL!"),
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
