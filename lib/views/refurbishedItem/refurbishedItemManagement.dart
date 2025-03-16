import 'package:auto_route/auto_route.dart';
import 'package:fixitbhaiivendor/routes/app.routes.gr.dart';
import 'package:flutter/material.dart';
import 'package:fixitbhaiivendor/utils/themes/app.colors.dart';

@RoutePage()
class RefurbishedItemsManagementScreen extends StatelessWidget {
  const RefurbishedItemsManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppColors.textPrimary,
        title: Text(
          "Manage Refurbished Items",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            childAspectRatio: 0.8,
          ),
          itemCount: refurbishedItems.length,
          itemBuilder: (context, index) {
            final item = refurbishedItems[index];
            return _buildItemCard(context, item);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to Add Refurbished Item Page
          AutoRouter.of(context).push(AddEditRefurbishedItemRoute());
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildItemCard(BuildContext context, Map<String, dynamic> item) {
    return Card(
      color: AppColors.textPrimary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.asset(
                item['image'],
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'],
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  "₹${item['price']}  (Discount: ${item['discount']}%)",
                  style: TextStyle(color: Colors.greenAccent, fontSize: 12),
                ),
                SizedBox(height: 4),
                Text(
                  "Stock: ${item['stock']}",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blueAccent),
                      onPressed: () {
                        AutoRouter.of(context)
                            .push(RefurbishedItemsManagementRoute());
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Dummy Data
final List<Map<String, dynamic>> refurbishedItems = [
  {
    "name": "HP Laptop",
    "price": 25000,
    "discount": 10,
    "stock": 5,
    "image": "assets/images/image.jpeg",
  },
  {
    "name": "Samsung Smart TV",
    "price": 32000,
    "discount": 15,
    "stock": 2,
    "image": "assets/images/image.jpeg",
  },
  {
    "name": "Sony Home Theater",
    "price": 15000,
    "discount": 5,
    "stock": 10,
    "image": "assets/images/image.jpeg",
  },
  {
    "name": "Dell Monitor",
    "price": 12000,
    "discount": 8,
    "stock": 7,
    "image": "assets/images/image.jpeg",
  },
];
