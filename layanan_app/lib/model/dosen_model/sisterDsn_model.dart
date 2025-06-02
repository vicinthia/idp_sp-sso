import 'package:flutter/material.dart';

class sisterDsnModel {
  String nama;
  String image;
  List<String> services;
  String ket;

  sisterDsnModel({this.image, this.nama, this.services, this.ket});
}

var menuItem = [
  sisterDsnModel(
      nama: "Profil Dosen",
      image: "profile_sister.png",
      //services: [Service.regis],
      ket: "Informasi Data Pribadi,Riwayat Pendidikan dan Jabatan"),
  sisterDsnModel(
      nama: "Kegiatan Mengajar",
      image: "mengajar_sister.png",
      //services: [Service.krs],
      ket: "Jadwal dan Riwayat Mengajar"),
  sisterDsnModel(
      nama: "Penelitian dan Publikasi",
      image: "publikasi_sister.png",
      //services: [Service.smt_antara],
      ket: "Informasi Penelitian dan Publikasi"),
  sisterDsnModel(
      nama: "Pengabdian Masyarakat",
      image: "pengabdian_sister.png",
      //services: [Service.jadwal],
      ket: "Kegiatan Pengabdian"),
  sisterDsnModel(
      nama: "Laporan dan Rekapitulasi",
      image: "laporan_sister.png",
      //services: [Service.jadwal],
      ket: "Laporan Kinerja Dosen dan Rekap Kegiatan Dosen"),
];
