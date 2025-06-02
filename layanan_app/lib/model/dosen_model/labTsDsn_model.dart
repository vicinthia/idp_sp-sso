import 'package:flutter/material.dart';

class labTsDsnModel {
  String nama;
  String image;
  List<String> services;
  String ket;

  labTsDsnModel({this.image, this.nama, this.services, this.ket});
}

var menuLabTs = [
  labTsDsnModel(
      nama: "Daftar Praktikum",
      image: "daftar_prakts.png",
      //services: [Service.regis],
      ket: "Pendaftaran Praktikum Teknik Sipil"),
  labTsDsnModel(
      nama: "Bukti Pembayaran",
      image: "byr_prakti.png",
      //services: [Service.krs],
      ket: "Upload Bukti Pembayaran untuk Divalidasi"),
  labTsDsnModel(
      nama: "Jadwal Praktikum",
      image: "jadwal_prakts.png",
      //services: [Service.smt_antara],
      ket: "Jadwal Kelas Praktikum"),
  labTsDsnModel(
      nama: "Laporan Tugas Praktikum",
      image: "laporan_prakti.png",
      //services: [Service.jadwal],
      ket: "Sistem Pengumpulan Tugas Praktikum"),
  labTsDsnModel(
      nama: "Penilaian Praktikum",
      image: "nilai_prakti.png",
      //services: [Service.learning],
      ket: "Cek Kartu Hasil Praktikum"),
];
