import 'package:flutter/material.dart';

class labTiDsnModel {
  String nama;
  String image;
  List<String> services;
  String ket;

  labTiDsnModel({this.image, this.nama, this.services, this.ket});
}

var menuLabTi = [
  labTiDsnModel(
      nama: "Daftar Praktikum",
      image: "daftar_prakti.png",
      //services: [Service.regis],
      ket: "Pendaftaran Praktikum Teknik Informatika"),
  labTiDsnModel(
      nama: "Bukti Pembayaran",
      image: "byr_prakti.png",
      //services: [Service.krs],
      ket: "Upload Bukti Pembayaran untuk Divalidasi"),
  labTiDsnModel(
      nama: "Jadwal Praktikum",
      image: "jadwal_prakti.png",
      //services: [Service.smt_antara],
      ket: "Jadwal Kelas Praktikum"),
  labTiDsnModel(
      nama: "Laporan Tugas Praktikum",
      image: "laporan_prakti.png",
      //services: [Service.jadwal],
      ket: "Sistem Pengumpulan Tugas Praktikum"),
  labTiDsnModel(
      nama: "Penilaian Praktikum",
      image: "nilai_prakti.png",
      //services: [Service.learning],
      ket: "Cek Kartu Hasil Praktikum"),
];
