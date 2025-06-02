import 'package:flutter/material.dart';

class simDsnModel {
  String nama;
  String image;
  List<String> services;
  String ket;

  simDsnModel({this.image, this.nama, this.services, this.ket});
}

var menuItem = [
  simDsnModel(
      nama: "Jadwal",
      image: "jadwal.png",
      //services: [Service.jadwal],
      ket: "Jadwal Perkuliahan"),
  simDsnModel(
      nama: "E-Learning",
      image: "learning.png",
      //services: [Service.learning],
      ket: "Kuliah Online"),
  simDsnModel(
      nama: "Nilai",
      image: "khs.png",
      //services: [Service.khs],
      ket: "Penilaian Mahasiswa"),

  simDsnModel(
      nama: "Validasi",
      image: "krs.png",
      //services: [Service.krs],
      ket: "Validasi Kartu Rencana Studi"),
  // simDsnModel(
  //     nama: "Semester Antara",
  //     image: "krs_antara.png",
  //     //services: [Service.smt_antara],
  //     ket: "KRS Semester Antara"),
  simDsnModel(
      nama: "TA",
      image: "uas.png",
      //services: [Service.uas],
      ket: "Tugas Akhir"),
  simDsnModel(
      nama: "Arsip",
      image: "khs_antara.png",
      //services: [Service.khs_antara],
      ket: "Arsip Dosen"),
  // simDsnModel(
  //     nama: "Keuangan",
  //     image: "keuangan.png",
  //     //services: [Service.uang],
  //     ket: "Informasi Pembayaran SPP"),
  // simDsnModel(
  //     nama: "Wisuda",
  //     image: "wisuda.png",
  //     //services: [Service.wisuda],
  //     ket: "Pendaftaran Wisuda"),
  simDsnModel(
      nama: "REKAP",
      image: "regis.png",
      //services: [Service.regis],
      ket: "Rekap Mengajar Dosen"),
  simDsnModel(
      nama: "Silabus",
      image: "point.png",
      //services: [Service.point],
      ket: "Silabus Matakuliah"),
];
