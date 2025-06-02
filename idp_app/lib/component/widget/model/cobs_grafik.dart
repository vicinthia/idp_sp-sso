import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataProcessor {
  List<Map<String, dynamic>> addTimestamps(List<dynamic> rawData) {
    DateTime currentTime = DateTime.now();
    List<Map<String, dynamic>> dataWithTimestamps = [];

    for (var entry in rawData) {
      dataWithTimestamps.add({
        'timestamp': currentTime,
        'status': entry['status'],
      });
    }

    return dataWithTimestamps;
  }

  List<int> processData(List<Map<String, dynamic>> dataWithTimestamps) {
    List<int> hourlyCounts = List.filled(24, 0);

    for (var entry in dataWithTimestamps) {
      DateTime timestamp = entry['timestamp'];
      String status = entry['status'];
      if (status == 'true') {
        hourlyCounts[timestamp.hour]++;
      }
    }

    return hourlyCounts;
  }
}

class ApiService {
  final String apiUrl = 'http://0331kebonagung.ikc.co.id/api/cruduser';

  Future<List<dynamic>> fetchData() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
