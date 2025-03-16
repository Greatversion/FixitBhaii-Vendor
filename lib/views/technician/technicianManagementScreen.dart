import 'package:auto_route/auto_route.dart';
import 'package:fixitbhaiivendor/routes/app.routes.gr.dart';
import 'package:flutter/material.dart';
import 'package:fixitbhaiivendor/utils/themes/app.colors.dart';

@RoutePage()
class TechnicianManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppColors.textPrimary,
        title: Text(
          "Manage Technicians",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            _buildTechnicianCard(
                context, "Rahul Sharma", "AC Repair", "9876543210", true),
            _buildTechnicianCard(
                context, "Amit Verma", "TV Repair", "9988776655", false),
            _buildTechnicianCard(
                context, "Vikas Gupta", "Laptop Fix", "9123456789", true),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to Add Technician Page
          AutoRouter.of(context).push(AddEditTechnicianRoute());
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildTechnicianCard(BuildContext context, String name,
      String expertise, String phone, bool available) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      color: AppColors.textPrimary,
      child: ListTile(
        leading: CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage("assets/images/profile_pic.png")),
        title: Text(name, style: TextStyle(color: Colors.white)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Expertise: $expertise", style: TextStyle(color: Colors.grey)),
            Text("Phone: $phone", style: TextStyle(color: Colors.grey)),
            Row(
              children: [
                Icon(
                  available ? Icons.check_circle : Icons.cancel,
                  color: available ? Colors.green : Colors.red,
                  size: 16,
                ),
                SizedBox(width: 5),
                Text(available ? "Available" : "Unavailable",
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
                      .push(EditTechnicianRoute(technicianData: {}));
                }),
            IconButton(
                icon: Icon(Icons.delete, color: Colors.redAccent),
                onPressed: () {}),
          ],
        ),
        onTap: () {
          // View Technician Details
        },
      ),
    );
  }
}
