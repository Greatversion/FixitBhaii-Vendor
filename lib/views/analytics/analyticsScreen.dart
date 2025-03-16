import 'package:auto_route/auto_route.dart';
import 'package:fixitbhaiivendor/utils/reusable_widgets/analytics_widget.dart';
import 'package:flutter/material.dart';
import 'package:fixitbhaiivendor/utils/themes/app.colors.dart';

@RoutePage()
class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: Icon(Icons.download),
              onPressed: () {},
            ),
          )
        ],
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("FixitBhaii Vendor Analytics",
            style: TextStyle(color: Colors.white)),
        // backgroundColor: AppColors.electricBlue,
        // iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Wrap(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(context, "Sales Overview"),
            Expanded(
                child: buildDonutChart(
                    context, "Weekly Sales", getWeeklySalesData())),
            SizedBox(width: 10),
            Expanded(
                child: buildDonutChart(
                    context, "Monthly Sales", getMonthlySalesData())),
            SizedBox(height: 20),
            _buildSectionTitle(context, "Technician Work Stats"),
            buildPieChart(context, "Technician Work", getTechnicianWorkData()),
            SizedBox(height: 20),
            _buildSectionTitle(context, "Service Type Distribution"),
            buildBarChart(context, "Service Types", getServiceTypeData()),
            SizedBox(height: 20),
            _buildSectionTitle(context, "Earnings Over Time"),
            buildLineChart(context, "Earnings Trend", [
              ChartData("Jan", 12000, Colors.blue),
              ChartData("Feb", 15000, Colors.green),
              ChartData("Mar", 18000, Colors.orange),
              ChartData("Apr", 22000, Colors.red),
              ChartData("May", 25000, Colors.purple),
            ]),
            SizedBox(height: 20),
            _buildSectionTitle(context, "Performance Meter"),
            buildRadialGauge("Technician Efficiency", 75),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(context, String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4),
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
