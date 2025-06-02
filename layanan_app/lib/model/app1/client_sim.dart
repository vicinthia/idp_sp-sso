import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../api/link_sp.dart';

class UserSIM with ChangeNotifier {
  String userName;
  String userEmail;
  String userLevel;
  String userJurusan;
  String userInduk;
  // String user;
  bool isLoading = true;
  String errorMessage;

  Future<void> validateToken(String token) async {
    final url =
        Uri.parse(AksesSIM.UrlSim_Sp + 'api/ValidateSP/validate_token/');

    try {
      print('Token: $token');

      final response = await http.read(url, headers: {"Authorization": token});

      print('API Response: $response');

      final Map<String, dynamic> payload = json.decode(response);

      // Access the nested 'data' inside 'data'
      if (payload.containsKey('data') && payload['data'].containsKey('data')) {
        final userData = payload['data']['data'];

        userName = userData['name']; // Access name
        userEmail = userData['email'];
        userLevel = userData['level'];
        userJurusan = userData['jurusan'];
        userInduk = userData['no_induk'];
        isLoading = false;
        notifyListeners();
      } else {
        throw Exception('Data not found in response');
      }
    } catch (error) {
      errorMessage = error.toString();
      isLoading = false;
      notifyListeners();
      print('Error: $errorMessage');
    }
  }
}
