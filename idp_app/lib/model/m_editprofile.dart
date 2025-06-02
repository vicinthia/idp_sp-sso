import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:idp_app/localstorage/bio_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/link.dart';

class User {
  String id;
  String name;
  String no_induk;
  String no_telp;
  String user_email;

  User({
    this.id,
    this.name,
    this.no_induk,
    this.no_telp,
    this.user_email,
  });

  factory User.createUser(Map<String, dynamic> object) {
    return User(
      id: object['id'],
      name: object["name"],
      no_induk: object["no_induk"],
      no_telp: object["no_telp"],
      user_email: object["email"],
    );
  }

  static Future<List<User>> getUsers(String idUser) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String cekMyId = _prefs.getString('myId') ?? "";
    var apiResult = await http
        // .get(Uri.parse(ApiConstants.baseUrl + "api/cruduser/?id=${idUser}"));
        .get(Uri.parse(ApiConstants.baseUrl + "api/CrudUser/index/${idUser}"));
    var jsonObject = json.decode(apiResult.body);
    List<dynamic> listUser = (jsonObject as Map<String, dynamic>)['data'];

    List<User> users = [];
    for (int i = 0; i < listUser.length; i++)
      users.add(User.createUser(listUser[i]));

    return users;
  }
}
