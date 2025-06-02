import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:layanan_app/api/link.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  String id;
  String status;
  String refresh_token;

  User({
    this.id,
    this.status,
    this.refresh_token,
  });

  factory User.createUser(Map<String, dynamic> object) {
    return User(
        id: object['id'],
        status: object["status"],
        refresh_token: object["refresh_token"]);
  }

  static Future<List<User>> getUsers(String idUser) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String cekMyId = _prefs.getString('myId') ?? "";
    var apiResult = await http
        .get(Uri.parse(ApiConstants.baseUrl + "api/CrudUser/index/${idUser}"));
    var jsonObject = json.decode(apiResult.body);
    List<dynamic> listUser = (jsonObject as Map<String, dynamic>)['data'];

    List<User> users = [];
    for (int i = 0; i < listUser.length; i++)
      users.add(User.createUser(listUser[i]));

    return users;
  }
}
