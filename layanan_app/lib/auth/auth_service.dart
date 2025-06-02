// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class AuthService {
//   final String idpUrl = 'http://0331kebonagung.ikc.co.id/api/account';

//   Future<List<String>> getAccounts(String userId) async {
//     final response = await http.get(Uri.parse('$idpUrl?id=$userId'));

//     if (response.statusCode == 200) {
//       List<dynamic> accountsJson = json.decode(response.body);
//       return accountsJson.map((account) => account.toString()).toList();
//     } else {
//       throw Exception('Failed to load accounts');
//     }
//   }
// }

// class User {
//   String id;
//   String name;
//   String email;

//   User({this.id, this.name, this.email});

//   factory User.createUser(Map<String, dynamic> object) {
//     return User(
//         id: object['id'].toString(),
//         name: object["name"],
//         email: object["email"]);
//   }

//   static Future<List<User>> getUsers(String idUser) async {
//     var apiResult = await http.get(
//         Uri.parse("http://0331kebonagung.ikc.co.id/api/account/?id=" + idUser));
//     var jsonObject = json.decode(apiResult.body);
//     List<dynamic> listUser = (jsonObject as Map<String, dynamic>)['data'];

//     List<User> users = [];
//     for (int i = 0; i < listUser.length; i++)
//       users.add(User.createUser(listUser[i]));

//     return users;
//   }
// }
