import 'package:flutter/material.dart';

class simMhsModel {
  String nama;
  String image;
  List<String> services;
  String ket;

  simMhsModel({this.image, this.nama, this.services, this.ket});
}

var menuItem = [
  simMhsModel(
      nama: "Registrasi Online",
      image: "regis.png",
      //services: [Service.regis],
      ket: "Proses Registrasi Online"),
  simMhsModel(
      nama: "KRS",
      image: "krs.png",
      //services: [Service.krs],
      ket: "Kartu Rencana Studi"),
  simMhsModel(
      nama: "Semester Antara",
      image: "krs_antara.png",
      //services: [Service.smt_antara],
      ket: "KRS Semester Antara"),
  simMhsModel(
      nama: "Jadwal",
      image: "jadwal.png",
      //services: [Service.jadwal],
      ket: "Jadwal Perkuliahan"),
  simMhsModel(
      nama: "E-Learning",
      image: "learning.png",
      //services: [Service.learning],
      ket: "Kuliah Online"),
  simMhsModel(
      nama: "UAS",
      image: "uas.png",
      //services: [Service.uas],
      ket: "Ujian Akhir Semester"),
  simMhsModel(
      nama: "KHS",
      image: "khs.png",
      //services: [Service.khs],
      ket: "Kartu Hasil Studi"),
  simMhsModel(
      nama: "KHS Antara",
      image: "khs_antara.png",
      //services: [Service.khs_antara],
      ket: "Kartu Hasil Studi Antara"),
  simMhsModel(
      nama: "Keuangan",
      image: "keuangan.png",
      //services: [Service.uang],
      ket: "Informasi Pembayaran SPP"),
  simMhsModel(
      nama: "Wisuda",
      image: "wisuda.png",
      //services: [Service.wisuda],
      ket: "Pendaftaran Wisuda"),
  simMhsModel(
      nama: "Point",
      image: "point.png",
      //services: [Service.point],
      ket: "Point Kegiatan Mahasiswa"),
];
