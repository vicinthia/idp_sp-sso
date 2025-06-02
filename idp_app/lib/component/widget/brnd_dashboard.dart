import 'package:flutter/material.dart';
import 'package:idp_app/component/widget/grafik.dart';

import 'package:idp_app/component/widget/pieChart.dart';

class LineChartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        color: Color.fromARGB(255, 226, 226, 255),
        child: FutureBuilder<List<String>>(
          future: fetchStatusData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final statusCount = countStatus(snapshot.data);
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StatusPieChart(statusCount: statusCount),
                    SizedBox(height: 20),
                    Text(
                      'Online: ${statusCount['true']}',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Offline: ${statusCount['false']}',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      );
}
