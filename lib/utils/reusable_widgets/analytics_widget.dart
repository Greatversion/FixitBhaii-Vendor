// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:fixitbhaiivendor/utils/themes/app.colors.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

// Data Model for Charts with Colors
class ChartData {
  final String category;
  final double value;
  final Color color;
  ChartData(this.category, this.value, this.color);
}

// Weekly Sales Data with Custom Colors
List<ChartData> getWeeklySalesData() {
  return [
    ChartData("AC Repair", 15, Colors.blueAccent),
    ChartData("TV Repair", 10, Colors.greenAccent),
    ChartData("Laptop Fix", 20, Colors.orangeAccent),
    ChartData("Fridge Repair", 8, Colors.purpleAccent),
  ];
}

// Monthly Sales Data with Custom Colors
List<ChartData> getMonthlySalesData() {
  return [
    ChartData("AC Repair", 50, Colors.blue),
    ChartData("TV Repair", 30, Colors.green),
    ChartData("Laptop Fix", 70, Colors.orange),
    ChartData("Fridge Repair", 25, Colors.purple),
  ];
}

// Technician Work Data with Custom Colors
List<ChartData> getTechnicianWorkData() {
  return [
    ChartData("Rahul", 40, Colors.cyan),
    ChartData("Amit", 35, Colors.amber),
    ChartData("Vikas", 50, Colors.redAccent),
    ChartData("Suresh", 30, Colors.lime),
  ];
}

// Service Type Data with Custom Colors
List<ChartData> getServiceTypeData() {
  return [
    ChartData("Electronics", 40, Colors.deepOrange),
    ChartData("Home Appliances", 35, Colors.indigo),
    ChartData("Computer Repairs", 25, Colors.teal),
  ];
}

// Function to build a donut chart with colors
Widget buildDonutChart(
    BuildContext context, String title, List<ChartData> data) {
  return Column(
    children: [
      Text(title, style: Theme.of(context).textTheme.titleMedium),
      ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          color: Theme.of(context).cardTheme.color,
          height: 300, // Adjust height as needed
          child: SfCircularChart(
            legend: Legend(
              isVisible: true,
              position: LegendPosition.right,
              textStyle: Theme.of(context).textTheme.titleSmall,
            ),
            series: <CircularSeries>[
              DoughnutSeries<ChartData, String>(
                dataSource: data,
                xValueMapper: (ChartData data, _) => data.category,
                yValueMapper: (ChartData data, _) => data.value,
                pointColorMapper: (ChartData data, _) =>
                    data.color, // Custom colors
                dataLabelSettings: DataLabelSettings(
                  isVisible: true,
                  textStyle: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget buildPieChart(context, String title, List<ChartData> data) {
  return Column(
    children: [
      Text(title,
          style: Theme.of(context).textTheme.titleMedium),
      SizedBox(height: 10),
      SizedBox(
        height: 310,
        child: SfCircularChart(
          legend: Legend(
              isVisible: true,
              position: LegendPosition.bottom,
              textStyle: TextStyle(color: Colors.white)),
          series: <PieSeries<ChartData, String>>[
            PieSeries<ChartData, String>(
              dataSource: data,
              xValueMapper: (ChartData data, _) => data.category,
              yValueMapper: (ChartData data, _) => data.value,
              pointColorMapper: (ChartData data, _) => data.color,
              dataLabelSettings: DataLabelSettings(
                  isVisible: true, textStyle: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildBarChart(context,String title, List<ChartData> data) {
  return Column(
    children: [
      Text(title,
        style: Theme.of(context).textTheme.titleMedium),
      SizedBox(height: 10),
      SizedBox(
        height: 250,
        child: SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          series: <CartesianSeries>[
            BarSeries<ChartData, String>(
              dataSource: data,
              xValueMapper: (ChartData data, _) => data.category,
              yValueMapper: (ChartData data, _) => data.value,
              pointColorMapper: (ChartData data, _) => data.color,
              dataLabelSettings: DataLabelSettings(isVisible: true),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildLineChart(context,String title, List<ChartData> data) {
  return Column(
    children: [
      Text(title,
         style: Theme.of(context).textTheme.titleMedium),
      SizedBox(height: 10),
      SizedBox(
        height: 250,
        child: SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          primaryYAxis: NumericAxis(),
          series: <CartesianSeries>[
            LineSeries<ChartData, String>(
              dataSource: data,
              xValueMapper: (ChartData data, _) => data.category,
              yValueMapper: (ChartData data, _) => data.value,
              pointColorMapper: (ChartData data, _) => data.color,
              dataLabelSettings: DataLabelSettings(isVisible: true),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildRadialGauge(String title, double value) {
  return Column(
    children: [
      Text(title,
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
      SizedBox(height: 10),
      SizedBox(
        height: 200,
        child: SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(
              minimum: 0,
              maximum: 100,
              ranges: <GaugeRange>[
                GaugeRange(startValue: 0, endValue: 50, color: Colors.red),
                GaugeRange(startValue: 50, endValue: 75, color: Colors.orange),
                GaugeRange(startValue: 75, endValue: 100, color: Colors.green),
              ],
              pointers: <GaugePointer>[NeedlePointer(value: value)],
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                  widget: Text('$value%',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  angle: 90,
                  positionFactor: 0.5,
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}
