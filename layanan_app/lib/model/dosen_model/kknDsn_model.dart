import 'package:flutter/material.dart';

class kknDsnModel {
  String nama;
  String image;
  List<String> services;
  String ket;

  kknDsnModel({this.image, this.nama, this.services, this.ket});
}

var menuKKN = [
  kknDsnModel(
      nama: "Panduan KKN",
      image: "panduan_kkn.png",
      //services: [Service.regis],
      ket: "Alur Pendaftaran KKN"),
  kknDsnModel(
      nama: "Daftar Peserta KKN",
      image: "peserta_kkn.png",
      //services: [Service.krs],
      ket: "Daftar Peserta KKN yang telah Divalidasi"),
  kknDsnModel(
      nama: "Informasi",
      image: "info_kkn.png",
      //services: [Service.smt_antara],
      ket: "Daftar & Nilai Kelompok"),
  kknDsnModel(
      nama: "Daftar Sebagai Peserta",
      image: "regispeserta_kkn.png",
      //services: [Service.jadwal],
      ket: "Pendaftaran Peserta KKN"),
  kknDsnModel(
      nama: "Daftar Sebagai Narasumber",
      image: "regisnasum_kkn.png",
      //services: [Service.learning],
      ket: "Pendaftaran Narasumber KKN"),
  kknDsnModel(
      nama: "Daftar Sebagai DPL",
      image: "regisdpl_kkn.png",
      //services: [Service.uas],
      ket: "Pendaftaran DPL KKN"),
];
