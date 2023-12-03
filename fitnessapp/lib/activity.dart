import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:charts_flutter/flutter.dart' as charts;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Activies',
      home: ActivityScreen(),
    );
  }
}

class ActivityScreen extends StatefulWidget {
  @override
  _FirebaseDataScreenState createState() => _FirebaseDataScreenState();
}

class _FirebaseDataScreenState extends State<ActivityScreen> {
  List<Map<String, dynamic>> _daysData = []; // List to store days data
  String? _selectedDay; // Currently selected day
  String? _selectedMorningActivity; // Currently selected morning activity
  String? _selectedAfternoonActivity; // Currently selected afternoon activity

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://sara-fb2f2-default-rtdb.asia-southeast1.firebasedatabase.app/.json'));

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      if (decodedData['activity'] != null) {
        List<dynamic> days = decodedData['activity'].values.toList();
        setState(() {
          _daysData = days.cast<Map<String, dynamic>>(); // Update days data
          _selectedDay = null; // Clear selected day
          _selectedMorningActivity = null; // Clear selected morning activity
          _selectedAfternoonActivity =
              null; // Clear selected afternoon activity
        });
      }
    } else {
      setState(() {
        _daysData = []; // Clear data in case of failure
        _selectedDay = null; // Clear selected day
        _selectedMorningActivity = null; // Clear selected morning activity
        _selectedAfternoonActivity = null; // Clear selected afternoon activity
      });
    }
  }

  Widget buildActivitiesList(String title, List<String> activities,
      String? selectedActivity, Function(int) onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: activities.length,
            itemBuilder: (context, index) {
              String activity = activities[index];
              bool isSelected = activity == selectedActivity;

              return GestureDetector(
                onTap: () {}, // No action on tap
                child: Container(
                  width: 120,
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.blue : null,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: isSelected ? Colors.blue : Colors.black,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      activity,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activity'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _daysData.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> dayData = _daysData[index];
                bool isSelected = dayData['days'] == _selectedDay;

                return InkWell(
                  onTap: () {
                    setState(() {
                      _selectedDay = isSelected ? null : dayData['days'];
                      _selectedMorningActivity =
                          null; // Clear selected morning activity
                      _selectedAfternoonActivity =
                          null; // Clear selected afternoon activity
                    });
                  },
                  child: Card(
                    color: isSelected ? Colors.blue : null,
                    margin: EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          dayData['days'],
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (_selectedDay != null && _daysData.isNotEmpty)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildActivitiesList(
                      'Morning Activity',
                      List.generate(
                          3,
                          (index) => _daysData.firstWhere((day) =>
                                  day['days'] ==
                                  _selectedDay)['morningActivity']
                              ['morningActivity${index + 1}']),
                      _selectedMorningActivity,
                      (index) {},
                    ),
                    buildActivitiesList(
                      'Afternoon Activity',
                      List.generate(
                          3,
                          (index) => _daysData.firstWhere((day) =>
                                  day['days'] ==
                                  _selectedDay)['afternoonActivity']
                              ['afternoonActivity${index + 1}']),
                      _selectedAfternoonActivity,
                      (index) {},
                    ),
                    SizedBox(
                      height: 350,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Burned Calories',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Expanded(
                            child: charts.BarChart(
                              [
                                charts.Series<ChartData, String>(
                                  id: 'Sales',
                                  colorFn: (_, __) =>
                                      charts.MaterialPalette.blue.shadeDefault,
                                  domainFn: (ChartData sales, _) => sales.day,
                                  measureFn: (ChartData sales, _) =>
                                      sales.sales,
                                  data: [
                                    ChartData('Day 1', 30),
                                    ChartData('Day 2', 50),
                                    ChartData('Day 3', 80),
                                    ChartData('Day 4', 20),
                                    ChartData('Day 5', 60),
                                    ChartData('Day 6', 70),
                                    ChartData('Day 7', 40),
                                  ],
                                )
                              ],
                              animate: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class ChartData {
  final String day;
  final double sales;

  ChartData(this.day, this.sales);
}
