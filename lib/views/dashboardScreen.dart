import 'package:auto_route/auto_route.dart';
import 'package:fixitbhaiivendor/routes/app.routes.gr.dart';
import 'package:fixitbhaiivendor/services/db.dart';
import 'package:fixitbhaiivendor/utils/drawer/drawer_widget.dart';
import 'package:fixitbhaiivendor/utils/reusable_widgets/analytics_widget.dart';
import 'package:fixitbhaiivendor/utils/reusable_widgets/banner_widget.dart';
import 'package:fixitbhaiivendor/utils/themes/app.colors.dart';
import 'package:fixitbhaiivendor/utils/themes/app.dimensions.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

@RoutePage()
class VendorDashboardScreen extends StatelessWidget {
  const VendorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: VendorDrawer(
        vendorName: "Sumit Kallu",
        vendorEmail: "kalu@fixitbhaii.com",
        vendorImage: "assets/images/profile_pic.png",
      ),
      appBar: AppBar(
        toolbarHeight: Dimensions.screenHeight * 0.08,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              "assets/images/homeLogo.png",
              height: 160,
            ),
            SizedBox(width: 4),
            Text(
              "Vendor\nDashBoard",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 18,
                  color: const Color.fromARGB(255, 177, 176, 176),
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          GestureDetector(
            onTap: () {
              AutoRouter.of(context).push(VendorProfileRoute());
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                child: Icon(Icons.people,
                    color: Theme.of(context).iconTheme.color),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AdminAnnouncementBanner(),
            _buildEarningsCard(context),
            SizedBox(height: 20),
            buildDonutChart(context, "TODAY SALES", getMonthlySalesData()),
            SizedBox(height: 20),
            _buildSectionTitle(context, "QUICK ACTIONS"),
            SizedBox(height: 10),
            _buildQuickActions(context),
            SizedBox(height: 20),
            _buildSectionTitle(context, "ACTIVE SERVICES"),
            SizedBox(height: 10),
            _buildActiveOrdersList(context),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildEarningsCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AutoRouter.of(context).push(EarningsRoute());
      },
      child: Card(
        color: Theme.of(context).cardTheme.color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Today's Earnings",
                  style: Theme.of(context).textTheme.bodyLarge),
              SizedBox(height: 5),
              Text("₹ 5,200", style: Theme.of(context).textTheme.headlineSmall),
              Divider(),
              Text("Total Balance: ₹ 18,750",
                  style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }

  Widget _buildActiveOrdersList(BuildContext context) {
    return Column(
      children: List.generate(3, (index) {
        return Card(
          color: Theme.of(context).cardTheme.color,
          margin: EdgeInsets.symmetric(vertical: 5),
          child: ListTile(
            leading:
                Icon(Icons.build, color: Theme.of(context).iconTheme.color),
            title: Text("Service Order #00\${index + 1}",
                style: Theme.of(context).textTheme.bodyMedium),
            subtitle: Text("Scheduled for Today, 3:00 PM",
                style: Theme.of(context).textTheme.bodySmall),
            trailing: Icon(Icons.arrow_forward_ios,
                color: Theme.of(context).iconTheme.color),
            onTap: () {
              AutoRouter.of(context)
                  .push(OrderDetailsRoute(order: {/* Order details */}));
            },
          ),
        );
      }),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 240,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              _buildActionTile(context, Icons.add, "Add Service", () {
                AutoRouter.of(context).push(AddEditServiceRoute());
              }),
              SizedBox(height: 15),
              _buildActionTile(context, Icons.sell_rounded, "Add Items", () {
                AutoRouter.of(context).push(AddEditRefurbishedItemRoute());
              }),
            ],
          ),
          Column(
            children: [
              _buildActionTile(
                  context, Icons.person_add_alt_1, "Add Technician", () {
                AutoRouter.of(context).push(AddEditTechnicianRoute());
              }),
              SizedBox(height: 15),
              _buildActionTile(
                  context, Icons.notifications_active, "Notifications", () {
                AutoRouter.of(context).push(CustomerReviewsRoute());
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile(
      BuildContext context, IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        height: 100,
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              child: Icon(icon, color: Theme.of(context).iconTheme.color),
            ),
            SizedBox(height: 8),
            Text(label,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
