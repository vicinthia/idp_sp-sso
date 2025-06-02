import 'package:flutter/material.dart';

class koperasiKrynModel {
  String nama;
  String image;
  List<String> services;
  String ket;

  koperasiKrynModel({this.image, this.nama, this.services, this.ket});
}

var koperasiItem = [
  koperasiKrynModel(
      nama: "Beranda",
      image: "beranda.png",
      //services: [Service.regis],
      ket: "Informasi Umum Koperasi"),
  koperasiKrynModel(
      nama: "Profil",
      image: "profile.png",
      //services: [Service.krs],
      ket: "Profil Anggota"),
  koperasiKrynModel(
      nama: "Keuangan",
      image: "keuangan_kop.png",
      //services: [Service.smt_antara],
      ket: "Laporan Keuangan"),
  koperasiKrynModel(
      nama: "Peminjaman",
      image: "peminjaman.png",
      //services: [Service.jadwal],
      ket: "Formulir Peminjaman"),
  koperasiKrynModel(
      nama: "Simpan Pinjam",
      image: "pinjam.png",
      //services: [Service.learning],
      ket: "Informasi Simpanan Anggota"),
  koperasiKrynModel(
      nama: "Event dan Kegiatan",
      image: "event.png",
      //services: [Service.uas],
      ket: "Laporan Kegiatan"),
];
