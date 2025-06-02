import 'package:flutter/material.dart';

class simontaMhsModel {
  String nama;
  String image;
  List<String> services;
  String ket;

  simontaMhsModel({this.image, this.nama, this.services, this.ket});
}

var simontaItem = [
  simontaMhsModel(
      nama: "Panduan TA",
      image: "panduan_ta.png",
      //services: [Service.regis],
      ket: "Panduan Lengkap mengenai Tugas Akhir"),
  simontaMhsModel(
      nama: "Biodata",
      image: "bio_ta.png",
      //services: [Service.krs],
      ket: "Biodata Mahasiswa"),
  simontaMhsModel(
      nama: "Tawaran Judul",
      image: "jdl_ta.png",
      //services: [Service.smt_antara],
      ket: "Tawaran Judul Oleh Dosen"),
  simontaMhsModel(
      nama: "Mendaftar TA",
      image: "daftar_ta.png",
      //services: [Service.jadwal],
      ket: "Pendaftaran Tugas Akhir"),
  simontaMhsModel(
      nama: "Edit Data TA",
      image: "edit_ta.png",
      //services: [Service.learning],
      ket: "Edit Data TA Mahasiswa"),
  simontaMhsModel(
      nama: "Kirim Bukti Bayar",
      image: "byr_ta.png",
      //services: [Service.uas],
      ket: "Bukti Pembayaran TA"),
  simontaMhsModel(
      nama: "Jadwal Proposal",
      image: "sempro_ta.png",
      //services: [Service.khs],
      ket: "Jadwal Sidang Proposal Mahasiswa"),
  simontaMhsModel(
      nama: "Jadwal Sidang TA",
      image: "sidang_ta.png",
      //services: [Service.khs_antara],
      ket: "Jadwal Sidang TA Mahasiswa"),
  simontaMhsModel(
      nama: "Upload Abstrak TA",
      image: "abstrak_ta.png",
      //services: [Service.uang],
      ket: "Penguplod-an Abstrak TA"),
  simontaMhsModel(
      nama: "Upload Dokumen TA",
      image: "doc_ta.png",
      //services: [Service.wisuda],
      ket: "Pengupload-an Dokumen TA"),
  simontaMhsModel(
      nama: "Daftar Dosen",
      image: "dsn_ta.png",
      //services: [Service.point],
      ket: "List Daftar Dosen"),
  simontaMhsModel(
      nama: "Cetak Form",
      image: "form_ta.png",
      //services: [Service.point],
      ket: "Cetak Form TA"),
  simontaMhsModel(
      nama: "Ganti Judul",
      image: "gantijdl_ta.png",
      //services: [Service.point],
      ket: "Ganti Judul TA"),
  simontaMhsModel(
      nama: "Survey Kepuasan TA",
      image: "survey_ta.png",
      //services: [Service.point],
      ket: "Survey terhadap TA"),
];
