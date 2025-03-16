import 'package:auto_route/auto_route.dart';
import 'package:fixitbhaiivendor/routes/app.routes.gr.dart';
import 'package:fixitbhaiivendor/utils/themes/app.colors.dart';
import 'package:flutter/material.dart';

class VendorDrawer extends StatelessWidget {
  final String vendorName;
  final String vendorEmail;
  final String vendorImage;

  const VendorDrawer({
    super.key,
    required this.vendorName,
    required this.vendorEmail,
    required this.vendorImage,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // backgroundColor: AppColors.backgroundDark,
      child: Column(
        children: [
          _buildVendorHeader(),
          Expanded(
            child: ListView(
              children: [
                _buildSectionTitle(context, "Quick Actions"),
                _buildDrawerItem(context, Icons.list_alt, "Active Orders", () {
                  AutoRouter.of(context).push(OrderManagementRoute());
                }),
                _buildDrawerItem(context, Icons.settings, "Manage Services",
                    () {
                  AutoRouter.of(context).push(ServiceManagementRoute());
                }),
                _buildDrawerItem(context, Icons.build, "Manage Technicians",
                    () {
                  AutoRouter.of(context).push(TechnicianManagementRoute());
                }),
                _buildDrawerItem(context, Icons.autorenew, "Refurbished Items",
                    () {
                  AutoRouter.of(context)
                      .push(RefurbishedItemsManagementRoute());
                }),
                _buildDrawerItem(context, Icons.reviews_rounded, "User Reviews",
                    () {
                  AutoRouter.of(context).push(CustomerReviewsRoute());
                }),
                _buildSectionTitle(context, "Analytics"),
                _buildDrawerItem(context, Icons.pie_chart, "View Analytics",
                    () {
                  AutoRouter.of(context).push(AnalyticsRoute());
                }),
                _buildSectionTitle(context, "Finance"),
                _buildDrawerItem(context, Icons.account_balance_wallet,
                    "Wallet & Transactions", () {
                  AutoRouter.of(context).push(EarningsRoute());
                }),
                _buildSectionTitle(context, "Settings & Admin"),
                _buildDrawerItem(
                    context, Icons.chat, "Talk to FixitBhaii Admin", () {
                  Navigator.pushNamed(context, "/settings");
                }),
                _buildDrawerItem(context, Icons.settings, "Settings", () {
                  Navigator.pushNamed(context, "/settings");
                }),
                _buildLogoutButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVendorHeader() {
    return UserAccountsDrawerHeader(
      accountName: Text(vendorName,
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
      accountEmail: Text(vendorEmail),
      currentAccountPicture: CircleAvatar(
        backgroundImage: AssetImage(vendorImage),
      ),
      decoration: BoxDecoration(
        color: AppColors.electricBlue,
      ),
    );
  }

  Widget _buildSectionTitle(context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 12, bottom: 4),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(fontWeight: FontWeight.bold, color: Colors.grey[700]),
      ),
    );
  }

  Widget _buildDrawerItem(
      BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(title,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.bold)),
      onTap: onTap,
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.logout, color: Colors.redAccent),
      title: Text("Logout",
          style: TextStyle(fontSize: 16, color: Colors.redAccent)),
      onTap: () {
        // TODO: Implement logout functionality
        Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
      },
    );
  }
}
