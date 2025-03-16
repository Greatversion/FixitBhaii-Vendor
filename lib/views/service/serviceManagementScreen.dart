import 'package:auto_route/auto_route.dart';
import 'package:fixitbhaiivendor/routes/app.routes.gr.dart';
import 'package:flutter/material.dart';
import 'package:fixitbhaiivendor/utils/themes/app.colors.dart';

@RoutePage()
class ServiceManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppColors.textPrimary,
        title: Text(
          "Manage Services",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            _buildServiceCard(context, "AC Repair", "₹500", "2 hrs", true),
            _buildServiceCard(context, "TV Repair", "₹400", "1.5 hrs", true),
            _buildServiceCard(context, "Laptop Fix", "₹800", "3 hrs", false),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to Add Service Page
          AutoRouter.of(context).push(AddEditServiceRoute());
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context, String name, String price,
      String duration, bool active) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      color: AppColors.textPrimary,
      child: ListTile(
        leading: Image.asset("assets/images/fann.jpg"),
        title: Text(name, style: TextStyle(color: Colors.white)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Price: $price", style: TextStyle(color: Colors.grey)),
            Text("Duration: $duration", style: TextStyle(color: Colors.grey)),
            Row(
              children: [
                Icon(
                  active ? Icons.check_circle : Icons.cancel,
                  color: active ? Colors.green : Colors.red,
                  size: 16,
                ),
                SizedBox(width: 5),
                Text(active ? "Active" : "Inactive",
                    style: TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                icon: Icon(Icons.edit, color: Colors.blueAccent),
                onPressed: () {
                  AutoRouter.of(context)
                      .push(EditServiceRoute(serviceData: {}));
                }),
            IconButton(
                icon: Icon(Icons.delete, color: Colors.redAccent),
                onPressed: () {}),
          ],
        ),
        onTap: () {
          // View Service Details
        },
      ),
    );
  }
}
