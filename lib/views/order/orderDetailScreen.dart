import 'package:auto_route/auto_route.dart';
import 'package:fixitbhaiivendor/utils/themes/app.colors.dart';
import 'package:flutter/material.dart';

@RoutePage()
class OrderDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.textPrimary,
      appBar: AppBar(
        title: Text("Order Details",  style: TextStyle(color: Colors.white),),
        backgroundColor: AppColors.textPrimary,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("Order Summary"),
            _buildOrderSummary(),
            SizedBox(height: 16),
            _buildSectionTitle("Customer Details"),
            _buildCustomerDetails(),
            SizedBox(height: 16),
            _buildSectionTitle("Order Status"),
            _buildOrderStatus(),
            SizedBox(height: 16),
            _buildSectionTitle("Payment Info"),
            _buildPaymentInfo(),
            SizedBox(height: 20),
            _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
          fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.white),
    );
  }

  Widget _buildOrderSummary() {
    return Card(
      color: AppColors.textPrimary,
      child: ListTile(
        leading: Icon(Icons.build, color: AppColors.white),
        title:
            Text(order["serviceName"], style: TextStyle(color: Colors.white)),
        subtitle: Text(
            "Order ID: ${order["orderId"]}\nBooked for: ${order["date"]} at ${order["time"]}",
            style: TextStyle(color: Colors.white70)),
      ),
    );
  }

  Widget _buildCustomerDetails() {
    return Card(
      color: AppColors.textPrimary,
      child: ListTile(
        leading: Icon(Icons.person, color: AppColors.white),
        title:
            Text(order["customerName"], style: TextStyle(color: Colors.white)),
        subtitle: Text(
            "${order["customerAddress"]}\nPhone: ${order["customerPhone"]}",
            style: TextStyle(color: Colors.white70)),
        trailing: IconButton(
          icon: Icon(Icons.phone, color: Colors.green),
          onPressed: () {
            // Call customer action
          },
        ),
      ),
    );
  }

  Widget _buildOrderStatus() {
    return Card(
      color: AppColors.textPrimary,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Status:", style: TextStyle(color: Colors.white70)),
            DropdownButton<String>(
              value: order["status"],
              dropdownColor: AppColors.textPrimary,
              style: TextStyle(color: Colors.white),
              iconEnabledColor: Colors.white,
              onChanged: (String? newValue) {
                // Update order status logic
              },
              items: <String>[
                "Pending",
                "In Progress",
                "Completed",
                "Cancelled"
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentInfo() {
    return Card(
      color: AppColors.textPrimary,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Total Amount: ₹${order["amount"]}",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text("Payment Mode: ${order["paymentMode"]}",
                style: TextStyle(color: Colors.white70)),
            Text("Payment Status: ${order["paymentStatus"]}",
                style: TextStyle(
                    color: order["paymentStatus"] == "Paid"
                        ? Colors.green
                        : Colors.red)),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          icon: Icon(Icons.check),
          label: Text("Mark Completed"),
          onPressed: () {
            // Mark as completed action
          },
        ),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          icon: Icon(Icons.cancel),
          label: Text("Cancel Order"),
          onPressed: () {
            // Cancel order action
          },
        ),
      ],
    );
  }
}
