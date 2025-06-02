// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class JmlOnline {
//   final String status;

//   JmlOnline({this.status});

//   factory JmlOnline.fromJson(Map<String, dynamic> json) {
//     return JmlOnline(
//       status: json['status'],
//     );
//   }
// }

// Future<List<JmlOnline>> fetchUserOnline() async {
//   final response =
//       await http.get(Uri.parse('http://0331kebonagung.ikc.co.id/api/cruduser'));

//   if (response.statusCode == 200) {
//     final Map<String, dynamic> jsonResponse = json.decode(response.body);
//     final List<dynamic> data = jsonResponse['data'];

//     return data.map((item) => JmlOnline.fromJson(item)).toList();
//   } else {
//     throw Exception('Gagal memuat data');
//   }
// }

// class testGrafik extends StatefulWidget {
//   @override
//   _testGrafikState createState() => _testGrafikState();
// }

// class _testGrafikState extends State<testGrafik> {
//   final StreamController<Map<int, int>> _dataStreamController =
//       StreamController.broadcast();

//   @override
//   void initState() {
//     super.initState();
//     fetchDataAndUpdateChart();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _dataStreamController.close();
//   }

//   Future<void> fetchDataAndUpdateChart() async {
//     try {
//       final users = await fetchUserOnline();
//       final currentHour = DateTime.now().hour;

//       final onlineUsersCount =
//           users.where((user) => user.status.toLowerCase() == 'true').length;

//       _dataStreamController.add({currentHour: onlineUsersCount});
//     } catch (e) {
//       // Tangani kesalahan jika terjadi
//       print('Error fetching data: $e');
//     }
//   }

//   final List<Color> gradientColors = [
//     const Color(0xff23b6e6),
//     const Color(0xff02d39a),
//   ];
//   Widget build(BuildContext context) {
//     return StreamBuilder<Map<int, int>>(
//         stream: _dataStreamController.stream,
//         builder: (context, snapshot) {
//           final hourlyOnlineUsers = snapshot.data ?? {};
//           // ... sisanya sama seperti kode sebelumnya
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
//                   // ... konfigurasi testgrafik lainnya
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
//         });
//   }
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

// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:fl_chart/fl_chart.dart';

// class JmlOnline {
//   final String status;

//   JmlOnline({this.status});

//   factory JmlOnline.fromJson(Map<String, dynamic> json) {
//     return JmlOnline(
//       status: json['status'],
//     );
//   }
// }

// Future<List<JmlOnline>> fetchUserOnline() async {
//   final response =
//       await http.get(Uri.parse('http://0331kebonagung.ikc.co.id/api/cruduser'));

//   if (response.statusCode == 200) {
//     final Map<String, dynamic> jsonResponse = json.decode(response.body);
//     final List<dynamic> data = jsonResponse['data'];

//     return data.map((item) => JmlOnline.fromJson(item)).toList();
//   } else {
//     throw Exception('Gagal memuat data');
//   }
// }

// class TestGrafik extends StatefulWidget {
//   @override
//   _TestGrafikState createState() => _TestGrafikState();
// }

// class _TestGrafikState extends State<TestGrafik> {
//   final StreamController<Map<int, int>> _dataStreamController =
//       StreamController.broadcast();
//   Map<int, int> hourlyOnlineUsers = {}; // Menyimpan data secara global

//   @override
//   void initState() {
//     super.initState();
//     fetchDataAndUpdateChart();
//     Timer.periodic(Duration(hours: 1), (timer) => fetchDataAndUpdateChart());
//   }

//   @override
//   void dispose() {
//     _dataStreamController.close();
//     super.dispose();
//   }

//   Future<void> fetchDataAndUpdateChart() async {
//     try {
//       final users = await fetchUserOnline();
//       final currentHour = DateTime.now().hour;

//       final onlineUsersCount =
//           users.where((user) => user.status.toLowerCase() == 'true').length;

//       setState(() {
//         hourlyOnlineUsers[currentHour] = onlineUsersCount;
//         _dataStreamController.add(hourlyOnlineUsers);
//       });
//     } catch (e) {
//       print('Error fetching data: $e');
//     }
//   }

//   final List<Color> gradientColors = [
//     const Color(0xff23b6e6),
//     const Color(0xff02d39a),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<Map<int, int>>(
//       stream: _dataStreamController.stream,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         } else {
//           final hourlyOnlineUsers = snapshot.data ?? {};
//           double maxY = hourlyOnlineUsers.values.isNotEmpty
//               ? ((hourlyOnlineUsers.values.reduce((a, b) => a > b ? a : b) / 5)
//                           .ceil() *
//                       5)
//                   .toDouble()
//               : 5.0;

//           return Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: LineChart(
//               LineChartData(
//                 minX: 0,
//                 maxX: 23,
//                 minY: 0,
//                 maxY: maxY,
//                 titlesData: LineTitles.getTitleData(hourlyOnlineUsers),
//                 gridData: FlGridData(
//                   show: true,
//                   getDrawingHorizontalLine: (value) {
//                     return FlLine(
//                       color: const Color(0xff37434d),
//                       strokeWidth: 1,
//                     );
//                   },
//                   drawVerticalLine: true,
//                   getDrawingVerticalLine: (value) {
//                     return FlLine(
//                       color: const Color(0xff37434d),
//                       strokeWidth: 1,
//                     );
//                   },
//                 ),
//                 borderData: FlBorderData(
//                   show: true,
//                   border: Border.all(color: const Color(0xff37434d), width: 1),
//                 ),
//                 lineBarsData: [
//                   LineChartBarData(
//                     spots: hourlyOnlineUsers.entries.map((entry) {
//                       return FlSpot(
//                           entry.key.toDouble(), entry.value.toDouble());
//                     }).toList(),
//                     isCurved: true,
//                     gradient: LinearGradient(
//                       colors: gradientColors,
//                       begin: Alignment.bottomCenter,
//                       end: Alignment.topCenter,
//                     ),
//                     barWidth: 5,
//                     belowBarData: BarAreaData(
//                       show: true,
//                       gradient: LinearGradient(
//                         colors: gradientColors
//                             .map((color) => color.withOpacity(0.3))
//                             .toList(),
//                         begin: Alignment.bottomCenter,
//                         end: Alignment.topCenter,
//                       ),
//                     ),
//                     dotData: FlDotData(
//                       show: true,
//                       getDotPainter: (spot, percent, barData, index) {
//                         return FlDotCirclePainter(
//                           radius: 4,
//                           color: gradientColors[1],
//                           strokeWidth: 2,
//                           strokeColor: Colors.white,
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }
//       },
//     );
//   }
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

//               if (value % 2 == 0) {
//                 return SideTitleWidget(
//                   axisSide: meta.axisSide,
//                   space: 8,
//                   child: Text('${value.toInt()}', style: style),
//                 );
//               } else {
//                 return SizedBox.shrink();
//               }
//             },
//           ),
//         ),
//         leftTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: true,
//             reservedSize: 80,
//             getTitlesWidget: (value, meta) {
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
//                 return SizedBox.shrink();
//               }
//             },
//           ),
//         ),
//       );
// }

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';
import 'package:idp_app/component/widget/model/cobs_grafik.dart';

class JmlOnline {
  final String status;

  JmlOnline({this.status});

  factory JmlOnline.fromJson(Map<String, dynamic> json) {
    return JmlOnline(
      status: json['status'],
    );
  }
}

Future<List<JmlOnline>> fetchUserOnline() async {
  final response =
      await http.get(Uri.parse('http://0331kebonagung.ikc.co.id/api/cruduser'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    final List<dynamic> data = jsonResponse['data'];

    return data.map((item) => JmlOnline.fromJson(item)).toList();
  } else {
    throw Exception('Gagal memuat data');
  }
}

class TestGrafik extends StatefulWidget {
  @override
  _TestGrafikState createState() => _TestGrafikState();
}

class _TestGrafikState extends State<TestGrafik> {
  final ApiService apiService = ApiService();
  final DataProcessor dataProcessor = DataProcessor();
  List<int> hourlyCounts = List.filled(24, 0);
  List<Map<String, dynamic>> dataWithTimestamps = [];
  Timer timer;

  @override
  void initState() {
    super.initState();
    fetchAndProcessData();
    timer = Timer.periodic(Duration(minutes: 2), (timer) {
      fetchAndProcessData();
    });
  }

  void fetchAndProcessData() async {
    try {
      List<dynamic> data = await apiService.fetchData();
      List<Map<String, dynamic>> newDataWithTimestamps =
          dataProcessor.addTimestamps(data);
      dataWithTimestamps.addAll(newDataWithTimestamps);
      List<int> processedData = dataProcessor.processData(dataWithTimestamps);
      setState(() {
        hourlyCounts = processedData;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  List<FlSpot> generateSpots() {
    List<FlSpot> spots = [];
    for (int i = 0; i < hourlyCounts.length; i++) {
      spots.add(FlSpot(i.toDouble(), hourlyCounts[i].toDouble()));
    }
    return spots;
  }

  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Chart'),
      ),
      body: Center(
        child: LineChart(
          LineChartData(
            lineBarsData: [
              LineChartBarData(
                spots: generateSpots(),
                isCurved: true,
                barWidth: 2,
                gradient: LinearGradient(
                  colors: gradientColors,
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ],
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
