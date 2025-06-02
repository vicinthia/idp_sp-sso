import 'package:flutter/material.dart';

class labTeModel {
  String nama;
  String image;
  List<String> services;
  String ket;

  labTeModel({this.image, this.nama, this.services, this.ket});
}

var menuItem = [
  labTeModel(
      nama: "Daftar Praktikum",
      image: "daftar_prakte.png",
      //services: [Service.regis],
      ket: "Pendaftaran Praktikum Teknik Elektronika"),
  labTeModel(
      nama: "Bukti Pembayaran",
      image: "byr_prakti.png",
      //services: [Service.krs],
      ket: "Upload Bukti Pembayaran untuk Divalidasi"),
  labTeModel(
      nama: "Jadwal Praktikum",
      image: "jadwal_prakte.png",
      //services: [Service.smt_antara],
      ket: "Jadwal Kelas Praktikum"),
  labTeModel(
      nama: "Laporan Tugas Praktikum",
      image: "laporan_prakti.png",
      //services: [Service.jadwal],
      ket: "Sistem Pengumpulan Tugas Praktikum"),
  labTeModel(
      nama: "Penilaian Praktikum",
      image: "nilai_prakti.png",
      //services: [Service.learning],
      ket: "Cek Kartu Hasil Praktikum"),
];
