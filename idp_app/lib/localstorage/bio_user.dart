import 'package:flutter/material.dart';

class GlobalData {
  static String myNama = ''; // Contoh variabel global
  static String myLevel = '';
  static String myNoInduk = '';
  static String myNoTelp = '';
  static String myEmail = '';
  static String myJurusan = '';
  static String myId = '';
  static String myToken = '';
  static String myExp = '';

  static void setMyExp(String value) {
    myExp = value;
  }

  static String getMyExp() {
    return myExp;
  }

  static void setMyToken(String value) {
    myToken = value;
  }

  static String getMyToken() {
    return myToken;
  }

  static void setMyNama(String value) {
    myNama = value;
  }

  static String getMyNama() {
    return myNama;
  }

  static void setMyLevel(String value) {
    myLevel = value;
  }

  static String getMyLevel() {
    return myLevel;
  }

  static void setMyNoInduk(String value) {
    myNoInduk = value;
  }

  static String getMyNoInduk() {
    return myNoInduk;
  }

  static void setMyNoTelp(String value) {
    myNoTelp = value;
  }

  static String getMyNoTelp() {
    return myNoTelp;
  }

  static void setMyEmail(String value) {
    myEmail = value;
  }

  static String getMyEmail() {
    return myEmail;
  }

  static void setMyJurusan(String value) {
    myJurusan = value;
  }

  static String getMyJurusan() {
    return myJurusan;
  }

  static void setMyId(String value) {
    myId = value;
  }

  static String getMyId() {
    return myId;
  }
}
