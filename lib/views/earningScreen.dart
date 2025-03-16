import 'package:auto_route/auto_route.dart';
import 'package:fixitbhaiivendor/utils/themes/app.colors.dart';
import 'package:flutter/material.dart';

@RoutePage()
class EarningsScreen extends StatefulWidget {
  @override
  _EarningsScreenState createState() => _EarningsScreenState();
}

class _EarningsScreenState extends State<EarningsScreen> {
  String selectedFilter = "All";
  List<Map<String, dynamic>> transactions = [
    {
      "id": "#TXN12345",
      "amount": 2500,
      "date": "2025-02-16",
      "type": "Earnings",
      "status": "Success",
    },
    {
      "id": "#TXN67890",
      "amount": -1000,
      "date": "2025-02-15",
      "type": "Withdrawal",
      "status": "Pending",
    },
    {
      "id": "#TXN11223",
      "amount": 3500,
      "date": "2025-02-14",
      "type": "Earnings",
      "status": "Success",
    },
  ];

  List<String> filters = ["All", "Earnings", "Withdrawals"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Earnings & Transactions",
          style: TextStyle(color: Colors.white),
        ),
        // backgroundColor: Colors.black,
      ),
      // backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Earnings Overview
            _buildEarningsOverview(),

            SizedBox(height: 20),

            // Filters
            _buildFilters(),

            SizedBox(height: 10),

            // Transaction History List
            Expanded(child: _buildTransactionList()),

            SizedBox(height: 10),

            // Withdraw Button
            _buildWithdrawButton(),
          ],
        ),
      ),
    );
  }

  // Earnings Overview Section
  Widget _buildEarningsOverview() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.electricBlue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Total Earnings", style: TextStyle(color: Colors.white70)),
          SizedBox(height: 5),
          Text("₹50,000",
              style: TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 22,
                  fontWeight: FontWeight.bold)),
          Divider(color: Colors.white24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _earningsDetail("Pending", "₹5,000", Colors.amber),
              _earningsDetail("Withdrawn", "₹45,000", Colors.blueAccent),
            ],
          ),
        ],
      ),
    );
  }

  Widget _earningsDetail(String title, String amount, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(color: Colors.white70)),
        Text(amount,
            style: TextStyle(
                color: color, fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  // Filter Chips
  Widget _buildFilters() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: filters.map((filter) {
        return ChoiceChip(
          label: Text(filter,
              style: TextStyle(
                      color: selectedFilter == filter
                          ? Colors.black
                          : const Color.fromARGB(179, 68, 67, 67))
                  .copyWith(fontWeight: FontWeight.bold)),
          selected: selectedFilter == filter,
          selectedColor: Colors.blueAccent,
          backgroundColor: Theme.of(context).cardTheme.color,
          onSelected: (bool selected) {
            setState(() {
              selectedFilter = filter;
            });
          },
        );
      }).toList(),
    );
  }

  // Transaction List
  Widget _buildTransactionList() {
    List<Map<String, dynamic>> filteredTransactions = transactions
        .where(
            (txn) => selectedFilter == "All" || txn["type"] == selectedFilter)
        .toList();

    return ListView.builder(
      itemCount: filteredTransactions.length,
      itemBuilder: (context, index) {
        var txn = filteredTransactions[index];
        return Card(
          color: Theme.of(context).cardTheme.color,
          child: ListTile(
            leading: Icon(
              txn["type"] == "Earnings"
                  ? Icons.attach_money
                  : Icons.outbox_outlined,
              color: txn["type"] == "Earnings" ? Colors.green : Colors.red,
            ),
            title: Text(
              txn["id"],
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              txn["date"],
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "${txn["amount"] > 0 ? "+" : ""}₹${txn["amount"]}",
                  style: TextStyle(
                    color: txn["amount"] > 0
                        ? const Color.fromARGB(255, 7, 73, 41)
                        : Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ).copyWith(fontSize: 14),
                ),
                Text(
                  txn["status"],
                  style: TextStyle(
                    color: txn["status"] == "Success"
                        ? const Color.fromARGB(255, 25, 144, 29)
                        : txn["status"] == "Pending"
                            ? Colors.amber
                            : Colors.red,
                    fontSize: 16,
                  ).copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Withdraw Money Button
  Widget _buildWithdrawButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Withdraw Money Logic
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.electricBlue,
          padding: EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          "Withdraw Money",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
