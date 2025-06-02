// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:idp_app/component/widget/model/jml_online.dart';

// Future<List<jmlOnline>> fetchUserOnline() async {
//   final response =
//       await http.get(Uri.parse('http://0331kebonagung.ikc.co.id/api/cruduser'));

//   if (response.statusCode == 200) {
//     Map<String, dynamic> jsonResponse = json.decode(response.body);
//     List<dynamic> data = jsonResponse['data'];
//     return data.map((user) => jmlOnline.fromJson(user)).toList();
//   } else {
//     throw Exception('Failed to load data');
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:idp_app/component/widget/model/jml_online.dart';

Future<List<OnlineUserStatus>> fetchOnlineUserStatus() async {
  final response =
      await http.get(Uri.parse('http://0331kebonagung.ikc.co.id/api/cruduser'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => OnlineUserStatus.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load online user status');
  }
}
