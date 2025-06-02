// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class jmlOnline {
//   final String status;

//   jmlOnline({this.status});

//   factory jmlOnline.fromJson(Map<String, dynamic> json) {
//     return jmlOnline(
//       status: json['status'],
//     );
//   }
// }

// Future<List<jmlOnline>> fetchUserOnline() async {
//   final response =
//       await http.get(Uri.parse('http://0331kebonagung.ikc.co.id/api/cruduser'));

//   if (response.statusCode == 200) {
//     Map<String, dynamic> jsonResponse = json.decode(response.body);
//     List<dynamic> data = jsonResponse['data'];
//     return data.map((item) => jmlOnline.fromJson(item)).toList();
//   } else {
//     throw Exception('Failed to load data');
//   }
// }

// class grafik extends StatefulWidget {
//   @override
//   State<grafik> createState() => _grafikState();
// }

// class _grafikState extends State<grafik> {
//   Future<List<jmlOnline>> futureUserData;
//   Map<int, int> hourlyOnlineUsers = {};

//   final List<Color> gradientColors = [
//     const Color(0xff23b6e6),
//     const Color(0xff02d39a),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     futureUserData = fetchUserOnline();
//     // Timer.periodic(Duration(hours: 1), (timer) {
//     //   fetchDataAndUpdateChart();
//     // });
//     Timer.periodic(Duration(hours: 1), (timer) {
//       fetchDataAndUpdateChart();
//     });
//   }

//   void fetchDataAndUpdateChart() async {
//     List<jmlOnline> users = await fetchUserOnline();
//     int currentHour = DateTime.now().hour;

//     int onlineUsersCount =
//         users.where((user) => user.status.toLowerCase() == 'true').length;
//     setState(() {
//       hourlyOnlineUsers[currentHour] = onlineUsersCount;
//       clearOldData();
//     });
//   }

//   void clearOldData() {
//     DateTime now = DateTime.now();
//     hourlyOnlineUsers.removeWhere((key, value) {
//       return now
//               .difference(DateTime(now.year, now.month, now.day, key))
//               .inHours >
//           24;
//     });
//   }

//   @override
//   Widget build(BuildContext context) => FutureBuilder<List<jmlOnline>>(
//         future: futureUserData,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             fetchDataAndUpdateChart();
//             double maxY = hourlyOnlineUsers.values.isNotEmpty
//                 ? ((hourlyOnlineUsers.values.reduce((a, b) => a > b ? a : b) /
//                                 5)
//                             .ceil() *
//                         5)
//                     .toDouble()
//                 : 5.0;
//             return Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: LineChart(
//                 LineChartData(
//                   minX: 0,
//                   maxX: 23,
//                   minY: 0,
//                   maxY: maxY,
//                   titlesData: LineTitles.getTitleData(hourlyOnlineUsers),
//                   gridData: FlGridData(
//                     show: true,
//                     getDrawingHorizontalLine: (value) {
//                       return FlLine(
//                         color: const Color(0xff37434d),
//                         strokeWidth: 1,
//                       );
//                     },
//                     drawVerticalLine: true,
//                     getDrawingVerticalLine: (value) {
//                       return FlLine(
//                         color: const Color(0xff37434d),
//                         strokeWidth: 1,
//                       );
//                     },
//                   ),
//                   borderData: FlBorderData(
//                     show: true,
//                     border:
//                         Border.all(color: const Color(0xff37434d), width: 1),
//                   ),
//                   lineBarsData: [
//                     LineChartBarData(
//                       spots: hourlyOnlineUsers.entries.map((entry) {
//                         return FlSpot(
//                             entry.key.toDouble(), entry.value.toDouble());
//                       }).toList(),
//                       isCurved: true,
//                       gradient: LinearGradient(
//                         colors: gradientColors,
//                         begin: Alignment.bottomCenter,
//                         end: Alignment.topCenter,
//                       ),
//                       barWidth: 5,
//                       belowBarData: BarAreaData(
//                         show: true,
//                         gradient: LinearGradient(
//                           colors: gradientColors
//                               .map((color) => color.withOpacity(0.3))
//                               .toList(),
//                           begin: Alignment.bottomCenter,
//                           end: Alignment.topCenter,
//                         ),
//                       ),
//                       dotData: FlDotData(
//                         show: true,
//                         getDotPainter: (spot, percent, barData, index) {
//                           return FlDotCirclePainter(
//                             radius: 4,
//                             color: gradientColors[1],
//                             strokeWidth: 2,
//                             strokeColor: Colors.white,
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }
//         },
//       );
// }

// class LineTitles {
//   static FlTitlesData getTitleData(Map<int, int> minuteOnlineUsers) =>
//       FlTitlesData(
//         bottomTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: true,
//             reservedSize: 35,
//             getTitlesWidget: (value, meta) {
//               TextStyle style = TextStyle(
//                 color: Color(0xff68737d),
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16,
//               );

//               // Show titles based on data points
//               if (value % 2 == 0) {
//                 return SideTitleWidget(
//                   axisSide: meta.axisSide,
//                   space: 8,
//                   child: Text('${value.toInt()}', style: style),
//                 );
//               } else {
//                 return SizedBox.shrink(); // Hide titles not present in data
//               }
//             },
//           ),
//         ),
//         leftTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: true,
//             reservedSize: 80,
//             getTitlesWidget: (value, meta) {
//               // Display only multiples of 5 on the Y-axis
//               if (value % 1 == 0) {
//                 TextStyle style = TextStyle(
//                   color: Color(0xff68737d),
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16,
//                 );
//                 return SideTitleWidget(
//                   axisSide: meta.axisSide,
//                   space: 8,
//                   child: Text('${value.toInt()}', style: style),
//                 );
//               } else {
//                 return SizedBox.shrink(); // Hide non-multiples of 5
//               }
//             },
//           ),
//         ),
//       );
// }
