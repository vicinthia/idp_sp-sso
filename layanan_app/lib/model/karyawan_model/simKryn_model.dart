import 'package:flutter/material.dart';

class simKrynModel {
  String nama;
  String image;
  List<String> services;
  String ket;

  simKrynModel({this.image, this.nama, this.services, this.ket});
}

var menuItem = [
  simKrynModel(
      nama: "Manajemen Data Karyawan",
      image: "regis.png",
      //services: [Service.regis],
      ket: "Profil Karyawan"),
  simKrynModel(
      nama: "Manajemen Cuti",
      image: "krs.png",
      //services: [Service.krs],
      ket: "Pengajuan Cuti dan Persetujuan Cuti"),
  simKrynModel(
      nama: "Jadwal Kerja",
      image: "krs_antara.png",
      //services: [Service.smt_antara],
      ket: "Penjadwalan"),
  simKrynModel(
      nama: "Komunikasi dan Pengumuman",
      image: "jadwal.png",
      //services: [Service.jadwal],
      ket: "Pengumuman Kampus"),
  simKrynModel(
      nama: "Akses Dokumen dan Arsip",
      image: "learning.png",
      //services: [Service.learning],
      ket: "Dokumentasi HR, Arsip Digital"),
  simKrynModel(
      nama: "Laporan",
      image: "uas.png",
      //services: [Service.uas],
      ket: "Menyajikan Data dan Statistik Karyawan"),
];
