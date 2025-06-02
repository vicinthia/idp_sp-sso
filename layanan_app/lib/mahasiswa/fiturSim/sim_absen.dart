import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../api/link_sp.dart';

class PresensiPage extends StatefulWidget {
  final userIdSim;
  final userNameSim;

  const PresensiPage({Key key, this.userIdSim, this.userNameSim})
      : super(key: key);

  @override
  _PresensiPageState createState() => _PresensiPageState();
}

class _PresensiPageState extends State<PresensiPage> {
  bool _hasCheckedIn = false;
  List<Map<String, dynamic>> _attendanceRecords = [];

  @override
  void initState() {
    super.initState();
    _checkIfCheckedInToday(); // Check if the user has already checked in today
    _fetchAttendanceRecords(); // Load the monthly attendance records
  }

  // Function to check if the user has already checked in today
  Future<void> _checkIfCheckedInToday() async {
    final prefs = await SharedPreferences.getInstance();
    String idPresent = prefs.getString('setUserIdSim') ?? "";
    final id = "${idPresent}";
    final now = DateTime.now();
    final date =
        "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

    final url = Uri.parse(
        AksesSIM.UrlSim_Sp + 'api/Attendance/check_in?user_id=$id&date=$date');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      if (responseBody['success'] == true &&
          responseBody['checked_in_today'] == true) {
        setState(() {
          _hasCheckedIn = true;
        });
      }
    }
  }

  // Function to fetch monthly attendance records
  Future<void> _fetchAttendanceRecords() async {
    final prefs = await SharedPreferences.getInstance();
    String idPresent = prefs.getString('setUserIdSim') ?? "";
    final id = "${idPresent}"; // Replace with actual user ID if available
    final now = DateTime.now();
    final month = "${now.year}-${now.month.toString().padLeft(2, '0')}";

    final url = Uri.parse(AksesSIM.UrlSim_Sp +
        'api/Attendance/get_attendance?user_id=$id&month=$month');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      print("Response Records: $responseBody");
      if (responseBody['success'] == true) {
        setState(() {
          _attendanceRecords =
              List<Map<String, dynamic>>.from(responseBody['data']);
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to fetch attendance records")),
      );
    }
  }

  // Function to handle attendance check-in
  Future<void> _checkIn() async {
    if (_hasCheckedIn) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Anda Telah Presensi"),
            content: Text("Anda telah presensi hari ini."),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    final now = DateTime.now();
    final date = "${now.year}-${now.month}-${now.day}";

    final url = Uri.parse(AksesSIM.UrlSim_Sp + 'api/Attendance/check_in');
    final response = await http.post(
      url,
      // headers: {"Content-Type": "application/json"},
      body: {
        'user_id': "${widget.userIdSim}",
        'name': "${widget.userNameSim}",
        'date': date,
        'checked_in_at': now.toIso8601String(),
      },
    );

    final responseBody = jsonDecode(response.body);
    print("Response Body: $responseBody");

    if (response.statusCode == 200 && responseBody['success'] == true) {
      setState(() {
        _hasCheckedIn = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Attendance recorded for $date")),
      );
      _fetchAttendanceRecords(); // Refresh attendance table
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(responseBody['message'] ?? "Failed to check in")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Presensi Perkuliahan",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color.fromARGB(255, 255, 221, 27),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(
                Icons.fingerprint,
                size: 100,
                color: _hasCheckedIn ? Colors.green : Colors.grey,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _checkIn,
                child: Text(
                  _hasCheckedIn ? "Already Checked In" : "Check In",
                  style: TextStyle(
                      color: _hasCheckedIn ? Colors.white : Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: _hasCheckedIn
                        ? Colors.grey
                        : Color.fromARGB(255, 255, 221, 27)),
              ),
              SizedBox(height: 20),
              _buildAttendanceTable(), // Display attendance records table
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAttendanceTable() {
    return _attendanceRecords.isEmpty
        ? Text("No attendance records found")
        : DataTable(
            columns: [
              DataColumn(
                  label: Text(
                "Tanggal",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              DataColumn(
                  label: Text(
                "Waktu Presensi",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              DataColumn(
                  label: Text(
                "Kehadiran Status",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
            ],
            rows: _attendanceRecords.map((record) {
              return DataRow(
                cells: [
                  DataCell(Text(record['date'])),
                  DataCell(Text(record['checked_in_at'])),
                  DataCell(Text(
                      record['checked_in_at'] != null ? "Present" : "Absent")),
                ],
              );
            }).toList(),
          );
  }
}
