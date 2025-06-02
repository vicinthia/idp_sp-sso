import 'dart:convert';
import 'package:http/http.dart' as http;

import '../api/link.dart';

//// MODEL /////

Future<Map<String, int>> fetchSumData() async {
  final response =
      await http.get(Uri.parse(ApiConstants.baseUrl + 'api/CrudUser/index'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    final List<dynamic> data = jsonResponse['data'];
    return countUsersByLevelAndJurusan(data);
  } else {
    throw Exception('Failed to load data');
  }
}

Map<String, int> countUsersByLevelAndJurusan(List<dynamic> data) {
  Map<String, int> userCounts = {
    'Mahasiswa_Teknik_Informatika': 0,
    'Mahasiswa_Teknik_Elektronika': 0,
    'Mahasiswa_Teknik_Sipil': 0,
    'Dosen_Teknik_Informatika': 0,
    'Dosen_Teknik_Elektronika': 0,
    'Dosen_Teknik_Sipil': 0,
    'Karyawan_Teknik_Informatika': 0,
    'Karyawan_Teknik_Elektronika': 0,
    'Karyawan_Teknik_Sipil': 0,
  };

  for (var item in data) {
    String level = item['level'];
    String jurusan = item['jurusan'];

    if (level == 'Mahasiswa' && jurusan == 'Teknik Informatika') {
      userCounts['Mahasiswa_Teknik_Informatika']++;
    } else if (level == 'Mahasiswa' && jurusan == 'Teknik Elektronika') {
      userCounts['Mahasiswa_Teknik_Elektronika']++;
    } else if (level == 'Mahasiswa' && jurusan == 'Teknik Sipil') {
      userCounts['Mahasiswa_Teknik_Sipil']++;
      // DOSEN //
    } else if (level == 'Dosen' && jurusan == 'Teknik Informatika') {
      userCounts['Dosen_Teknik_Informatika']++;
    } else if (level == 'Dosen' && jurusan == 'Teknik Elektronika') {
      userCounts['Dosen_Teknik_Elektronika']++;
    } else if (level == 'Dosen' && jurusan == 'Teknik Sipil') {
      userCounts['Dosen_Teknik_Sipil']++;
      // KARYAWAN //
    } else if (level == 'Karyawan' && jurusan == 'Teknik Informatika') {
      userCounts['Karyawan_Teknik_Informatika']++;
    } else if (level == 'Karyawan' && jurusan == 'Teknik Elektronika') {
      userCounts['Karyawan_Teknik_Elektronika']++;
    } else if (level == 'Karyawan' && jurusan == 'Teknik Sipil') {
      userCounts['Karyawan_Teknik_Sipil']++;
    }
  }

  return userCounts;
}
