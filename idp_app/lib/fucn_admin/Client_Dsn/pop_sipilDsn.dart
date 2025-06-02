import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:idp_app/fucn_admin/Client_Dsn/sipil_clientDsn.dart';

import '../../api/link.dart';
import 'package:cool_alert/cool_alert.dart';

import 'elektro_clientDsn.dart';

class LockDialogSipil extends StatefulWidget {
  final String appUser;
  final String userId;
  final List<String> nameClient;
  final List<String> clientId;
  final List<String> isLocked;

  LockDialogSipil(
      {this.appUser,
      this.isLocked,
      this.nameClient,
      this.userId,
      this.clientId});

  @override
  _LockDialogSipilState createState() => _LockDialogSipilState();
}

class _LockDialogSipilState extends State<LockDialogSipil> {
  int columnCount = 1; // Number of columns (you can adjust this as needed)
  int itemsPerColumn;
  DateTime tgl = new DateTime.now();

  @override
  void initState() {
    itemsPerColumn = (widget.nameClient.length / columnCount).ceil();
    // TODO: implement initState
    super.initState();
  }

  void lockedApp(String clientId) {
    var url = Uri.parse(ApiConstants.baseUrl +
        "api/getClient/LockedClient/index/${widget.userId}");
    http.put(url, body: {
      "user_id": "${widget.userId}",
      "client_id": clientId,
      "client_secret": "locked",
      "image": "locked",
    });
  }
  //  body: {
  //         "name_client": nameClient,
  //         "user_id": "${payload['data']['id']}",
  //         "user_status": "${userStatus}",
  //         "create_at": "${tgl}",
  //         "image": imageClient
  //       },

  void unlockedApp(String namesApp) {
    var url = Uri.parse(ApiConstants.baseUrl +
        "api/getclient/UnlockedClient/create_applicationDosen");
    http.post(url, body: {
      "name_client": unLockedClients,
      "user_id": "${widget.userId}",
      "create_at": "$tgl",
      "image": unImageClients,
    });
  }

  // unLockedClients = [
  //   "Sistem Informasi Manajemen",
  //   "Lab Teknik Sipil",
  //   "Kuliah Kerja Nyata",
  //   "Sistem Monitoring Tugas Akhir",
  //   "SISTER",
  //   "SINTA",
  //   "SIMPEL"
  // ];

  // unImageClients = [
  //         "sim",
  //         "lab_te",
  //         "kkn",
  //         "simonta",
  //         "sister",
  //         "sinta",
  //         "simpel"
  //       ];

  String unLockedClients;
  String unImageClients;

  Future<void> unlockedClientsSSODsn(String namesAPP) async {
    switch (namesAPP) {
      case 'Sistem Informasi Manajemen':
        unLockedClients = "Sistem Informasi Manajemen";
        unImageClients = "sim";
        unlockedApp(namesAPP);
        break;
      case 'Lab Teknik Sipil':
        unLockedClients = "Lab Teknik Sipil";
        unImageClients = "lab_te";
        unlockedApp(namesAPP);
        break;
      case 'Kuliah Kerja Nyata':
        unLockedClients = "Kuliah Kerja Nyata";
        unImageClients = "kkn";
        unlockedApp(namesAPP);
        break;
      case 'Sistem Monitoring Tugas Akhir':
        unLockedClients = "Sistem Monitoring Tugas Akhir";
        unImageClients = "simonta";
        unlockedApp(namesAPP);
        break;
      case 'SISTER':
        unLockedClients = "SISTER";
        unImageClients = "sister";
        unlockedApp(namesAPP);
        break;
      case 'SINTA':
        unLockedClients = "SINTA";
        unImageClients = "sinta";
        unlockedApp(namesAPP);
        break;
      case 'SIMPEL':
        unLockedClients = "SIMPEL";
        unImageClients = "simpel";
        unlockedApp(namesAPP);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Aplikasi User '${widget.appUser}'",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: List.generate(columnCount, (colIndex) {
                return Expanded(
                  child: Column(
                    children: List.generate(itemsPerColumn, (rowIndex) {
                      int itemIndex = colIndex * itemsPerColumn + rowIndex;
                      if (itemIndex < widget.nameClient.length) {
                        return _buildMenuItem(context, itemIndex);
                      } else {
                        return SizedBox.shrink(); // Empty space for extra rows
                      }
                    }),
                  ),
                );
              }),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Menutup dialog
              },
              child: Text('Close'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, int index) {
    return Card(
      child: ListTile(
        leading: Icon(
          // widget.isLocked[index] ? Icons.lock : Icons.lock_open,
          // color: widget.isLocked[index] ? Colors.red : Colors.green,
          widget.isLocked[index] == "locked" ? Icons.lock : Icons.lock_open,
          color: widget.isLocked[index] == "locked" ? Colors.red : Colors.green,
        ),
        title: Text(widget.nameClient[index]),
        onTap: () async {
          print("Value of widget.isLocked[$index]: ${widget.isLocked[index]}");
          setState(() {
            if (widget.isLocked[index] != "locked") {
              CoolAlert.show(
                context: context,
                type: CoolAlertType.confirm,
                text: "Apakah yakin locked aplikasi ini ?",
                confirmBtnText: 'Yes',
                cancelBtnText: "Cancel",
                onConfirmBtnTap: () async {
                  widget.isLocked[index] = widget.isLocked[index] == "locked"
                      ? "unlocked"
                      : "locked";
                  lockedApp(widget.clientId[index]);

                  // widget.isLocked[index] =
                  //     widget.isLocked[index] == "locked"
                  //         ? "unlocked"
                  //         : "locked";
                  // unlockedClientsSSODsn(widget.nameClient[index]);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => allDsnSipil()),
                  );
                },
                onCancelBtnTap: () async {
                  Navigator.pop(context);
                },
              );
            } else {
              CoolAlert.show(
                context: context,
                type: CoolAlertType.confirm,
                text: "Apakah yakin membuka locked aplikasi ini ?",
                confirmBtnText: 'Yes',
                cancelBtnText: "Cancel",
                onConfirmBtnTap: () async {
                  widget.isLocked[index] = widget.isLocked[index] == "locked"
                      ? "unlocked"
                      : "locked";
                  unlockedClientsSSODsn(widget.nameClient[index]);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => allDsnSipil()),
                  );
                },
                onCancelBtnTap: () async {
                  Navigator.pop(context);
                },
              );
            }
          });
        },
      ),
    );
  }
}
