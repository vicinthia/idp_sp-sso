import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:layanan_app/api/link_sp.dart';

class daftarTA extends StatefulWidget {
  final userNim;
  final userName;
  final userId;
  final userJurusan;
  daftarTA({this.userNim, this.userName, this.userId, this.userJurusan});
  @override
  _daftarTAState createState() => _daftarTAState();
}

class _daftarTAState extends State<daftarTA> {
  final TextEditingController _semesterController = TextEditingController();
  final TextEditingController _judulController = TextEditingController();

  String _selectedDospem;
  // final List<String> _dospemOptions = [
  //   'R. Dimas Adityo, ST.,MT',
  //   'Arif Arizal, S.Kom.,M.Cs',
  //   'Mas Nurul Hamidah, S.ST.,MT ',
  //   'Fardanto Setyatama, S.T.,M.MT',
  // ];
  // final List<String> _dospemSipilOptions = [
  //   'Dosen Sipil 1',
  //   'Dosen Sipil 2',
  //   'Dosen Sipil 3',
  //   'Dosen Sipil 4',
  // ];
  final List<String> _dospemElektroOptions = [
    'Dosen Elektro 1',
    'Dosen Elektro 2',
    'Dosen Elektro 3',
    'Dosen Elektro 4',
  ];

  List _dospemOptions = List();
  List categoryItemList = List();

  Future<List> getAllCategory() async {
    final response = await http.get(Uri.parse(AksesSimonta.UrlSimonta_Sp +
        "api/DataSimonta/userDosen?level=Dosen&jurusan=${widget.userJurusan}"));
    var jsonData = json.decode(response.body)['data'];

    setState(() {
      _dospemOptions = jsonData;
    });
    print(_dospemOptions);
  }

  void _register() async {
    final name = widget.userName;
    final studentId = widget.userNim;
    final jurusan = widget.userJurusan;
    final semester = _semesterController.text;
    final ajuan = _judulController.text;

    if (name.isEmpty ||
        studentId.isEmpty ||
        jurusan.isEmpty ||
        ajuan.isEmpty ||
        _selectedDospem == null ||
        semester.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    addData();
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text('Successfully registered for $_selectedDospem!'),
    //   ),
    // );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchRegistrationData();
    getAllCategory();
  }

  bool apiCallMade = false;
  DateTime tgl = DateTime.now();

  void addData() async {
    // await Future.delayed(Duration(seconds: 1));

    var url = Uri.parse(AksesSimonta.UrlSimonta_Sp + "api/DaftarTA/create");

    // Kirim permintaan HTTP POST ke server
    var response = await http.post(
      url,
      body: {
        "user_id": widget.userId,
        "name": widget.userName,
        "no_induk": widget.userNim,
        "semester": _semesterController.text,
        "jurusan": widget.userJurusan,
        "judul": _judulController.text.toUpperCase(),
        "dospem1": "${_selectedDospem}",
        "tgl_ajuan": "$tgl",
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
          title: "Gagal Mendaftar",
          text: responseBody['message'], // Pesan dari server
          confirmBtnText: "Ok",
        );
      } else {
        // Jika berhasil, tampilkan pop-up alert sukses
        CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          title: "Sukses Daftar",
          text: "Sukses Daftar Tugas Akhir!",
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
          '${AksesSimonta.UrlSimonta_Sp}api/DaftarTA/?no_induk=${widget.userNim}'));

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
          'Pendaftaran TA',
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
                    'Pendaftaran Tugas Akhir',
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
                    enabled: false,
                    controller: TextEditingController(
                        text: widget.userJurusan ?? 'Jurusan'),
                    decoration: InputDecoration(
                      labelText: 'Jurusan',
                      prefixIcon: Icon(Icons.book),
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
                      prefixIcon: Icon(Icons.eject),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  TextField(
                    controller: _judulController,
                    decoration: InputDecoration(
                      labelText: 'Judul TA yang diajukan',
                      prefixIcon: Icon(Icons.dashboard),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    maxLines: 5,
                    minLines: 3,
                  ),
                  SizedBox(height: 16),
                  DropdownButtonFormField(
                    value: _selectedDospem,
                    decoration: InputDecoration(
                      labelText: 'Pilih Dospem 1',
                      prefixIcon: Icon(Icons.list),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),

                    // items: widget.userJurusan == "Teknik Informatika"
                    //     ? _dospemOptions.map((String option) {
                    //         return DropdownMenuItem<String>(
                    //           value: option,
                    //           child: Text(option),
                    //         );
                    //       }).toList()
                    //     : widget.userJurusan == "Teknik Sipil"
                    //         ? _dospemSipilOptions.map((String option) {
                    //             return DropdownMenuItem<String>(
                    //               value: option,
                    //               child: Text(option),
                    //             );
                    //           }).toList()
                    //         : _dospemElektroOptions.map((String option) {
                    //             return DropdownMenuItem<String>(
                    //               value: option,
                    //               child: Text(option),
                    //             );
                    //           }).toList(),
                    // onChanged: (value) {
                    //   setState(() {
                    //     _selectedDospem = value;
                    //   });
                    // },
                    items: _dospemOptions.map((category) {
                      return DropdownMenuItem(
                          value: category['name'],
                          child: Text(
                              category['name'] ?? "Dosen belum mendaftar"));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedDospem = value;
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
                        'Mendaftar TA',
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
                                  "Data Pendaftaran TA",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8),
                                Text("Nama: ${data['name']}"),
                                Text("NIM: ${data['no_induk']}"),
                                Text("Semester: ${data['semester']}"),
                                Text("Jurusan: ${data['jurusan']}"),
                                SizedBox(height: 8),
                                Text("Judul TA: ${data['judul']}"),
                                Text("Dosen Pembimbing 1: ${data['dospem1']}"),
                                Text("Tanggal Daftar: ${data['tgl_ajuan']}"),
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
                                      ? "Status : Ajuan judul TA belum ACC oleh Dospem 1"
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
