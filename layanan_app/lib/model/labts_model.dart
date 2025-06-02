import 'package:flutter/material.dart';

class labTsModel {
  String nama;
  String image;
  List<String> services;
  String ket;

  labTsModel({this.image, this.nama, this.services, this.ket});
}

var menuLabTs = [
  labTsModel(
      nama: "Daftar Praktikum",
      image: "daftar_prakts.png",
      //services: [Service.regis],
      ket: "Pendaftaran Praktikum Teknik Sipil"),
  labTsModel(
      nama: "Bukti Pembayaran",
      image: "byr_prakti.png",
      //services: [Service.krs],
      ket: "Upload Bukti Pembayaran untuk Divalidasi"),
  labTsModel(
      nama: "Jadwal Praktikum",
      image: "jadwal_prakts.png",
      //services: [Service.smt_antara],
      ket: "Jadwal Kelas Praktikum"),
  labTsModel(
      nama: "Laporan Tugas Praktikum",
      image: "laporan_prakti.png",
      //services: [Service.jadwal],
      ket: "Sistem Pengumpulan Tugas Praktikum"),
  labTsModel(
      nama: "Penilaian Praktikum",
      image: "nilai_prakti.png",
      //services: [Service.learning],
      ket: "Cek Kartu Hasil Praktikum"),
];
