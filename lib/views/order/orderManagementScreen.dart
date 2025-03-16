import 'package:auto_route/auto_route.dart';
import 'package:fixitbhaiivendor/utils/themes/app.colors.dart';
import 'package:flutter/material.dart';

@RoutePage()
class OrderManagementScreen extends StatefulWidget {
  const OrderManagementScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OrderManagementScreenState createState() => _OrderManagementScreenState();
}

class _OrderManagementScreenState extends State<OrderManagementScreen> {
  String selectedStatus = "All";
  String selectedPayment = "All";
  List<Map<String, dynamic>> filteredOrders = [];

  List<Map<String, dynamic>> orders = [
    {
      "orderId": "FBH12345",
      "serviceName": "AC Repair",
      "date": "2025-02-20",
      "customerName": "Amit Sharma",
      "status": "Pending",
      "amount": 1200,
      "paymentStatus": "Paid",
    },
    {
      "orderId": "FBH12346",
      "serviceName": "Laptop Repair",
      "date": "2025-02-21",
      "customerName": "Rohit Verma",
      "status": "In Progress",
      "amount": 1800,
      "paymentStatus": "Pending",
    },
    {
      "orderId": "FBH12347",
      "serviceName": "Refrigerator Repair",
      "date": "2025-02-22",
      "customerName": "Neha Gupta",
      "status": "Completed",
      "amount": 2200,
      "paymentStatus": "Paid",
    },
    {
      "orderId": "FBH12348",
      "serviceName": "Smart TV Installation",
      "date": "2025-02-23",
      "customerName": "Siddharth Mishra",
      "status": "Cancelled",
      "amount": 700,
      "paymentStatus": "Refunded",
    },
  ];

  @override
  void initState() {
    super.initState();
    filteredOrders = orders;
  }

  void filterOrders() {
    setState(() {
      filteredOrders = orders.where((order) {
        bool statusMatch =
            selectedStatus == "All" || order["status"] == selectedStatus;
        bool paymentMatch = selectedPayment == "All" ||
            order["paymentStatus"] == selectedPayment;
        return statusMatch && paymentMatch;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.electricBlue,
        title: Text(
          "Manage Orders",
          style: TextStyle(color: Colors.white),
        ),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.search),
        //     onPressed: () {
        //       // Implement search functionality
        //     },
        //   ),
        // ],
      ),
      body: Column(
        children: [
          // Filters Section
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  style: Theme.of(context).textTheme.titleMedium,
                  value: selectedStatus,
                  items: [
                    "All",
                    "Pending",
                    "In Progress",
                    "Completed",
                    "Cancelled"
                  ]
                      .map((status) =>
                          DropdownMenuItem(value: status, child: Text(status)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedStatus = value!;
                      filterOrders();
                    });
                  },
                ),
                DropdownButton<String>(
                  value: selectedPayment,
                  items: ["All", "Paid", "Pending", "Refunded"]
                      .map((payment) => DropdownMenuItem(
                          value: payment, child: Text(payment)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedPayment = value!;
                      filterOrders();
                    });
                  },
                ),
              ],
            ),
          ),

          // Order List
          Expanded(
            child: ListView.builder(
              itemCount: filteredOrders.length,
              itemBuilder: (context, index) {
                final order = filteredOrders[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  color: Theme.of(context).cardTheme.color,
                  child: ListTile(
                    leading: CircleAvatar(
                        backgroundImage:
                            AssetImage("assets/images/profile_pic.png")),
                    title: Text(
                      order["serviceName"],
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "Order ID: ${order["orderId"]}\nDate: ${order["date"]}\nCustomer: ${order["customerName"]}",
                      style: Theme.of(context).textTheme.titleMedium!,
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("₹${order["amount"]}",
                            style: TextStyle(
                                color: AppColors.successGreen,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                        SizedBox(height: 5),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: order["status"] == "Completed"
                                ? Colors.green
                                : order["status"] == "Pending"
                                    ? Colors.orange
                                    : order["status"] == "Cancelled"
                                        ? Colors.red
                                        : Colors.blue,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            order["status"],
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      // Navigate to Order Details Screen
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
