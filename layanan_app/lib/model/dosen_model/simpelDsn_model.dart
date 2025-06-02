import 'package:flutter/material.dart';

class simpelDsnModel {
  String nama;
  String image;
  List<String> services;
  String ket;

  simpelDsnModel({this.image, this.nama, this.services, this.ket});
}

var menuItem = [
  simpelDsnModel(
      nama: "Panduan SIMPEL",
      image: "simpel_dsn.png",
      //services: [Service.regis],
      ket: "Lihat Panduan SIMPEL"),
  simpelDsnModel(
      nama: "Daftar Sebagai Peneliti",
      image: "df_penelitian_dsn.png",
      //services: [Service.krs],
      ket: "Form Pendaftaran Penelitian"),
  simpelDsnModel(
      nama: "Template Proposal Mandiri",
      image: "tempsimple_dsn.png",
      //services: [Service.smt_antara],
      ket: "Penyediaan Template Proposal Mandiri"),
  simpelDsnModel(
      nama: "Download",
      image: "dwsimple_dsn.png",
      //services: [Service.jadwal],
      ket: "Download SOP"),
];
