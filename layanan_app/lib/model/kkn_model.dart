import 'package:flutter/material.dart';

class kknModel {
  String nama;
  String image;
  List<String> services;
  String ket;

  kknModel({this.image, this.nama, this.services, this.ket});
}

var menuKKN = [
  kknModel(
      nama: "Panduan KKN",
      image: "panduan_kkn.png",
      //services: [Service.regis],
      ket: "Alur Pendaftaran KKN"),
  kknModel(
      nama: "Daftar Peserta KKN",
      image: "peserta_kkn.png",
      //services: [Service.krs],
      ket: "Daftar Peserta KKN yang telah Divalidasi"),
  kknModel(
      nama: "Informasi",
      image: "info_kkn.png",
      //services: [Service.smt_antara],
      ket: "Daftar & Nilai Kelompok"),
  kknModel(
      nama: "Daftar Sebagai Peserta",
      image: "regispeserta_kkn.png",
      //services: [Service.jadwal],
      ket: "Pendaftaran Peserta KKN"),
  kknModel(
      nama: "Daftar Sebagai Narasumber",
      image: "regisnasum_kkn.png",
      //services: [Service.learning],
      ket: "Pendaftaran Narasumber KKN"),
  kknModel(
      nama: "Daftar Sebagai DPL",
      image: "regisdpl_kkn.png",
      //services: [Service.uas],
      ket: "Pendaftaran DPL KKN"),
];
