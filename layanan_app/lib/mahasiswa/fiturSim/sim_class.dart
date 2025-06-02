import 'package:flutter/material.dart';
import 'package:layanan_app/mahasiswa/fiturSim/sim_absen.dart';

class SimClass extends StatefulWidget {
  final userIdSim;
  final userNameSim;

  const SimClass({Key key, this.userIdSim, this.userNameSim}) : super(key: key);

  @override
  State<SimClass> createState() => _SimClassState();
}

class _SimClassState extends State<SimClass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "CLASS",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color.fromARGB(255, 255, 221, 27),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Course Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.book, size: 50, color: Colors.grey),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "8TII011 - TUGAS AKHIR Kelas : A",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "Minggu, [07:00:00 - 11:30:00]",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.check_circle, color: Colors.green),
                      ],
                    ),
                    SizedBox(height: 30),
                    // Menu Options
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Icon(Icons.file_present, color: Colors.blue),
                            SizedBox(height: 4),
                            Text("Bahan\nPerkuliahan",
                                textAlign: TextAlign.center),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            print("Tangkep2" + "${widget.userIdSim}");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PresensiPage(
                                      userIdSim: widget.userIdSim,
                                      userNameSim: widget.userNameSim)),
                            );
                          },
                          child: Column(
                            children: [
                              Icon(Icons.fact_check, color: Colors.blue),
                              SizedBox(height: 4),
                              Text("Presensi\nPerkuliahan",
                                  textAlign: TextAlign.center),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Icon(Icons.assignment, color: Colors.blue),
                            SizedBox(height: 4),
                            Text("Tugas\nPerkuliahan",
                                textAlign: TextAlign.center),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Icons.edit, color: Colors.blue),
                            SizedBox(height: 4),
                            Text("UTS"),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
