import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:idp_app/component/widget/brnd_dashboard.dart';
import 'package:idp_app/component/widget/grafik.dart';
import 'package:idp_app/component/widget/model/jml_online.dart';
import 'package:idp_app/component/widget/model/take_jml.dart';
import 'dart:async';

import 'package:idp_app/component/widget/model/test_grafik.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class dashboard extends StatefulWidget {
  @override
  _dashboardState createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 83, 192),
        title: Text("Dashboard"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: Container(
                  // color: Colors.pink,
                  margin: EdgeInsets.only(top: 5, bottom: 10),
                  // width: 200,
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Text(
                      "DASHBOARD SISTEM SINGLE SIGN ON (SSO) UBHARA",
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: Container(
                  // color: Colors.pink,
                  margin: EdgeInsets.only(top: 5, bottom: 10),
                  // width: 200,
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Text(
                      "Grafik Pengguna SSO Online Harian",
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
            // SizedBox(
            //   height: 20,
            // ),
            Center(
              child: Container(
                height: 700,
                width: 800,
                child: PageView(
                  children: [
                    LineChartPage(),
                    // TestGrafik()
                    // // grafik(),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );

    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('User Status Chart'),
    //   ),
    //   body: FutureBuilder<List<jmlOnline>>(
    //     future: futureUserData,
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return Center(child: CircularProgressIndicator());
    //       } else if (snapshot.hasError) {
    //         return Center(child: Text('Error: ${snapshot.error}'));
    //       } else {
    //         fetchDataAndUpdateChart();
    //         return LineChart(
    //           LineChartData(
    //             lineBarsData: [
    //               LineChartBarData(
    //                 spots: hourlyOnlineUsers.entries.map((entry) {
    //                   return FlSpot(
    //                       entry.key.toDouble(), entry.value.toDouble());
    //                 }).toList(),
    //                 isCurved: true,
    //                 gradient: LinearGradient(
    //                   colors: gradientColors,
    //                   begin: Alignment.bottomCenter,
    //                   end: Alignment.topCenter,
    //                 ),
    //                 barWidth: 2,
    //                 belowBarData: BarAreaData(
    //                   show: true,
    //                   gradient: LinearGradient(
    //                     colors: gradientColors
    //                         .map((color) => color.withOpacity(0.3))
    //                         .toList(),
    //                     begin: Alignment.bottomCenter,
    //                     end: Alignment.topCenter,
    //                   ),
    //                 ),
    //               ),
    //             ],
    //             titlesData: FlTitlesData(
    //               leftTitles: AxisTitles(
    //                 sideTitles: SideTitles(showTitles: true),
    //               ),
    //               bottomTitles: AxisTitles(
    //                 sideTitles: SideTitles(
    //                   showTitles: true,
    //                   getTitlesWidget: (value, meta) {
    //                     return Text(value.toInt().toString());
    //                   },
    //                 ),
    //               ),
    //             ),
    //             borderData: FlBorderData(show: true),
    //             gridData: FlGridData(show: true),
    //           ),
    //         );
    //       }
    //     },
    //   ),
    // );
  }
}
