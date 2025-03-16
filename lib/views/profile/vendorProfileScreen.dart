import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

@RoutePage()
class VendorProfileScreen extends StatefulWidget {
  const VendorProfileScreen({super.key});

  @override
  _VendorProfileScreenState createState() => _VendorProfileScreenState();
}

class _VendorProfileScreenState extends State<VendorProfileScreen> {
  File? _profileImage;
  File? _shopBanner;

  final TextEditingController _ownerNameController =
      TextEditingController(text: "Rahul Sharma");
  final TextEditingController _businessNameController =
      TextEditingController(text: "Rahul Electronics");
  final TextEditingController _phoneController =
      TextEditingController(text: "+91 9876543210");
  final TextEditingController _addressController =
      TextEditingController(text: "Lucknow, UP");
  final TextEditingController _gstController =
      TextEditingController(text: "GST1234ABC5678");
  final TextEditingController _bankAccountController =
      TextEditingController(text: "XXXX-1234-5678");
  final TextEditingController _shopEstablishedController =
      TextEditingController(text: "15th March 2015");

  bool _notificationsEnabled = true;

  Future<void> _pickImage(bool isProfile) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        if (isProfile) {
          _profileImage = File(pickedFile.path);
        } else {
          _shopBanner = File(pickedFile.path);
        }
      });
    }
  }

  void _showEditBottomSheet(String title, TextEditingController controller) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
              16, 16, 16, MediaQuery.of(context).viewInsets.bottom + 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter $title",
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {});
                },
                child: const Text("Save"),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Vendor Profile"),
        // backgroundColor: Colors.black,
      ),
      body: ListView(
        children: [
          // Shop Banner
          GestureDetector(
            onTap: () => _pickImage(false),
            child: Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                image: _shopBanner != null
                    ? DecorationImage(
                        image: FileImage(_shopBanner!), fit: BoxFit.cover)
                    : null,
              ),
              child: _shopBanner == null
                  ? const Center(
                      child:
                          Icon(Icons.camera_alt, color: Colors.white, size: 50))
                  : null,
            ),
          ),

          // Profile Image & Vendor Name
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => _pickImage(true),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!)
                        : const AssetImage("assets/images/default_profile.png")
                            as ImageProvider,
                    child: _profileImage == null
                        ? const Icon(Icons.camera_alt,
                            size: 30, color: Colors.white70)
                        : null,
                  ),
                ),
                const SizedBox(height: 10),
                Text(_businessNameController.text,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 111, 110, 110),
                        fontSize: 24,
                        fontWeight: FontWeight.bold)),
                Text("Vendor Name : ${_ownerNameController.text}",
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(fontSize: 16)),
              ],
            ),
          ),

          // Business Information Card with Edit Button
          _buildProfileTile(Icons.store, "Business Info", [
            _buildTileRow("Shop Name", _businessNameController.text),
            _buildTileRow("Owner Name", _ownerNameController.text),
            _buildTileRow("Phone", _phoneController.text),
            _buildTileRow("Address", _addressController.text),
            _buildTileRow("Established On", _shopEstablishedController.text),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () => _showEditBottomSheet(
                    "Business Info", _businessNameController),
                child: const Text("Edit Business Info"))
          ]),

          // Documents & GST Card
          _buildProfileTile(Icons.assignment, "Shop Documents", [
            _buildTileRow("GST Number", _gstController.text),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {}, child: const Text("Upload Documents"))
          ]),

          // Bank Details Card
          _buildProfileTile(Icons.account_balance, "Bank Details", [
            _buildTileRow("Account Number", _bankAccountController.text),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {}, child: const Text("Edit Bank Details"))
          ]),

          // Wallet & Earnings Card
          _buildProfileTile(Icons.account_balance_wallet, "Wallet & Earnings", [
            const Text("Current Balance: ₹12,500",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton(
                    onPressed: () {}, child: const Text("Withdraw Funds")),
                const SizedBox(width: 10),
                OutlinedButton(
                    onPressed: () {},
                    child: Text(
                      "View Transactions",
                      style: Theme.of(context).textTheme.titleMedium,
                    )),
              ],
            ),
          ]),

          // Business Settings Card
          _buildProfileTile(Icons.settings, "Business Settings", [
            SwitchListTile(
              title: Text("Enable Notifications",
                  style: Theme.of(context).textTheme.titleMedium),
              value: _notificationsEnabled,
              activeColor: Colors.green,
              onChanged: (value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
            ),
          ]),

          // Logout Button
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.red),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("Logout",
                  style: TextStyle(fontSize: 18, color: Colors.red)),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildProfileTile(IconData icon, String title, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 24),
              const SizedBox(width: 10),
              Text(title, style: Theme.of(context).textTheme.displayMedium),
            ],
          ),
          const SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }

  Widget _buildTileRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.titleMedium),
          Text(value, style: Theme.of(context).textTheme.displaySmall),
        ],
      ),
    );
  }
}
