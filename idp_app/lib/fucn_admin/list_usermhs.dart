import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'package:idp_app/component/brndAdminMhs.dart';
import 'package:idp_app/fucn_admin/edit_userMhs.dart';
import 'package:idp_app/model/m_editprofile.dart';

import '../api/link.dart';

class adminMhs extends StatefulWidget {
  @override
  State<adminMhs> createState() => _adminMhsState();
}

class _adminMhsState extends State<adminMhs> {
  final List<Map<String, String>> users = [
    {"name": "John Doe", "email": "john.doe@example.com"},
    {"name": "Jane Smith", "email": "jane.smith@example.com"},
  ];

  String filter;

  TextEditingController searchController = TextEditingController();

  Future<List> getData() async {
    final response = await http.get(Uri.parse(
        ApiConstants.baseUrl + "api/func_admin/ListLevel/index/Mahasiswa"));
    return json.decode(response.body)['data'];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    searchController.addListener(() {
      setState(() {
        filter = searchController.text;
      });
    });
  }

  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 83, 192),
        title: Container(
          decoration: BoxDecoration(
              color: Colors.blue.shade200,
              borderRadius: BorderRadius.circular(30)),
          child: TextField(
            onChanged: (value) {},
            controller: searchController,
            decoration: InputDecoration(
                border: InputBorder.none,
                errorBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.all(15),
                hintText: "Cari User by NIM"),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => brndAdminMhs()));
          },
        ),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, i) {
                    return filter == null || filter == ""
                        ? Slidable(
                            key: ValueKey(snapshot.data[i]),
                            endActionPane: ActionPane(
                              motion: ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) =>
                                      _editUser(snapshot.data[i]['id']),
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                  icon: Icons.edit,
                                  label: 'Edit',
                                ),
                                SlidableAction(
                                  onPressed: (context) =>
                                      _deleteUser(snapshot.data[i]['id']),
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                ),
                              ],
                            ),
                            child: ListTile(
                              title: Text(
                                "Username : " + snapshot.data[i]['email'],
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              subtitle:
                                  Text("NIM :" + snapshot.data[i]['no_induk'],
                                      style: TextStyle(
                                        fontSize: 16,
                                      )),
                              trailing: Icon(Icons.arrow_back),
                            ),
                          )
                        : '${snapshot.data[i]['no_induk']}'
                                .toLowerCase()
                                .contains(filter.toLowerCase())
                            ? Slidable(
                                key: ValueKey(snapshot.data[i]),
                                endActionPane: ActionPane(
                                  motion: ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) =>
                                          _editUser(snapshot.data[i]['id']),
                                      backgroundColor: Colors.blue,
                                      foregroundColor: Colors.white,
                                      icon: Icons.edit,
                                      label: 'Edit',
                                    ),
                                    SlidableAction(
                                      onPressed: (context) =>
                                          _deleteUser(snapshot.data[i]['id']),
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: 'Delete',
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                  title: Text(
                                      "Username :" + snapshot.data[i]['email'],
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  subtitle: Text(
                                      "NIM :" + snapshot.data[i]['no_induk'],
                                      style: TextStyle(
                                        fontSize: 16,
                                      )),
                                  trailing: Icon(Icons.arrow_back),
                                ),
                              )
                            : new Container();
                  })
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }

  //  ListView.builder(
  void _editUser(user) {
    String namaUser;
    String noIndukUser;
    String noTelpUser;
    String emailUser;
    String idUser;

    User.getUsers(user).then((users) {
      namaUser = "";
      noIndukUser = "";
      noTelpUser = "";
      emailUser = "";
      idUser = "";
      for (int i = 0; i < users.length; i++) idUser = idUser + users[i].id;
      for (int i = 0; i < users.length; i++)
        namaUser = namaUser + users[i].name;
      for (int i = 0; i < users.length; i++)
        noIndukUser = noIndukUser + users[i].no_induk;
      for (int i = 0; i < users.length; i++)
        noTelpUser = noTelpUser + users[i].no_telp;
      for (int i = 0; i < users.length; i++)
        emailUser = emailUser + users[i].user_email;

      setState(() {
        // ppnInt = int.tryParse(m_Laporan.sum * 10);
        // ppndob = ppnInt / 10;
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => editUserMhs(
                    nameController: namaUser,
                    noIndukController: noIndukUser,
                    noTelpController: noTelpUser,
                    emailController: emailUser,
                    id: idUser,
                  )),
        );
      });
    });
  }

  void _deleteUser(user) async {
    // Logika untuk menghapus user
    await CoolAlert.show(
        context: context,
        type: CoolAlertType.confirm,
        text: "Apakah yakin hapus user ?",
        confirmBtnText: 'Yes',
        cancelBtnText: "Cancel",
        onConfirmBtnTap: () async {
          var url = Uri.parse(
              ApiConstants.baseUrl + "api/func_admin/ListLevel/index/${user}");
          http.delete(url, body: {"id": user});
          setState(() {});

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => adminMhs()),
          );
        },
        onCancelBtnTap: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => adminMhs()),
          );
        });
  }

  // void _addUser(BuildContext context) {
  //   // Navigator.push(
  //   //   context,
  //   //   MaterialPageRoute(builder: (context) => UserDetailScreen()),
  //   // );
  // }
}
