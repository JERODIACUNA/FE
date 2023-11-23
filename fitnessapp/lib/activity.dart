import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class BurnedCalories {
  final String time;
  final int calories;

  BurnedCalories(this.time, this.calories);
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ActivityScreen(),
    );
  }
}

class ActivityScreen extends StatefulWidget {
  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  List<String> morningItems = [];
  List<String> eveningItems = [];

  @override
  void initState() {
    super.initState();
    updateData(selectedDay);
  }

  List<charts.Series<BurnedCalories, String>> data = [
    charts.Series<BurnedCalories, String>(
      id: 'BurnedCalories',
      data: [
        BurnedCalories('6 AM', 50),
        BurnedCalories('8 AM', 70),
        BurnedCalories('10 AM', 30),
        BurnedCalories('12 PM', 100),
        BurnedCalories('2 PM', 40),
        BurnedCalories('4 PM', 60),
        BurnedCalories('6 PM', 80),
      ],
      domainFn: (BurnedCalories burned, _) => burned.time,
      measureFn: (BurnedCalories burned, _) => burned.calories,
      colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      labelAccessorFn: (BurnedCalories burned, _) => '${burned.calories}',
    )
  ];

  String selectedDay = 'Mon'; // Initially selected day

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('This Week\'s Activity'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (var day in [
                  'Mon',
                  'Tue',
                  'Wed',
                  'Thu',
                  'Fri',
                  'Sat',
                  'Sun'
                ])
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDay = day;
                          updateData(day); // Update the graph data
                        });
                      },
                      child: Chip(
                        label: Text(day),
                        backgroundColor:
                            selectedDay == day ? Colors.blue : Colors.grey,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  // Add the Text widget here
                  child: const Text(
                    'Burned Calories',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 8), // Adjust spacing as needed
                Container(
                  height: 300, // Set a fixed height for the chart
                  child: charts.BarChart(
                    data,
                    animate: true,
                    vertical: true,
                    domainAxis: const charts.OrdinalAxisSpec(
                      renderSpec:
                          const charts.SmallTickRendererSpec(labelRotation: 60),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Morning Activity',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: morningItems
                        .map(
                          (item) => Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Container(
                              width: 170,
                              height: 80,
                              color: Colors.grey.withOpacity(0.3),
                              alignment: Alignment.center,
                              child: Text(item),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Afternoon Activity',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: eveningItems
                        .map(
                          (item) => Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Container(
                              width: 170,
                              height: 80,
                              color: Colors.grey.withOpacity(0.3),
                              alignment: Alignment.center,
                              child: Text(item),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void updateData(String selectedDay) {
    List<BurnedCalories> updatedData = [];

    // Replace this logic with your actual data for different days
    if (selectedDay == 'Mon') {
      updatedData = [
        BurnedCalories('6 AM', 50),
        BurnedCalories('8 AM', 70),
        BurnedCalories('10 AM', 30),
        BurnedCalories('12 PM', 100),
        BurnedCalories('2 PM', 40),
        BurnedCalories('4 PM', 60),
        BurnedCalories('6 PM', 80),
      ];
    } else if (selectedDay == 'Tue') {
      updatedData = [
        BurnedCalories('6 AM', 60),
        BurnedCalories('8 AM', 80),
        BurnedCalories('10 AM', 40),
        BurnedCalories('12 PM', 100),
        BurnedCalories('2 PM', 50),
        BurnedCalories('4 PM', 70),
        BurnedCalories('6 PM', 90),
      ];
    } else if (selectedDay == 'Wed') {
      updatedData = [
        BurnedCalories('6 AM', 30),
        BurnedCalories('8 AM', 70),
        BurnedCalories('10 AM', 50),
        BurnedCalories('12 PM', 90),
        BurnedCalories('2 PM', 100),
        BurnedCalories('4 PM', 40),
        BurnedCalories('6 PM', 30),
      ];
    } else if (selectedDay == 'Thu') {
      updatedData = [
        BurnedCalories('6 AM', 70),
        BurnedCalories('8 AM', 80),
        BurnedCalories('10 AM', 50),
        BurnedCalories('12 PM', 100),
        BurnedCalories('2 PM', 80),
        BurnedCalories('4 PM', 50),
        BurnedCalories('6 PM', 60),
      ];
    } else if (selectedDay == 'Fri') {
      updatedData = [
        BurnedCalories('6 AM', 70),
        BurnedCalories('8 AM', 80),
        BurnedCalories('10 AM', 90),
        BurnedCalories('12 PM', 40),
        BurnedCalories('2 PM', 100),
        BurnedCalories('4 PM', 30),
        BurnedCalories('6 PM', 50),
      ];
    } else if (selectedDay == 'Sat') {
      updatedData = [
        BurnedCalories('6 AM', 20),
        BurnedCalories('8 AM', 60),
        BurnedCalories('10 AM', 100),
        BurnedCalories('12 PM', 80),
        BurnedCalories('2 PM', 60),
        BurnedCalories('4 PM', 50),
        BurnedCalories('6 PM', 70),
      ];
    } else if (selectedDay == 'Sun') {
      updatedData = [
        BurnedCalories('6 AM', 20),
        BurnedCalories('8 AM', 60),
        BurnedCalories('10 AM', 100),
        BurnedCalories('12 PM', 40),
        BurnedCalories('2 PM', 70),
        BurnedCalories('4 PM', 40),
        BurnedCalories('6 PM', 50),
      ];
    }

    if (selectedDay == 'Mon') {
      morningItems = [
        'Monday Activity 1',
        'Monday Activity 2',
        'Monday Activity 3'
      ];
      eveningItems = [
        'Monday Activity 1',
        'Monday Activity 2',
        'Monday Activity 3'
      ];
      // Update your chart data accordingly
      // ...
    } else if (selectedDay == 'Tue') {
      morningItems = [
        'Tuesday Activity 1',
        'Tuesday Activity 2',
        'Tuesday Activity 3'
      ];
      eveningItems = [
        'Tuesday Activity 1',
        'Tuesday Activity 2',
        'Tuesday Activity 3'
      ];
      // Update your chart data accordingly
      // ...
    } else if (selectedDay == 'Wed') {
      morningItems = [
        'Wednesday Activity 1',
        'Wednesday Activity 2',
        'Wednesday Activity 3'
      ];
      eveningItems = [
        'Wednesday Activity 1',
        'Wednesday Activity 2',
        'Wednesday Activity 3'
      ];
      // Update your chart data accordingly
      // ...
    } else if (selectedDay == 'Thu') {
      morningItems = [
        'Thursday Activity 1',
        'Thursday Activity 2',
        'Thursday Activity 3'
      ];
      eveningItems = [
        'Thursday Activity 1',
        'Thursday Activity 2',
        'Thursday Activity 3'
      ];
      // Update your chart data accordingly
      // ...
    } else if (selectedDay == 'Fri') {
      morningItems = [
        'Friday Activity 1',
        'Friday Activity 2',
        'Friday Activity 3'
      ];
      eveningItems = [
        'Friday Activity 1',
        'Friday Activity 2',
        'Friday Activity 3'
      ];
      // Update your chart data accordingly
      // ...
    } else if (selectedDay == 'Sat') {
      morningItems = [
        'Saturday Activity 1',
        'Saturday Activity 2',
        'Saturday Activity 3'
      ];
      eveningItems = [
        'Saturday Activity 1',
        'Saturday Activity 2',
        'Saturday Activity 3'
      ];
      // Update your chart data accordingly
      // ...
    } else if (selectedDay == 'Sun') {
      morningItems = [
        'Sunday Activity 1',
        'Sunday Activity 2',
        'Sunday Activity 3'
      ];
      eveningItems = [
        'Sunday Activity 1',
        'Sunday Activity 2',
        'Sunday Activity 3'
      ];
      // Update your chart data accordingly
      // ...
    }
    // Repeat the same for other days...

    setState(() {
      data = [
        charts.Series<BurnedCalories, String>(
          id: 'BurnedCalories',
          data: updatedData,
          domainFn: (BurnedCalories burned, _) => burned.time,
          measureFn: (BurnedCalories burned, _) => burned.calories,
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          labelAccessorFn: (BurnedCalories burned, _) => '${burned.calories}',
        )
      ];
    });
  }
}
