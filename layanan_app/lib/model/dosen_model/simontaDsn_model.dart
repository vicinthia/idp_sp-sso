import 'package:flutter/material.dart';

class simontaDsnModel {
  String nama;
  String image;
  List<String> services;
  String ket;

  simontaDsnModel({this.image, this.nama, this.services, this.ket});
}

var simontaItem = [
  // simontaDsnModel(
  //     nama: "Panduan TA",
  //     image: "panduan_ta.png",
  //     //services: [Service.regis],
  //     ket: "Panduan Lengkap mengenai Tugas Akhir"),
  // simontaDsnModel(
  //     nama: "Biodata",
  //     image: "bio_ta.png",
  //     //services: [Service.krs],
  //     ket: "Biodata Mahasiswa"),
  simontaDsnModel(
      nama: "Tawaran Judul",
      image: "jdl_ta.png",
      //services: [Service.smt_antara],
      ket: "Tawaran Judul Oleh Dosen"),
  simontaDsnModel(
      nama: "Bimbingan TA",
      image: "daftar_ta.png",
      //services: [Service.jadwal],
      ket: "Bimbingan Tugas Akhir"),
  // simontaDsnModel(
  //     nama: "Edit Data TA",
  //     image: "edit_ta.png",
  //     //services: [Service.learning],
  //     ket: "Edit Data TA Mahasiswa"),
  // simontaDsnModel(
  //     nama: "Kirim Bukti Bayar",
  //     image: "byr_ta.png",
  //     //services: [Service.uas],
  //     ket: "Bukti Pembayaran TA"),
  simontaDsnModel(
      nama: "Jadwal Proposal",
      image: "sempro_ta.png",
      //services: [Service.khs],
      ket: "Jadwal Sidang Proposal Mahasiswa"),
  simontaDsnModel(
      nama: "Jadwal Sidang TA",
      image: "sidang_ta.png",
      //services: [Service.khs_antara],
      ket: "Jadwal Sidang TA Mahasiswa"),
  // simontaDsnModel(
  //     nama: "Upload Abstrak TA",
  //     image: "abstrak_ta.png",
  //     //services: [Service.uang],
  //     ket: "Penguplod-an Abstrak TA"),
  // simontaDsnModel(
  //     nama: "Upload Dokumen TA",
  //     image: "doc_ta.png",
  //     //services: [Service.wisuda],
  //     ket: "Pengupload-an Dokumen TA"),
  // simontaDsnModel(
  //     nama: "Daftar Dosen",
  //     image: "dsn_ta.png",
  //     //services: [Service.point],
  //     ket: "List Daftar Dosen"),
  // simontaDsnModel(
  //     nama: "Cetak Form",
  //     image: "form_ta.png",
  //     //services: [Service.point],
  //     ket: "Cetak Form TA"),
  // simontaDsnModel(
  //     nama: "Ganti Judul",
  //     image: "gantijdl_ta.png",
  //     //services: [Service.point],
  //     ket: "Ganti Judul TA"),
  // simontaDsnModel(
  //     nama: "Survey Kepuasan TA",
  //     image: "survey_ta.png",
  //     //services: [Service.point],
  //     ket: "Survey terhadap TA"),
];
