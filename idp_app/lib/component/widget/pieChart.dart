import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';

import '../../api/link.dart';

// }

Future<List<String>> fetchStatusData() async {
  final response =
      await http.get(Uri.parse(ApiConstants.baseUrl + 'api/CrudUser/index'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    final List<dynamic> data = jsonResponse['data'];
    return data.map((item) => item['status'] as String).toList();
  } else {
    throw Exception('Failed to load data');
  }
}

class StatusPieChart extends StatelessWidget {
  final Map<String, int> statusCount;

  StatusPieChart({this.statusCount});

  @override
  Widget build(BuildContext context) {
    int total = (statusCount['true'] ?? 0) + (statusCount['false'] ?? 0);
    double truePercentage =
        total > 0 ? ((statusCount['true'] ?? 0) / total) * 100 : 0;

    return Container(
      width: 400, // Set width of the container
      height: 400, // Set height of the container
      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(
                  color: Colors.green,
                  value: (statusCount['true'] ?? 0).toDouble(),
                  title: 'Online',
                  radius: 100,
                ),
                PieChartSectionData(
                  color: Colors.red,
                  value: (statusCount['false'] ?? 0).toDouble(),
                  title: 'Offline',
                  radius: 100,
                ),
              ],
              centerSpaceRadius: 80,
              sectionsSpace: 0,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Online',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                '${truePercentage.toStringAsFixed(1)}%',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                '${statusCount['true']} Users SSO Online',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Map<String, int> countStatus(List<String> statusData) {
  int trueCount = 0;
  int falseCount = 0;

  if (statusData != null) {
    for (var status in statusData) {
      if (status == 'true') {
        trueCount++;
      } else if (status == 'false') {
        falseCount++;
      }
    }
  }

  return {
    'true': trueCount,
    'false': falseCount,
  };
}
