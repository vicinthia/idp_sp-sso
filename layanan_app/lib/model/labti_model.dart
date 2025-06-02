import 'package:flutter/material.dart';

class labTiModel {
  String nama;
  String image;
  List<String> services;
  String ket;

  labTiModel({this.image, this.nama, this.services, this.ket});
}

var menuLabTi = [
  labTiModel(
      nama: "Daftar Praktikum",
      image: "daftar_prakti.png",
      //services: [Service.regis],
      ket: "Pendaftaran Praktikum Teknik Informatika"),
  labTiModel(
      nama: "Bukti Pembayaran",
      image: "byr_prakti.png",
      //services: [Service.krs],
      ket: "Upload Bukti Pembayaran untuk Divalidasi"),
  labTiModel(
      nama: "Jadwal Praktikum",
      image: "jadwal_prakti.png",
      //services: [Service.smt_antara],
      ket: "Jadwal Kelas Praktikum"),
  labTiModel(
      nama: "Laporan Tugas Praktikum",
      image: "laporan_prakti.png",
      //services: [Service.jadwal],
      ket: "Sistem Pengumpulan Tugas Praktikum"),
  labTiModel(
      nama: "Penilaian Praktikum",
      image: "nilai_prakti.png",
      //services: [Service.learning],
      ket: "Cek Kartu Hasil Praktikum"),
];
